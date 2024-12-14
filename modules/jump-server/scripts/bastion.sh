#!/bin/bash
sudo -u ubuntu bash <<EOF
cat <<KEYFILE > /home/ubuntu/key.pem
${private_key}
KEYFILE
chmod 400 /home/ubuntu/key.pem
EOF


