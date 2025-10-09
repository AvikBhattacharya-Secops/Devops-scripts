#!/bin/bash
# List all AWS regions except ap-south-1
regions=$(aws ec2 describe-regions --query "Regions[].RegionName" --output text | tr '\t' '\n' | grep -v '^ap-south-1$')

for region in $regions; do
  echo "Processing region: $region"

  # List all DHCP Option Sets
  dhcp_sets=$(aws ec2 describe-dhcp-options --region $region --query "DhcpOptions[].DhcpOptionsId" --output text)

  for dhcp_id in $dhcp_sets; do
    # Check if the DHCP Option Set is attached to any VPC
    attached_vpcs=$(aws ec2 describe-vpcs --region $region --query "Vpcs[?DhcpOptionsId=='$dhcp_id'].VpcId" --output text)

    if [ -n "$attached_vpcs" ]; then
      for vpc_id in $attached_vpcs; do
        echo "Detaching $dhcp_id from VPC $vpc_id in $region"
        aws ec2 associate-dhcp-options --dhcp-options-id default --vpc-id $vpc_id --region $region
      done
    fi

    echo "Deleting DHCP Option Set: $dhcp_id in $region"
    aws ec2 delete-dhcp-options --dhcp-options-id $dhcp_id --region $region
  done
done
