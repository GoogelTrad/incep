FROM alpine:3.20

RUN apk update && apk upgrade
RUN apk add php83 php83-fpm php83-mysqli php83-phar curl php83-cgi php83-common php83-apache2 php83-iconv
RUN apk add mysql-client

RUN addgroup nginx && adduser --system --no-create-home --ingroup nginx nginx 
COPY ./conf/default.conf /etc/php83/conf.d/www.conf

COPY ./conf/setup.sh /
COPY ./conf/wp-config.php /
RUN chmod 777 /setup.sh

CMD [ "./setup.sh" ]