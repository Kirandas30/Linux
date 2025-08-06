#!/bin/bash

BUCKET_NAME="static-website-$(uuidgen | tr '[:upper:]' '[:lower:]')"
REGION="eu-north-1"

aws s3api create-bucket --bucket $BUCKET_NAME --region $REGION \
  --create-bucket-configuration LocationConstraint=$REGION

aws s3api put-public-access-block \
  --bucket $BUCKET_NAME \
  --public-access-block-configuration 'BlockPublicAcls=false,IgnorePublicAcls=false,BlockPublicPolicy=false,RestrictPublicBuckets=false'

aws s3 website s3://$BUCKET_NAME/ --index-document index.html

cat <<EOF > index.html
<html><body><h1>Hello from Static Website</h1></body></html>
EOF

aws s3 cp index.html s3://$BUCKET_NAME/

# Public-read bucket policy
cat <<EOF > policy.json
{
  "Version": "2012-10-17",
  "Statement": [{
    "Sid": "PublicReadGetObject",
    "Effect": "Allow",
    "Principal": "*",
    "Action": "s3:GetObject",
    "Resource": "arn:aws:s3:::$BUCKET_NAME/*"
  }]
}
EOF

aws s3api put-bucket-policy --bucket $BUCKET_NAME --policy file://policy.json

echo "Website URL: http://$BUCKET_NAME.s3-website-$REGION.amazonaws.com"
