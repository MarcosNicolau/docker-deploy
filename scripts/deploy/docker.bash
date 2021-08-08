# DOCKER LOGIN
echo "
📦📦📦📦📦📦📦📦📦📦📦📦📦📦📦📦📦📦📦📦📦📦📦📦📦📦📦📦📦📦📦📦📦📦📦📦📦📦📦📦📦📦📦📦📦📦📦📦📦📦📦
                                                DOCKER TIME
"

# DOCKER LOGIN
if [ -z $DOCKER_USERNAME ]
then 
    # DOCKER RUN
    echo ===================================================================================================
    echo RUNNING IMAGE...
    docker run --name app --env-file ~/app/.docker.env -p 80:$DOCKER_EXPOSE_PORT -d $DOCKER_IMAGE_NAME
else 
    echo ===================================================================================================
    echo LOGING INTO DOCKER..
    docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD

    ==================================================================================================
    echo RUNNING IMAGE...
    docker run --name app --env-file ~/app/.docker.env -p 80:$DOCKER_EXPOSE_PORT -d $DOCKER_IMAGE_NAME
fi

