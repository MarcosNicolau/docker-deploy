# HTTPS/2 SUPPORT
echo ===================================================================================================
echo ENABLING HTTP/2...
sed -i "/listen 443 ssl/c listen 443 ssl http2;" /etc/nginx/sites-available/default
sed -i "/listen 443 ssl http2/a listen [::]:443 ssl http2 ipv6only=on;" /etc/nginx/sites-available/default
sed -i "/include \/etc\/letsencrypt\/options-ssl-nginx.conf/c ssl_ciphers EECDH+CHACHA20:EECDH+AES128:RSA+AES128:EECDH+AES256:RSA+AES256:EECDH+3DES:RSA+3DES:\!MD5;" /etc/nginx/sites-available/default
sed -i "/include \/etc\/nginx\/sites-enabled\/*/a add_header Strict-Transport-Security \"max-age=15768000; includeSubDomains\" always;" /etc/nginx/nginx.conf