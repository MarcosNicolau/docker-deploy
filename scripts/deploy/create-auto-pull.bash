source ~/app/.deploy.env
mkdir -p ~/scripts
echo deploy.sh "
DEPLOY_SUCCESS=""
source ~/app/.deploy.env
source ~/app/.docker.env
if [ -z $DOCKER_USERNAME ]
# public repository
then
        MESSAGE=(docker pull $DOCKER_IMAGE_NAME && \
        docker stop app  && \
        docker rm  app && \
        docker run --name app --env-file ~/app/.docker.env -p 8080:$DOCKER_EXPOSE_PORT -d $DOCKER_IMAGE_NAME && \
        DEPLOY_SUCCESS=true 2>&1)
        curl http://host.docker.internal:$PIPELINE_CONTAINER_PORT/deploy/mail?status=$DEPLOY_SUCCESS&log=$MESSAGE
else 
# private repository, we need to login
        MESSAGE=(docker logout && \
        docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD && \
        docker pull $DOCKER_IMAGE_NAME && \
        docker stop app  && \
        docker rm  app && \
        docker run --name app --env-file ~/app/.docker.env -p 8080:$DOCKER_EXPOSE_PORT -d $DOCKER_IMAGE_NAME && \
        curl http://host.docker.internal:$PIPELINE_CONTAINER_PORT/deploy/mail?status=$DEPLOY_SUCCESS&log=$MESSAGE
fi
" > ~/scripts/deploy.sh

chmod +x ~/scripts/deploy.sh
