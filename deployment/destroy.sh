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

declare -a INFRA_ORDER=(
  "resources/prod/iam"
  # "resources/dev/rds"
  "resources/dev/sm-retrieval"
  "resources/dev/secret-manager"
  "resources/dev/jump-server"
  "resources/dev/vpc"
  "resources/dev/sg"
  "resources/dev/s3-backend"
)

destroy_infrastructure() {
  local infra_dir="$1"
  echo "Starting destruction for: $infra_dir"
  cd "$REPO_ROOT/$infra_dir" || {
    echo "Error: Unable to access directory $REPO_ROOT/$infra_dir"
    exit 1
  }
  
  echo "Initializing Terraform for $infra_dir..."
  terraform init -input=false || {
    echo "Error: Terraform init failed for $infra_dir"
    exit 1
  }

  echo "Destroying Terraform configuration for $infra_dir..."
  terraform destroy -auto-approve || {
    echo "Error: Terraform destroy failed for $infra_dir"
    exit 1
  }

  echo "Destruction completed for: $infra_dir"
}

# Iterate through the list of infrastructures in reverse order
for ((i=${#INFRA_ORDER[@]}-1; i>=0; i--)); do
  destroy_infrastructure "${INFRA_ORDER[i]}"
done

# Return to the repository root
cd "$REPO_ROOT" || exit 1
echo "All infrastructures have been destroyed successfully!"
