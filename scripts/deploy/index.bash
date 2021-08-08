# READ ARGS
chmod +x read-args.bash
./read-args.bash

# ADD ENV VARIABLES FROM ARGS
source /app/.deploy.env
source /app/.docker.env

# OS
chmod +x os.bash
./os.bash
# NGINX SETUP
chmod +x nginx.bash
./nginx.bash
# GET CERTIFICATE
chmod +x certificate.bash
./certificate.bash
# HTTP/2
chmod +x http-2.bash
./http-2.bash
# DOCKER 
chmod +x docker.bash
./docker.bash
# PIPELINE
chmod +x pipeline.bash
./pipeline.bash

