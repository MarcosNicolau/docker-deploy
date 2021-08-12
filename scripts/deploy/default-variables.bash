PATH_TO_DIR=~/docker-deploy
source $PATH_TO_DIR/.deploy.env

if [ -z $PIPELINE_DEPLOY_ROUTE ]; then echo 'PIPELINE_DEPLOY_ROUTE=/deploy' >> $PATH_TO_DIR/.deploy.env
fi

if [ -z $PIPELINE_CONTAINER_PORT ]; then echo 'PIPELINE_CONTAINER_PORT=8880' >> $PATH_TO_DIR/.deploy.env
fi

if [ -z $DOCKER_PORT ]; then echo 'DOCKER_PORT=8080' >> $PATH_TO_DIR/.deploy.env
fi
