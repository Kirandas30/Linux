#!/bin/bash

# Variables
AMI_ID="ami-042b4708b1d05f512"   # Ubuntu Server 22.04 LTS for eu-north-1 (Stockholm) — update if needed
INSTANCE_TYPE="t3.micro"
KEY_NAME="MyKeyPair"
KEY_PATH="$HOME/Downloads/MyKeyPair.pem"
SECURITY_GROUP="sg-04793a9b9c95e4bfd"  # Must allow ports 22 and 80 inbound
REGION="eu-north-1"
USER="ubuntu"

# Step 1: Launch EC2 instance
INSTANCE_ID=$(aws ec2 run-instances \
  --image-id "$AMI_ID" \
  --count 1 \
  --instance-type "$INSTANCE_TYPE" \
  --key-name "$KEY_NAME" \
  --security-group-ids "$SECURITY_GROUP" \
  --region "$REGION" \
  --query "Instances[0].InstanceId" \
  --output text)

echo "Launched instance with ID: $INSTANCE_ID"

# Step 2: Wait until instance is running
echo "Waiting for instance to be running..."
aws ec2 wait instance-running --instance-ids "$INSTANCE_ID" --region "$REGION"

# Step 3: Get Public IP
PUBLIC_IP=$(aws ec2 describe-instances \
  --instance-ids "$INSTANCE_ID" \
  --region "$REGION" \
  --query "Reservations[0].Instances[0].PublicIpAddress" \
  --output text)

echo "Instance Public IP: $PUBLIC_IP"

# Step 4: Wait a bit for SSH service
echo "Waiting 30 seconds for SSH service to start..."
sleep 30

# Step 5: SSH and install nginx
echo "Installing nginx on instance..."
ssh -o StrictHostKeyChecking=no -i "$KEY_PATH" $USER@"$PUBLIC_IP" << EOF
  sudo apt update
  sudo apt install -y nginx
  sudo systemctl start nginx
  sudo systemctl enable nginx
EOF

echo "Nginx installed and started on instance."

# Step 6: How to access nginx page
echo "You can access the nginx welcome page in your browser at: http://$PUBLIC_IP"
