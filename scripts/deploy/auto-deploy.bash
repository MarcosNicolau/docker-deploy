echo "DEPLOY_SUCCESS=" > /scripts/.deploy-success.env

pull_image () {
        # this run outside the session, so we need to call source again
        # if not, DEPLOY_SUCCESS does not get updated
        source /scripts/.deploy-success.env
        docker image tag $DOCKER_IMAGE_NAME $DOCKER_IMAGE_NAME:old && \
        docker pull $DOCKER_IMAGE_NAME && \
        docker stop app  && \
        docker rm  app && \
        docker run --name app --env-file /scripts/.docker.env -p 8080:$DOCKER_EXPOSE_PORT -d $DOCKER_IMAGE_NAME && \
        docker rmi $DOCKER_IMAGE_NAME:old && \
        echo "DEPLOY_SUCCESS=true" > /scripts/.deploy-success.env
}

generate_post_data()
{
  cat <<EOF
{
        "status":"$1",
        "log":"$2"
}
EOF
}


request() {
        # remove the quotes from docker log
        LOG=$(echo $2 | sed 's/"//g')
        DATA=$(generate_post_data "$1" "$LOG") 
        echo $DATA
        curl -X POST http://host.docker.internal:$PIPELINE_CONTAINER_PORT$PIPELINE_DEPLOY_ROUTE/mail \
        -H "Content-Type: application/json" \
        -d "$DATA"
}

if [ -z $DOCKER_USERNAME ]; 
# public repository     
then
        LOG=`pull_image 2>&1`
        # GET DEPLOY SUCCESS
        source /scripts/.deploy-success.env
        request "$DEPLOY_SUCCESS" "$LOG"
        
# private repository, we need to login
else 
        MESSAGE=$(docker logout && \
            docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD && \
            pull_image 2>&1)
        # GET DEPLOY SUCCESS
        source /scripts/.deploy-success.env
        request "$DEPLOY_SUCCESS" "$MESSAGE"
fi