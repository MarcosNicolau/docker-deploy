source $PATH/.deploy.env

if [ -z $PIPELINE_DEPLOY_ROUTE ]; then echo 'PIPELINE_DEPLOY_ROUTE=/deploy' >> source ~/docker-deploy/.deploy.env
fi

if [ -z $PIPELINE_CONTAINER_PORT ]; then echo 'PIPELINE_CONTAINER_PORT=8880' >> source ~/docker-deploy/.deploy.env
fi

if [ -z $DOCKER_PORT ]; then echo 'DOCKER_PORT=8080' >> source ~/docker-deploy/.deploy.env
fi
