#!/bin/bash

zcat ${APP_DIR}/src/oc.gz > ${APP_DIR}/src/oc
chmod 755 ${APP_DIR}/src/oc

certbot certonly \
  --non-interactive \
  --agree-tos \
  --dns-luadns \
  --dns-luadns-propagation-seconds 120 \
  --config-dir=config/ \
  --work-dir=work/ \
  --logs-dir=logs/ \
  --dns-luadns-credentials=${LE_CREDS_FILE} \
  -m ${LE_EMAIL} \
  -d ${LE_DOMAIN_NAME} 
  
# update the cert

if $?; then
   echo "Updating the router's certificate"
fi

  
  