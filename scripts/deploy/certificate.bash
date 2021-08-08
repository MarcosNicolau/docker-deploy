# GET CERTIFICATE
echo ===================================================================================================
echo GETTING CERTIFICATE...
sudo snap install core
sudo snap install --classic certbot
sudo ln -s /snap/bin/certbot /usr/bin/certbot
sudo certbot --nginx --agree-tos -m $EMAIL -d default

# AUTOMATIC CERTIFICATE RENEWAL
echo ===================================================================================================
echo TESTING AUTOMATIC RENEWAL...
sudo certbot renew --dry-run