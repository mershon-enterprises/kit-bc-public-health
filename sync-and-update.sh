#!/bin/bash
echo "IP Address:"
read IP_ADDR
TMP_ZIP_FILE="kit-bc-public-health.zip"
PEMFILE="mershon-enterprises.pem"

ssh -i ~/.ssh/"$PEMFILE" "ec2-user@$IP_ADDR" "cd /var/www/html && zip -q -r /tmp/$TMP_ZIP_FILE ."
scp -i ~/.ssh/"$PEMFILE" "ec2-user@$IP_ADDR:/tmp/$TMP_ZIP_FILE" ./
unzip -q "$TMP_ZIP_FILE"
git add wp-*
git commit -m "Platform update"
rm "$TMP_ZIP_FILE"

./build-bundle.sh
