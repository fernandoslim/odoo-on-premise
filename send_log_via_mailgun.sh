#!/bin/bash

# Ruta al archivo de log
LOG_FILE="/root/odoo17-enterprise/cert_renew_and_load.log"

# Información de Mailgun
MAILGUN_API_URL="https://api.mailgun.net/v3/example.com/messages"
MAILGUN_API_KEY="YOUT_MAILGUN_API_KEY"
FROM_EMAIL="ODOO <no-reply@example.com>"
TO_EMAIL="fernandoslim@example.com"
SUBJECT="EXAMPLE.COM Cert Renewal Log"
TEXT=$(cat "${LOG_FILE}")

# Envía el correo
curl -s --user "api:${MAILGUN_API_KEY}" \
     "${MAILGUN_API_URL}" \
     -F from="${FROM_EMAIL}" \
     -F to="${TO_EMAIL}" \
     -F subject="${SUBJECT}" \
     -F text="${TEXT}"

# Verifica si el correo fue enviado exitosamente
if [ $? -eq 0 ]; then
    echo "Email sent successfully. Deleting log..."
    > "${LOG_FILE}"
else
    echo "Error sending the email. The log will not be deleted."
fi
