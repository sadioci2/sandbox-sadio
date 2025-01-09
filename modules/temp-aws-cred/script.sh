#!/bin/bash

sleep 5

TEMP_CREDS=$(aws sts assume-role --role-arn "$1" --role-session-name "$2" --output json)

python -c "
import json
import os
temp_creds = json.loads('''$TEMP_CREDS''')

access_key = temp_creds['Credentials']['AccessKeyId']
secret_key = temp_creds['Credentials']['SecretAccessKey']
session_token = temp_creds['Credentials']['SessionToken']

print(f'export AWS_ACCESS_KEY_ID={access_key}')
print(f'export AWS_SECRET_ACCESS_KEY={secret_key}')
print(f'export AWS_SESSION_TOKEN={session_token}')

# Write export commands for environment variables to a file
with open('aws_creds.env', 'w') as f:
    f.write(f'export AWS_ACCESS_KEY_ID={access_key}\\n')
    f.write(f'export AWS_SECRET_ACCESS_KEY={secret_key}\\n')
    f.write(f'export AWS_SESSION_TOKEN={session_token}\\n')
"




