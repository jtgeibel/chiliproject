FROM ubuntu:14.04
MAINTAINER jtgeibel@gmail.com

RUN apt-get update \
 && apt-get install -y git ruby rubygems-integration rake ruby-pg ruby-rmagick ruby-json \
 && echo "gem: --no-ri --no-rdoc" > /root/.gemrc \
 && gem install bundler # 20150113

RUN apt-get update && apt-get upgrade -y

ADD . /app/chiliproject

RUN chown -R nobody:nogroup /app

USER nobody
WORKDIR /app/chiliproject

RUN bin/install

ENV RAILS_ENV=production

EXPOSE 80

ENTRYPOINT ["script/console"]
