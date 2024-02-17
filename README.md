# Odoo On-Premise Setup with SSL Certification Renewal

This setup guide covers the configuration and deployment of an Odoo on-premise instance with Nginx as a reverse proxy and automatic SSL certificate renewal and application.

This config has been made for a VPS with 6vcpu 16RAM.

## Files Description

- `odoo.conf`: Configuration file for Odoo.
- `postgres.conf`: Configuration file for PostgreSQL.
- `nginx/`: Directory containing Nginx configuration files.
- `build_image.sh`: Script to build the Odoo image from `odoo.deb`.
- `odoo.deb`: Odoo package, which must be downloaded from [Odoo's official site](https://www.odoo.com/es/page/download).
- `Dockerfile`: Dockerfile used to build the Odoo image.
- `docker-compose.yml`: Docker Compose file to orchestrate the Odoo services on-premise.
- `cert_renew_and_load.sh`: Script used to renew and apply SSL certificates.
- `send_log_via_mailgun.sh`: Script used to send notifications via Mailgun when the SSL certificate has been updated.
- `cronjob`: Cron job entry for renewing the SSL certificate automatically.

## Setup Instructions

1. **Odoo and PostgreSQL Configuration**:

   - Adjust `odoo.conf` and `postgres.conf` according to your specific requirements.
   - Copy all these files to your VPS, e.g., `~/odoo17-enterprise`.

2. **Nginx Setup**:

   - Place your Nginx configuration files in the `nginx/` directory.
   - Ensure Nginx is configured to serve Odoo and handle SSL termination.

3. **Building Odoo Image**:

   - Download `odoo.deb` from the provided link.
   - Run `build_image.sh` to build your Docker image.

4. **Running the Services**:

   - Use `docker-compose up -d` to start the services defined in `docker-compose.yml`.

5. **SSL Certificate Renewal**:
   - Ensure `cert_renew_and_load.sh` and `send_log_via_mailgun.sh` are executable.
   - Update the cron job script with the correct paths and ensure it is added to your crontab.

## Cron Job for SSL Certificate Renewal

To ensure your SSL certificates are automatically renewed, add the following cron job to your system:

0 4 10 \* \* /root/odoo17-enterprise/cert_renew_and_load.sh >> /root/odoo17-enterprise/cert_renew_and_load.log 2>&1; /root/odoo17-enterprise/send_log_via_mailgun.sh

This cron job will attempt to renew the SSL certificate on the 10th of every month at 4:00 AM. After attempting renewal, it will send a log via Mailgun.

## Additional Notes

- Feels free to improve this config.
- Remember to replace placeholders in scripts and configuration files with your actual data, such as domain names, email addresses, and API keys.
- Regularly check the logs for any errors and monitor the SSL certificate's renewal status.

## Support

For additional help or information, please refer to the Odoo documentation or contact support.
