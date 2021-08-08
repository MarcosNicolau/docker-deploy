# GET CERTIFICATE
echo ===================================================================================================
echo GETTING CERTIFICATE...
sudo snap install core
sudo snap install --classic certbot
sudo ln -s /snap/bin/certbot /usr/bin/certbot
# REPLACE WHITE SPACES FOR COMMA
DOMAINS_CERTBOT_SINTAX=$( echo $DOMAIN | sed 's/ /,/g' )
sudo certbot --nginx --agree-tos -m $EMAIL --hsts --uir -n -d $DOMAINS_CERTBOT_SINTAX

# AUTOMATIC CERTIFICATE RENEWAL
echo ===================================================================================================
echo TESTING AUTOMATIC RENEWAL...
sudo certbot renew --dry-run