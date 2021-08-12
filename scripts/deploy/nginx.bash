PATH_TO_DIR=~/docker-deploy
source $PATH_TO_DIR/.deploy.env

# NGINX INSTALL
echo ===================================================================================================
echo INSTALLING NGINX
sudo apt-get install nginx -y
sudo systemctl status nginx

# START NGINX
echo ===================================================================================================
echo STARTING NGINX SERVER...
sudo systemctl start nginx
sudo systemctl enable nginx

# CREATE SERVER LISTENING
echo ===================================================================================================
echo CREATING NGINX SERVER BASED ON DOMAIN...

sudo rm /etc/nginx/sites-available/default

sudo echo "server {
    listen 80;
    server_name $DOMAIN;
    location / {
        proxy_pass http://127.0.0.1:8080;
        proxy_http_version 1.1;
        proxy_set_header Upgrade \$http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host \$host;
        proxy_cache_bypass \$http_upgrade;
        proxy_redirect off;
     }

   # Redirect to pipeline port
     location $PIPELINE_DEPLOY_ROUTE {
        proxy_pass http://127.0.0.1:$PIPELINE_CONTAINER_PORT;
        proxy_http_version 1.1;
        proxy_set_header Upgrade \$http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host \$host;
        proxy_cache_bypass \$http_upgrade;
        proxy_redirect off;
     }
}" > /etc/nginx/sites-available/default

sudo systemctl reload nginx