FROM alpine:3.20


RUN		apk update
RUN		apk upgrade
RUN		apk add nginx openssl curl openrc



RUN		mkdir -p /etc/nginx/ssl
RUN		openssl req -x509 -nodes -days 365 -newkey rsa:4096 -keyout /etc/nginx/ssl/self.key -out /etc/nginx/ssl/self.crt -subj "/C=FR/L=NICE/O=PACA/OU=cmichez/CN=localhost"

COPY	conf/nginx.conf /etc/nginx/http.d/default.conf
EXPOSE	443
ENTRYPOINT ["nginx", "-g", "daemon off;"]
