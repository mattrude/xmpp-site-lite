#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
VERSION=`ejabberdctl status |tail -1 |awk '{ print $2 }'`
GITVERSION=`git --git-dir=/var/src/ejabberd/.git log |head -1 |awk '{print $2}'`
UPLOADDAYS=`grep -A1 mod_http_upload_quota /etc/ejabberd/ejabberd.yml |grep max_days |awk '{ print $2 }'`
UPLOADFSIZ=`grep -A8 "mod_http_upload:$" /etc/ejabberd/ejabberd.yml |grep max_size |awk '{ print $2 }' |awk '{ byte =$1 /1024/1024/1024; print byte " GB" }'`
DOMAINS=`sed -n -e '/^hosts:/,/^##/ p' /etc/ejabberd/ejabberd.yml |grep "^  -" |awk '{ print $2 }' |sed 's/"//g'`

for DOMAIN in ${DOMAINS}
do
    cd ${DIR}
    rm -f current-config.yml
    sed "s/example.com/${DOMAIN}/g" _config.yml |sed "s/matt@${DOMAIN}/matt@mattrude.com/g" > current-config.yml
    sed -i "s/^ejabberd-version.*/ejabberd-version: \"${VERSION}\"/g" current-config.yml
    sed -i "s/^ejabberd-gitversion.*/ejabberd-gitversion: \"${GITVERSION}\"/g" current-config.yml
    sed -i "s/^ejabberd-upload-days.*/ejabberd-upload-days: \"${UPLOADDAYS}\"/g" current-config.yml
    sed -i "s/^ejabberd-upload-fsize.*/ejabberd-upload-fsize: \"${UPLOADFSIZ}\"/g" current-config.yml
    if [ -x ${DIR}/update-site-certs.sh ]; then
        ${DIR}/update-site-certs.sh ${DOMAIN}
    else
        sed -i '/^fingerprint/d' current-config.yml
    fi
    cd ${DIR} && \
        rm -rf /var/www/im.${DOMAIN} && \
        if [ ! -f Gemfile.lock ]; then bundle install; fi && \
        bundle exec jekyll build -c current-config.yml -q
    chown -R www-data:www-data /var/www/im.${DOMAIN}
    rm -rf /var/www/im.${DOMAIN}/files ${DIR}/current-config.yml
done

if [ -x /etc/ejabberd/bin/update-tlsa.sh ]; then /etc/ejabberd/bin/update-tlsa.sh; fi
