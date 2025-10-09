#!/bin/bash

# Step 1: Delete all objects and buckets
aws s3 ls | awk '{print $3}' | while read bucket; do
  echo "Emptying bucket: $bucket"
  aws s3 rm s3://$bucket --recursive

  echo "Deleting bucket: $bucket"
  aws s3api delete-bucket --bucket $bucket
done

# Step 2: Show remaining buckets
echo "Remaining buckets:"
aws s3 ls
