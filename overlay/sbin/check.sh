#!/bin/bash
ACCT="$(curl --max-time 10 -s 169.254.169.254/latest/dynamic/instance-identity/document | jq -r '.accountId')"
re='^[0-9]+$'
if ! [[ "$ACCT" =~ $re ]]; then
  echo "not a number, must not be aws";
else
  echo "yup, in cloud"
fi

# figure out the drive that we are overwriting onto
# just finding what root '/' is mounted to
INSTALL_DRIVE=$(df -h | grep "\s/$" | cut -d ' ' -f1)
