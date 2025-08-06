#!/bin/bash

set -e  # Exit immediately if a command fails

ROLE_NAME="Tester-role"
POLICY_NAME="Tester-Policy"

# 1. Create the trust policy that allows IAM users to assume the role
TRUST_POLICY='{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "*"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}'

echo "Creating IAM role: $ROLE_NAME"
aws iam create-role \
  --role-name "$ROLE_NAME" \
  --assume-role-policy-document "$TRUST_POLICY"

# 2. Create an inline policy document for S3 read-only access
POLICY_DOCUMENT='{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "s3:Get*",
        "s3:List*"
      ],
      "Resource": "*"
    }
  ]
}'

echo "Creating IAM policy: $POLICY_NAME"
POLICY_ARN=$(aws iam create-policy \
  --policy-name "$POLICY_NAME" \
  --policy-document "$POLICY_DOCUMENT" \
  --query 'Policy.Arn' --output text)

# 3. Attach the policy to the role
echo "Attaching policy $POLICY_NAME to role $ROLE_NAME"
aws iam attach-role-policy \
  --role-name "$ROLE_NAME" \
  --policy-arn "$POLICY_ARN"

echo "Role '$ROLE_NAME' with read-only S3 access created and policy attached."
