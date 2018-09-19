# Secrets File

For our example, we are using the LUA-DNS certbot module.

We are creating a key `luadns.ini` in a secret, called
"letsencrypt-credentials".  

This secret will be mounted onto the filesystem as a file, under
`/etc/luadns/luadns.ini`.  This is accomplished like so:

Initially, the renewal will be created as a job, run under a service account
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
```

Create the secret from the appropriate file, and link it to the service
account:

```bash

oc secrets link --for=mount certbot letsencrypt-credentials

# Build the image

The image is based on the OpenShift Python builder.
