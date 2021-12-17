FROM ubuntu:18.04



RUN apt-get update -y && apt-get install apache2 -y

ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ADD config/apache/apache-virtual-hosts.conf /etc/apache2/sites-enabled/000-default.conf
ADD config/apache/apache2.conf /etc/apache2/apache2.conf
ADD config/apache/ports.conf /etc/apache2/ports.conf
ADD config/apache/envvars /etc/apache2/envvars

ADD demo/index.html /var/www/
RUN service apache2 restart
RUN chown -R www-data:www-data /var/www
WORKDIR /var/www/


EXPOSE 80

ENTRYPOINT ["apachectl","-D", "FOREGROUND"]
