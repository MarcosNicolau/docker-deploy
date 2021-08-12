PATH_TO_DIR=~/docker-deploy
source $PATH_TO_DIR/.deploy.env

# DOCKER LOGIN
echo ===================================================================================================
echo DOCKER TIME...

# DO WE NEED TO LOG IN?
if [ -z $DOCKER_USERNAME ]
then 
    # PUBLIC REPOSITORY
    echo ===================================================================================================
    echo RUNNING IMAGE...
    docker run --name app --env-file $PATH_TO_DIR/.docker.env -p $DOCKER_PORT:$DOCKER_EXPOSE_PORT -d $DOCKER_IMAGE_NAME
else 
    # PRIVATE REPOSITORY, WE NEED TO LOGIN
    echo ===================================================================================================
    echo LOGGING INTO DOCKER..
    docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD

    echo ==================================================================================================
    echo RUNNING IMAGE...
    docker run --name app --env-file $PATH_TO_DIR/.docker.env -p $DOCKER_PORT:$DOCKER_EXPOSE_PORT -d $DOCKER_IMAGE_NAME
fi

