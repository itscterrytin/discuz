#
# Dockerfile for discuz X3.2 TC utf8
#

FROM php:5.6-apache
MAINTAINER terry<terry>

RUN set -xe \
    && apt-get update \
    && apt-get install -y curl libjpeg-dev libpng12-dev unzip \
    && rm -rf /var/lib/apt/lists/* \
    && docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr \
    && docker-php-ext-install gd mysql

WORKDIR /var/www/html

ENV DISCUZ_VER 3.2
ENV DISCUZ_URL http://download.comsenz.com/DiscuzX/${DISCUZ_VER}/Discuz_X${DISCUZ_VER}_TC_UTF8.zip
ENV DISCUZ_MD5 1b9a38d0caeb5736789f3a4e02fff2d2
ENV DISCUZ_FILE discuz.zip

RUN set -xe \
    && curl -fSL ${DISCUZ_URL} -o ${DISCUZ_FILE} \
    && echo "${DISCUZ_MD5}  ${DISCUZ_FILE}" | md5sum -c \
    && unzip ${DISCUZ_FILE} 'upload/*' \
    && mv upload/* . \
    && rm -rf ${DISCUZ_FILE} upload \
    && chown -R www-data:www-data .
