# UPDATE OS
echo ===================================================================================================
echo UPDATING OS
sudo apt-get update && sudo apt-get upgrade -y

echo ===================================================================================================
echo THIS IS THE AUTOMATED SERVER DEPLOY FOR DOCKER ENVIROMENTS.
echo I NEED TO KNOW SOME STUFF FROM YOUR PRIVACY, BUT I PROMISE I WONT STEAL YOU ANYTHING 🙈🙈

# GET VARIABLES FOR DEPLOY
# EMAIL
echo ENTER EMAIL:
read EMAIL
# DOMAIN
echo ENTER DOMAIN:
read DOMAIN
# DOCKER USERNAME
echo ENTER DOCKER USERNAME:
read DOCKER_USERNAME
# DOCKER SSH KEY
echo ENTER DOCKER SSH KEY:
read DOCKER_SSH_KEY
# DOCKER IMAGE NAME
echo ENTER DOCKER IMAGE NAME:
read DOCKER_IMAGE_NAME
# DOCKER IMAGE PORT
echo ENTER DOCKER IMAGE EXPOSE PORT "(DEFAULTS TO 8080)"
if [ -z "$DOCKER_PORT" ]; then DOCKER_PORT=8080 
fi

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
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;
        proxy_redirect off;
     }
}" > /etc/nginx/sites-available/default

sudo systemctl reload nginx

# GET CERTIFICATE
echo ===================================================================================================
echo GETTING CERTIFICATE...
sudo snap install core
sudo snap install --classic certbot
sudo ln -s /snap/bin/certbot /usr/bin/certbot
sudo certbot --nginx --agree-tos -m $EMAIL -d $DOMAIN

# AUTOMATIC CERTIFICATE RENEWAL
echo ===================================================================================================
echo TESTING AUTOMATIC RENEWAL...
sudo certbot renew --dry-run

# DOCKER LOGIN
echo ===================================================================================================
echo LOGING INTO DOCKER..
docker login -u $DOCKER_USERNAME -p $DOCKER_SSH_KEY

# DOCKER PULL
echo ===================================================================================================
echo PULLING IMAGE...
docker pull $DOCKER_IMAGE_NAME

# DOCKER RUN
echo ===================================================================================================
docker run -p 8080:$DOCKER_PORT -d $DOCKER_IMAGE_NAME

# HTTPS/2 SUPPORT
echo ''
echo "
    🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥

    GREAT IF YOU ARE HERE IT MEANS YOUR SITE SHOULD BE UP AND RUNNING...

    THE NEXT AND FINAL STEP IS GETTING HTPPS/2 SUPPORT

    UNFORTUNATELY THIS CANNOT BE AUTOMATED.

    I TOOK THIS FROM THESE STEPS https://www.digitalocean.com/community/tutorials/how-to-set-up-nginx-with-http-2-support-on-ubuntu-18-04.

    READ IT IF YOU WANT TO HAVE A BETTER UNDERSTANDING OR YOU DID NOT UNDERSTAND MY EXPLANATION.
"

read KEY


echo ===================================================================================================
echo INSTRUCTIONS.

# STEP 1
echo ===================================================================================================
echo STEP 1: "
    REPLACE THESE LINES:
        listen [::]:443 ssl ipv6only=on;
        listen 443 ssl;

    FOR THESE: 
        listen [::]:443 ssl http2 ipv6only=on;
        listen 443 ssl http2;
"
echo ENTER KEY TO GO THE FILE.
read KEY
sudo nano /etc/nginx/sites-available/default

# STEP 2
echo ===================================================================================================
echo STEP 2: "
    Locate the line that includes the options-ssl-nginx.conf file and comment it out:
        # include /etc/letsencrypt/options-ssl-nginx.conf; # managed by Certbot<^>

    Below that line, add this line to define the allowed ciphers:
        ssl_ciphers EECDH+CHACHA20:EECDH+AES128:RSA+AES128:EECDH+AES256:RSA+AES256:EECDH+3DES:RSA+3DES:!MD5;
"
echo ENTER KEY TO GO THE FILE.
read KEY
sudo nano /etc/nginx/sites-available/default

# STEP 3
echo ===================================================================================================
echo STEP 3: '
    Below thesez lines:
        include /etc/nginx/conf.d/*.conf;
        include /etc/nginx/sites-enabled/*;

    Add this line to the file to enable HSTS:
        add_header Strict-Transport-Security "max-age=15768000; includeSubDomains" always;
'

echo ENTER KEY TO GO THE FILE.
read KEY
sudo nano /etc/nginx/nginx.conf

echo YESSSS EVERYTHING WAS DONE CORRECTLY, CONGRATULATIONS '🎉🎉🎉🎉🎉'