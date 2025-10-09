#!/bin/bash

# Get all AWS regions
regions=$(aws ec2 describe-regions --query "Regions[].RegionName" --output text)

# Loop through each region
for region in $regions; do
  echo "Checking region: $region"

  # List all stack names in the region
  stacks=$(aws cloudformation list-stacks \
    --region $region \
    --query "StackSummaries[?StackStatus!='DELETE_COMPLETE'].StackName" \
    --output text)

  # Loop through each stack and delete it
  for stack in $stacks; do
    echo "Deleting stack: $stack in region: $region"
    aws cloudformation delete-stack --stack-name $stack --region $region
  done
done
