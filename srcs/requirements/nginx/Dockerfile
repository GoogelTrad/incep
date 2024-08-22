FROM alpine:3.20


RUN		apk update
RUN		apk upgrade
RUN		apk add nginx openssl


RUN		mkdir -p /etc/nginx/ssl
RUN		openssl req -x509 -nodes -days 365 -newkey rsa:4096 -keyout /etc/nginx/ssl/self.key -out /etc/nginx/ssl/self.crt -subj "/C=MO/L=KH/O=1337/OU=student/CN=cmichez.42.fr"

COPY	conf/nginx.conf /etc/nginx/http.d/nginx.conf
EXPOSE	443
ENTRYPOINT ["nginx", "-g", "daemon off;"]