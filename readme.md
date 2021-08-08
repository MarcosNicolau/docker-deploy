# Automated Docker deployments with bash file and CD

This script is to be run on an instance set up. <br/>
Important, before running the script, make sure you have added the IPV4 to your dns. Otherwise, you won't get https <br/>
If the script fails at some stage, it won't stop, but it doesn't matter, just run it again and everything will be overwritten

## How it works

### Steps

1. Update OS
2. Install Docker
3. Nginx set up
4. Get certbot certificate (you will be prompt)
5. Enable HTTP/2
6. Docker login, pull and run
7. Set CD webhook listener

### How to run it

```
git clone https://github.com/MarcosNicolau/docker-deploy.git
chmod +x ./docker-deploy/scripts/deploy/index.bash
./docker-deploy/scripts/deploy/index.bash \
    -a DOMAIN="www.yourwebsite.com yourwebsite.com" \
    -a EMAIL=example@example.com \
    -a DOCKER_IMAGE_NAME=user/imagename:latest \
    -a DOCKER_EXPOSE_PORT=8080 \
    -a CD_PIPELINE_TOKEN=SECRET_TOKEN \
```

## Options

### List of options

#### Required

-   `-a DOMAIN`: your domain.
-   `-a EMAIL`: your email.
-   `-a DOCKER_IMAGE_NAME`: if you are working on a private repo, you will have to pass your docker credentials.
-   `-a DOCKER_EXPOSE_PORT`: the expose port you have set in your image.

#### Optional

if you are working with a private repo, you will have to pass your docker credentials:
-   `-a DOCKER_USERNAME`: your docker username
-   `-a DOCKER_PASSWORD`: your docker password. You should pass an ssh key

Continuos delivery:
If you want to set a webhook listener to pull the image for you, you will have to pass -a CD_PIPELINE_TOKEN=SECRET_TOKEN. <br />
Also, on docker you will have to create a webhook pointing
to the endpoint you provided. More on that in here [docker-webhooks-docs](https://docs.docker.com/docker-hub/webhooks/) <br />
By the way, this the repo we are using for it: [webhook-listener-repo](https://github.com/MarcosNicolau/web-hook-listener)<br />

Options:
-   `-a CD_PIPELINE_ROUTE`: the route for the auto deploy endpoint, it defaults to /deploy
-   `-a CD_PIPELINE_TOKEN`: the token for your webhook
-   `-a PIPELINE_CONTAINER_PORT`: the port you want the webhook to be, it default to 3000

<br />
    If you want to be notified on every pull, you will have to pass an email config:
-   `-a NOTIFICATIONS_EMAIL_HOST`: mail transporter host example `smtp.mandrillapp.com`
-   `-a NOTIFICATIONS_EMAIL_USER`: mail transporter auth user
-   `-a NOTIFICATIONS_EMAIL_PASSWORD`: mail transporter auth password
-   `-a NOTIFICATION_EMAIL_FROM`: mail transporter from
-   `-a NOTIFICATION_EMAIL_TO`: mail transporter to

<b>Alternatively, you can pass all the options in a ~/app/.deploy.env</b>

### Pass env variables to your Docker image

If you need to pass env variables to your image, you can do so by passing -d flag

```
    ./docker-deploy/scripts/deploy/docker-deploy.bash \
        -d ENV_VARIABLE_FOR_CONTAINER_DOCKER=hello!
```

<b>Alternatively, you can pass all the options in a ~/app/.docker.env</b>
