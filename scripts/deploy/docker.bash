source $PATH/.deploy.env

# DOCKER LOGIN
echo ===================================================================================================
echo DOCKER TIME...

# DO WE NEED TO LOG IN?
if [ -z $DOCKER_USERNAME ]
then 
    # PUBLIC REPOSITORY
    echo ===================================================================================================
    echo RUNNING IMAGE...
    docker run --name app --env-file $PATH/.docker.env -p $DOCKER_PORT:$DOCKER_EXPOSE_PORT -d $DOCKER_IMAGE_NAME
else 
    # PRIVATE REPOSITORY, WE NEED TO LOGIN
    echo ===================================================================================================
    echo LOGGING INTO DOCKER..
    docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD

    ==================================================================================================
    echo RUNNING IMAGE...
    docker run --name app $PATH/.docker.env -p $DOCKER_PORT:$DOCKER_EXPOSE_PORT -d $DOCKER_IMAGE_NAME
fi

