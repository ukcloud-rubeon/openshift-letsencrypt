# Overview

This is an example of an automated task that will renew letsencrypt
certificates, and update a specified router with the new configuration.

It consists of the following:

- Specified route with hostname
- 

# Setup

## Route

The route that handles a particular hostname will be to have the label
`domain` set to this hostname.  This allows the deployment script to
identify the proper route to update.

## Secrets File

The secrets file contains the authentication details for certbot. Depending
on the certbot module used, this will need to be configured in the
`getcert.sh` script.

For our example, we are using the LUA-DNS certbot module.

We are creating a key `luadns.ini` in a secret, called
"letsencrypt-credentials".  

This secret will be mounted onto the filesystem as a file, under
`/etc/luadns/luadns.ini`.  This is accomplished like so:

```bash
oc secret create letsencrypt-credentials --from-file=luadns.ini
```

Initially, the renewal will be created as a CronJob, run under a service account
`certbot`.


```yaml
# certbot-sa.yaml
apiVersion: v1
kind: ServiceAccount
metadata:
    name: certbot

```
```bash
oc create -f certbot-sa.yaml
oc policy add-role-to-user edit certbot
oc policy add-role-to-user view certbot

```

Create the secret from the appropriate file, and link it to the service
account:

```bash
oc secrets link --for=mount certbot letsencrypt-credentials
```

## Build the image

The image is based on the OpenShift Python builder.

```bash
oc create -f certbot-imagestream.yaml
oc create -f certbot-buildconfig.yaml
```

## Create the scheduled job

Check the settings in `certbot-cronjob.yaml`, and once finalized deploy it
with `oc`.

The important values for the certbot script are:

- LE_CREDS_FILE
- LE_EMAIL
- LE_DOMAIN_NAME

These are passed to the `getcert.sh` script.


```bash
oc create -f certbot-cronjob.yaml
```
