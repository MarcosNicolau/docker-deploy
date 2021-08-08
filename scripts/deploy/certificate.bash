# GET CERTIFICATE
echo ===================================================================================================
echo GETTING CERTIFICATE...
sudo snap install core
sudo snap install --classic certbot
sudo ln -s /snap/bin/certbot /usr/bin/certbot
echo y | sudo certbot --nginx --agree-tos -m $EMAIL

# AUTOMATIC CERTIFICATE RENEWAL
echo ===================================================================================================
echo TESTING AUTOMATIC RENEWAL...
sudo certbot renew --dry-run