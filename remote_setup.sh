
#!/bin/bash
sudo apt update
aws s3 mb s3://my-remote-bucket-$(uuidgen | tr '[:upper:]' '[:lower:]')

# Create access point
BUCKET_NAME=$(aws s3api list-buckets --query 'Buckets[0].Name' --output text)
aws s3control create-access-point --account-id $(aws sts get-caller-identity --query Account --output text)   --name my-access-point-$(date +%s) --bucket $BUCKET_NAME
