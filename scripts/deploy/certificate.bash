PATH_TO_DIR=~/docker-deploy
source $PATH_TO_DIR/.deploy.env
# GET CERTIFICATE
echo ===================================================================================================
echo GETTING CERTIFICATE...
sudo snap install core
sudo snap install --classic certbot
sudo ln -s /snap/bin/certbot /usr/bin/certbot
# REPLACE WHITE SPACES FOR COMMA
DOMAINS_CERTBOT_SINTAX=$( echo $DOMAIN | sed 's/ /,/g' )
sudo certbot --nginx --agree-tos -m $EMAIL -n -d $DOMAINS_CERTBOT_SINTAX

# AUTOMATIC CERTIFICATE RENEWAL
echo ===================================================================================================
echo TESTING AUTOMATIC RENEWAL...
sudo certbot renew --dry-run