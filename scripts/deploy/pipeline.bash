# CD
if [ -z $PIPELINE_TOKEN]; then 
        echo YESSSS EVERYTHING WAS DONE CORRECTLY, CONGRATULATIONS '🎉🎉🎉🎉🎉' 
        exit
fi

echo ===================================================================================================
echo SETTING PIPELINE...
if [ -z $PIPELINE_CONTAINER_PORT] ; then PIPELINE_CONTAINER_PORT=8880
fi

chmod +x ./create-auto-pull.bash
./create-auto-pull.bash

echo ===================================================================================================
echo PULLING PIPELINE IMAGE FROM DOCKER...
docker run  -d -p $PIPELINE_CONTAINER_PORT:3000 \
        --add-host host.docker.internal:host-gateway \
        -v /var/run/docker.sock:/var/run/docker.sock \
        -v /path/to/static-docker-binary:/usr/bin/docker \
        -v ~/scripts:~/scripts \
        --env-file ~/app/.deploy.env \
        marcosnicolau/webhook-listener


echo YESSSS EVERYTHING WAS DONE CORRECTLY, CONGRATULATIONS '🎉🎉🎉🎉🎉'