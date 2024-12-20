#!/bin/bash

# List of secrets to delete
secrets=("db" "sonarqube" "api_key")

# Specify the region
region="us-east-1"

# Loop through each secret and delete it
for secret in "${secrets[@]}"; do
  aws secretsmanager delete-secret --secret-id "$secret" --force-delete-without-recovery --region "$region"
  echo "Deleted secret: $secret in region $region"
done
