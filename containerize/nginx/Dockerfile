FROM nginx:latest
# pulling latest nginx image

COPY files/html /usr/share/nginx/html
# changed default nginx html code

COPY files/ssl/localhost.crt /etc/ssl/certs
COPY files/ssl/localhost.key /etc/ssl/private
#copy certs into image

COPY files/conf/default.conf /etc/nginx/conf.d
#copy default config into nginx

#CMD ["nginx", "-s", "reload"]

# your code goes here ...
