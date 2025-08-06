#!/bin/bash

# Generate random bucket name
BUCKET_NAME="mybucket-$(uuidgen | tr '[:upper:]' '[:lower:]')"

# Create the bucket
aws s3 mb s3://$BUCKET_NAME
echo "Bucket created: $BUCKET_NAME"

# Create a sample script file
echo -e "#!/bin/bash\necho Hello from script" > sample_script.sh

# Copy script file to S3
aws s3 cp sample_script.sh s3://$BUCKET_NAME/

# List contents of the bucket
echo "Contents of the bucket:"
aws s3 ls s3://$BUCKET_NAME/

# Delete objects and the bucket
aws s3 rm s3://$BUCKET_NAME/ --recursive
aws s3 rb s3://$BUCKET_NAME
echo "Bucket deleted: $BUCKET_NAME"
