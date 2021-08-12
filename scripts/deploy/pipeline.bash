PATH_TO_DIR=~/docker-deploy
source $PATH_TO_DIR/.deploy.env

# CD
if [ -z $PIPELINE_DEPLOY_ROUTE ];then echo YESSSS EVERYTHING WAS DONE CORRECTLY, CONGRATULATIONS '🎉🎉🎉🎉🎉'  && exit
fi

mkdir -p /scripts

echo ===================================================================================================
echo SETTING PIPELINE...
cp $SCRIPTS_PATH/auto-deploy.bash /scripts/deploy.sh 
cp $PATH_TO_DIR/.deploy.env /scripts/.deploy.env 
cp $PATH_TO_DIR/.docker.env /scripts/.docker.env 

echo ===================================================================================================
echo PULLING PIPELINE IMAGE FROM DOCKER...
docker run  -d -p $PIPELINE_CONTAINER_PORT:3000 \
        --add-host host.docker.internal:host-gateway \
        -v /var/run/docker.sock:/var/run/docker.sock \
        -v /scripts:/scripts \
        --env-file $PATH_TO_DIR/.deploy.env \
        --name webhook \
        marcosnicolau/webhook-listener


echo YESSSS EVERYTHING WAS DONE CORRECTLY, CONGRATULATIONS '🎉🎉🎉🎉🎉'