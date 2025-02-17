#!/bin/bash
set -e  # Exit immediately if any command fails

# Update the system
sudo apt-get update -y

# Install Apache
sudo apt-get install -y apache2

# Start and enable Apache to run on boot
sudo systemctl start apache2
sudo systemctl enable apache2

# Install wget and unzip utilities
sudo apt-get install -y wget unzip

# Change to the web root directory
cd /var/www/html/

# Remove default index.html and any existing content
sudo rm -rf *

# Download and unzip the content from S3 bucket
wget https://vougepay-bucket.s3.us-east-2.amazonaws.com/VoguePay.zip

# Ensure the file was downloaded
if [ -f "VoguePay.zip" ]; then
    # Unzip the content and move it to the web root
    unzip VoguePay.zip
    sudo cp -r VoguePay/* .

    # Clean up the zip file and directory
    sudo rm -rf VoguePay VoguePay.zip
else
    echo "Failed to download VoguePay.zip from S3."
    exit 1
fi

# Set correct permissions for the web root directory
sudo chown -R www-data:www-data /var/www/html/
sudo chmod -R 755 /var/www/html/

# Restart Apache to make sure changes take effect
sudo systemctl restart apache2


