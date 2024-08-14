FROM alpine:3.20

RUN apk update && apk upgrade
RUN apk add php php-fpm php-mysqli php-phar curl

COPY ./conf/setup.sh /
COPY ./conf/wp-config.php /
RUN chmod 777 /setup.sh

CMD [ "./setup.sh" ]