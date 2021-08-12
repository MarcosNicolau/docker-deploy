#!/bin/bash
PATH_TO_DIR=~/docker-deploy
SCRIPTS_PATH=$PATH_TO_DIR/scripts/deploy

# READ ARGS
chmod +x $SCRIPTS_PATH/os.bash
source $SCRIPTS_PATH/read-args.bash


# DEFAULT VARIABLES
chmod +x $SCRIPTS_PATH/default-variables.bash
source $SCRIPTS_PATH/default-variables.bash

# IMPORT VARIABLES
source $PATH_TO_DIR/.deploy.env
source $PATH_TO_DIR/.docker.env

# OS
chmod +x $SCRIPTS_PATH/os.bash
source $SCRIPTS_PATH/os.bash
# NGINX SETUP
chmod +x $SCRIPTS_PATH/nginx.bash
source $SCRIPTS_PATH/nginx.bash
# GET CERTIFICATE
chmod +x $SCRIPTS_PATH/certificate.bash
source $SCRIPTS_PATH/certificate.bash
# HTTP/2
chmod +x $SCRIPTS_PATH/http-2.bash
source $SCRIPTS_PATH/http-2.bash
# DOCKER 
chmod +x $SCRIPTS_PATH/docker.bash
source $SCRIPTS_PATH/docker.bash
# PIPELINE
chmod +x $SCRIPTS_PATH/pipeline.bash
source $SCRIPTS_PATH/pipeline.bash

