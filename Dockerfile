FROM alpine:3.9
LABEL author="Serge NOEL <serge.noel@easylinu.fr>" \
      version="9.0.3" \
      application="Dolibarr" \
      description="Conteneur Alpine/Dolibarr"
RUN apk add php7-apache2
# Renvoi des logs 
RUN ln -s /dev/stdout /var/log/apache2/access.log
RUN ln -s /dev/stderr /var/log/apache2/error.log
RUN  sed -i 's|/var/www/localhost/htdocs|/var/www/html|g' /etc/apache2/httpd.conf
RUN mkdir /var/www/html
RUN wget https://sourceforge.net/projects/dolibarr/files/Dolibarr%20ERP-CRM/9.0.3/dolibarr-9.0.3.tgz/download
RUN mv download dolibarr.tgz
RUN cd /var/www/html \
    && tar zxf /dolibarr.tgz dolibarr-9.0.3/htdocs/ --strip 2
RUN chown -R root: /var/www/html/
RUN apk add php7-session php7-curl php7-gd

RUN apk add php7-mysqli php7-mcrypt php7-openssl php7-mbstring \
		php7-imagick \
		php7-soap \
		php7-calendar \
		php7-xml \
		php7-zip 
EXPOSE 80

CMD /usr/sbin/httpd -D FOREGROUND
# CMD ["/usr/sbin/httpd","-D","FOREGROUND"]

VOLUME /var/www/html/documents


WORKDIR /var/www/html



