FROM ecor/centos-s3fs
MAINTAINER Corey Butler <corey@coreybutler.com> (goldglovecb)

ENV NODEJS 0.12.4

# Add Fuse & S3 support
RUN yum -y install epel-release
RUN yum -y install gcc libstdc++-devel gcc-c++ curl-devel libxml2-devel openssl-devel mailcap wget tar make --enablerepo=epel

# Add node.js support
RUN cd /usr/src \
    && wget http://nodejs.org/dist/v$NODEJS/node-v$NODEJS.tar.gz \
    && tar zxvf node-v$NODEJS.tar.gz \
    && rm -rf node-v$NODEJS.tar.gz \
    && cd node-v$NODEJS \
    && ./configure \
    && make \
    && make install \
    && rm -rf node-v$NODEJS

RUN npm update npm

RUN yum remove -y gcc libstdc++-devel gcc-c++ curl-devel libxml2-devel openssl-devel mailcap make epel-release

ENTRYPOINT ["/launch"]
