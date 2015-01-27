# Docker image for OSM tools
# To build, run docker build --rm --tag=jmarin/addressparser
# A container can be started by running docker run -t -i jmarin/usaddress

FROM ubuntu:latest
MAINTAINER Juan Marin Otero <juan.marin.otero@gmail.com>

RUN sudo apt-get update
RUN sudo apt-get -y install build-essential
RUN sudo apt-get -y install libtool
RUN sudo apt-get -y install autoconf
RUN sudo apt-get -y install python-setuptools
RUN sudo apt-get -y install git
RUN sudo apt-get -y install nginx
RUN sudo easy_install pip
RUN sudo apt-get -y install python python-dev python-setuptools libxml2-dev libxslt-dev zlib1g-dev
RUN sudo pip install usaddress
RUN sudo pip install flask
RUN sudo pip install supervisor
RUN mkdir -p /var/log/supervisor
RUN mkdir -p /etc/supervisor/conf.d

ADD ./app /docker/app
ADD ./conf /docker/conf

RUN echo "\ndaemon off;" >> /etc/nginx/nginx.conf
RUN ln -s /docker/conf/app_nginx.conf /etc/nginx/sites-enabled/
RUN ln -s /docker/conf/app_supervisor.conf /etc/supervisor/conf.d/

EXPOSE 5000

#CMD ["supervisord", "-c", "/etc/supervisor/conf.d/app_supervisor.conf"]
#CMD ["/bin/bash"]
CMD ["python", "/docker/app/app.py"]
