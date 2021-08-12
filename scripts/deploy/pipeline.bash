source $PATH/.deploy.env

# CD
if [ -z $PIPELINE_TOKEN]; then 
        echo YESSSS EVERYTHING WAS DONE CORRECTLY, CONGRATULATIONS '🎉🎉🎉🎉🎉' 
        exit
fi

echo ===================================================================================================
echo SETTING PIPELINE...
cp $SCRIPTS_PATH/auto-deploy.bash /scripts/deploy.sh 
cp $PATH/.deploy.env /scripts/.deploy.env 
cp $PATH/.deploy.env /scripts/.docker.env 

echo ===================================================================================================
echo PULLING PIPELINE IMAGE FROM DOCKER...
docker run  -d -p $PIPELINE_CONTAINER_PORT:3000 \
        --add-host host.docker.internal:host-gateway \
        -v /var/run/docker.sock:/var/run/docker.sock \
        -v /scripts:/scripts \
        --env-file $PATH/.deploy.env \
        --name webhook \
        marcosnicolau/webhook-listener


echo YESSSS EVERYTHING WAS DONE CORRECTLY, CONGRATULATIONS '🎉🎉🎉🎉🎉'