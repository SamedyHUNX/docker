FROM nginx:stable-alpine

WORKDIR /etc/nginx/conf.d

COPY nginx/ngin.conf /etc/nginx/conf.d/

RUN mv /etc/nginx/conf.d/nginx.conf default.conf

WORKDIR /var/www/html

COPY src .