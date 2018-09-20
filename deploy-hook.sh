#!/bin/bash

for DOMAIN in ${RENEWED_DOMAINS}; do 
    # put the key values into environment varibles
    FULL_CHAIN=$(<${RENEWED_LINEAGE}/fullchain.pem)
    PRIVATE_KEY=$(<${RENEWED_LINEAGE}/privkey.pem)
    ROUTE_NAME=$(oc get route -l domain=${DOMAIN} -o jsonpath='{range .items[*]}{.metadata.name}{end}')
    # patch that route
    oc patch route/${ROUTE_NAME} \
    	-p='{"spec":{"tls":{"key":"'${PRIVATE_KEY}'", "certificate":"'${FULL_CHAIN}'"}}'
done
