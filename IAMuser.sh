#!/bin/bash

# Ensure the script exits on any error
set -e

# Define the username
USERNAME="Test"

# Create the IAM user
echo "Creating IAM user: $USERNAME"
aws iam create-user --user-name "$USERNAME"

# Attach AdministratorAccess policy
echo "Attaching AdministratorAccess policy to $USERNAME"
aws iam attach-user-policy \
    --user-name "$USERNAME" \
    --policy-arn arn:aws:iam::aws:policy/AdministratorAccess

echo "User '$USERNAME' created and granted AdministratorAccess."
