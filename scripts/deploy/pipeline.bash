# CD
echo "NOW LET'S SET UP A CD PIPELINE"
if [-z $DEPLOY_TOKEN] ; then return
fi
if [-z $PIPELINE_CONTAINER_PORT] ; then PIPELINE_CONTAINER_PORT=3000
fi
echo deploy.sh "
DEPLOY_SUCCESS=""
source /app/.deploy.env
source /app/.docker.env
if [ -z $DOCKER_USERNAME ]
then
        MESSAGE=(docker pull $DOCKER_IMAGE_NAME && \
        docker stop app  && \
        docker rm  app && \
        docker run --name app --env-file /app/.docker.env -p 80:$DOCKER_EXPOSE_PORT -d $DOCKER_IMAGE_NAME && \
        DEPLOY_SUCCESS=true 2>&1)
        curl http://host.docker.internal:$PIPELINE_CONTAINER_PORT/mail/deploy?status=$DEPLOY_SUCCESS&log=$MESSAGE
else 
        MESSAGE=(docker logout && \
        docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD && \
        docker pull $DOCKER_IMAGE_NAME && \
        docker stop app  && \
        docker rm  app && \
        docker run --name app --env-file /app/.docker.env -p 80:$DOCKER_EXPOSE_PORT -d $DOCKER_IMAGE_NAME && \
        curl http://host.docker.internal:$PIPELINE_CONTAINER_PORT/mail/deploy?status=$DEPLOY_SUCCESS&log=$MESSAGE
fi
" > /scripts/deploy.sh

chmod +x /scripts/deploy.sh

echo ===================================================================================================
echo PULLING PIPELINE IMAGE FROM DOCKER...
docker run \ 
        --add-host host.docker.internal:host-gateway \
        -p $PIPELINE_CONTAINER_PORT:3000 \
        -v /var/run/docker.sock:/var/run/docker.sock \
        -v /path/to/static-docker-binary:/usr/bin/docker \
        -v /scripts:/scripts \ 
        --env-file /app/.deploy.env 
        marcosnicolau/hook-listener


echo YESSSS EVERYTHING WAS DONE CORRECTLY, CONGRATULATIONS '🎉🎉🎉🎉🎉'