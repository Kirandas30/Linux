#!/bin/bash

KEY_NAME="keypair2"
INSTANCE_TYPE="t3.micro"
AMI_ID="ami-042b4708b1d05f512"  # Use valid Ubuntu AMI ID for your region
SECURITY_GROUP="default"

# Create EC2 instance
INSTANCE_ID=$(aws ec2 run-instances \
  --image-id $AMI_ID \
  --count 1 \
  --instance-type $INSTANCE_TYPE \
  --key-name $KEY_NAME \
  --security-groups $SECURITY_GROUP \
  --query "Instances[0].InstanceId" \
  --output text)

echo "EC2 Instance ID: $INSTANCE_ID"

# Wait until instance is running
aws ec2 wait instance-running --instance-ids $INSTANCE_ID

# Get public DNS
PUBLIC_DNS=$(aws ec2 describe-instances \
  --instance-ids $INSTANCE_ID \
  --query "Reservations[0].Instances[0].PublicDnsName" \
  --output text)

echo "Public DNS: $PUBLIC_DNS"

# Create SSH script (assumes you have the key pair file)
cat <<EOF > remote_setup.sh

#!/bin/bash
sudo apt update
aws s3 mb s3://my-remote-bucket-\$(uuidgen | tr '[:upper:]' '[:lower:]')

# Create access point
BUCKET_NAME=\$(aws s3api list-buckets --query 'Buckets[0].Name' --output text)
aws s3control create-access-point --account-id \$(aws sts get-caller-identity --query Account --output text) \
  --name my-access-point-\$(date +%s) --bucket \$BUCKET_NAME
EOF

# Copy script to EC2 instance
scp -i "$KEY_NAME.pem" -o StrictHostKeyChecking=no remote_setup.sh ubuntu@$PUBLIC_DNS:/home/ubuntu/

# SSH into EC2 and run script
ssh -i "$KEY_NAME.pem" ubuntu@$PUBLIC_DNS "bash /home/ubuntu/remote_setup.sh"
