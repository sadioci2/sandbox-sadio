# # Get the root directory of the repository
# REPO_ROOT=$(git rev-parse --show-toplevel 2>/dev/null)

# cd $REPO_ROOT
# cd terraform/resources/dev/vpc
# terraform init 
# terraform fmt
# terraform apply -auto-approve 

# cd $REPO_ROOT
# cd terraform/resources/dev/bastion-host
# terraform init 
# terraform fmt
# terraform apply -auto-approve 

#!/bin/bash

# Exit on errors and print commands for debugging
set -e
set -o pipefail

# Enable debugging if the DEBUG environment variable is set
if [ "$DEBUG" = "true" ]; then
  set -x
fi

# Define the root path for the repository
REPO_ROOT=$(git rev-parse --show-toplevel 2>/dev/null) || {
  echo "Error: Unable to determine the repository root. Ensure you are in a Git repository."
  exit 1
}

# Ensure Terraform is installed and accessible
if ! command -v terraform &>/dev/null; then
  echo "Error: Terraform is not installed or not in the PATH. Please install Terraform and try again."
  exit 1
fi

# Ordered list of infrastructure directories
declare -a INFRA_ORDER=(
  "resources/dev/s3-backend"
  "resources/dev/vpc"
  "resources/dev/sg"
  "resources/dev/jump-server"
  "resources/dev/secret-manager"
  "resources/dev/sm-retrieval"
  #/resources/dev/rds"
  "resources/prod/iam"
  # Add more modules as needed in the desired order
)

# Function to provision a single infrastructure
provision_infrastructure() {
  local infra_dir="$1"
  echo "Starting provisioning for: $infra_dir"

  # Navigate to the infrastructure directory
  cd "$REPO_ROOT/$infra_dir" || {
    echo "Error: Unable to access directory $REPO_ROOT/$infra_dir"
    exit 1
  }

  # Initialize, format, and apply Terraform configuration
  echo "Initializing Terraform for $infra_dir..."
  terraform init -input=false || {
    echo "Error: Terraform init failed for $infra_dir"
    exit 1
  }
  
  echo "Formatting Terraform files in $infra_dir..."
  terraform fmt || {
    echo "Error: Terraform fmt failed for $infra_dir"
    exit 1
  }

  echo "Applying Terraform configuration for $infra_dir..."
  terraform apply -auto-approve || {
    echo "Error: Terraform apply failed for $infra_dir"
    exit 1
  }

  echo "Provisioning completed for: $infra_dir"
}

# Iterate through the list of infrastructures in order
for infra in "${INFRA_ORDER[@]}"; do
  provision_infrastructure "$infra"
done

# Return to the repository root
cd "$REPO_ROOT" || exit 1
echo "All infrastructures have been provisioned successfully!"

