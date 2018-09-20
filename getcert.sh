#!/bin/bash

zcat ${APP_ROOT}/src/oc.gz > ${APP_ROOT}/src/oc
chmod 755 ${APP_ROOT}/src/oc
${APP_ROOT}/src/oc whoami
certbot certonly \
  --non-interactive \
  --agree-tos \
  --dns-luadns \
  --dns-luadns-propagation-seconds 120 \
  --config-dir=config/ \
  --work-dir=work/ \
  --logs-dir=logs/ \
  --deploy-hook=${APP_ROOT}/src/deploy-hook.sh \
  --dns-luadns-credentials=${LE_CREDS_FILE} \
  -m ${LE_EMAIL} \
  -d ${LE_DOMAIN_NAME} 
  
# update the cert


  
  