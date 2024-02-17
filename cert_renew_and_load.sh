#!/bin/bash

# Location of the fullchain.pem certificate file
CERT_FILE="/root/odoo17-enterprise/certbot/conf/live/example.com/fullchain.pem"

# Get the certificate expiration date in epoch format
EXPIRE_DATE=$(openssl x509 -in "$CERT_FILE" -noout -enddate | cut -d= -f2)
EXPIRE_DATE_EPOCH=$(date -d "$EXPIRE_DATE" +%s)

# Get the current date in epoch format
CURRENT_DATE_EPOCH=$(date +%s)

# Calculate the difference in days
DIFF_DAYS=$(( ($EXPIRE_DATE_EPOCH - $CURRENT_DATE_EPOCH) / 86400 ))

# If the certificate expires in the next 30 days, attempt to renew it
if [ $DIFF_DAYS -le 30 ]; then
    echo "Attempting to renew the certificate, which expires in $DIFF_DAYS days."
    cd /root/odoo17-enterprise
    docker-compose run --rm certbot renew
    docker-compose restart nginx
else
    echo "The certificate is still valid for $DIFF_DAYS days; no renewal is needed."
fi

