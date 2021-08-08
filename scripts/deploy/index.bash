#!/bin/bash

# READ ARGS
chmod +x os.bash
source ./read-args.bash

# IMPORT VARIABLES FROM ARGS READING
source ~/app/.deploy.env
source ~/app/.docker.env

# OS
chmod +x os.bash
source ./os.bash
# NGINX SETUP
chmod +x nginx.bash
source ./nginx.bash
# GET CERTIFICATE
chmod +x certificate.bash
source ./certificate.bash
# HTTP/2
chmod +x http-2.bash
source ./http-2.bash
# DOCKER 
chmod +x docker.bash
source ./docker.bash
# PIPELINE
chmod +x pipeline.bash
source ./pipeline.bash

