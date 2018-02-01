# Communication Service Website Source

[![GitHub license](https://img.shields.io/github/license/mattrude/xmpp-site.svg)](https://github.com/mattrude/xmpp-site/blob/master/LICENSE) [![Open Issues](https://img.shields.io/github/issues-raw/mattrude/xmpp-site.svg)](https://github.com/mattrude/xmpp-site/issues) [![Maintenance](https://img.shields.io/maintenance/yes/2018.svg)](http://github.com/mattrude/xmpp-site)

This is the website for [Matt Rude](https://mattrude.com)'s XMPP service.  This site may be loaded via the [xmpp-site-builder](https://code.mattrude.com/xmpp-site-builder/) repository.

## Jekyll

[Jekyll](http://jekyllrb.com/) is a static site generator built in [Ruby on Rails](http://rubyonrails.org/). With this approach, you are able to build a high power build site, using a low power, very stable webserver running a static site.

Jekyll is not needed on the webserver, updates must be done by a build system, from this source repository, then sent to the webserver.

### Updating the site

First change into the source directory of the site, once in, update via

    jekyll build

A simple script would be

    rm -rf /var/src/xmpp-site && mkdir -p /var/src/ && \
    git clone http://code.mattrude.com/git/xmpp-site /var/src/xmpp-site -q && \
    cd /var/src/xmpp-site && jekyll build -q && rm -rf /var/src/xmpp-site

## Installing the server

### Nginx Configuration

    #----------------------------------------------------------------------
    # therudes.im XMPP Service
    #----------------------------------------------------------------------

    server {
        listen 443 ssl http2;
        listen [::]:443 ssl http2;
        root /var/www/therudes.im;
        server_name therudes.im;

        ssl_certificate         /var/www/openssl/certs/therudes_im.crt;
        ssl_certificate_key     /var/www/openssl/private/therudes_im.key;

        location /favicon.ico { alias /var/www/therudes.im/img/favicon.ico; }
        error_page 404 /404/index.html;

        location /pastebin/ {
            proxy_pass          http://conference.therudes.com:5280;
        }

        location /status {
            proxy_pass          http://therudes.com:5280;
        }
    }
     
    server {
        listen 443 ssl http2;
        listen [::]:443 ssl http2;
        root /var/www/therudes.im;
        server_name conference.therudes.im;

        ssl_certificate         /var/www/openssl/certs/conference_therudes_im.crt;
        ssl_certificate_key     /var/www/openssl/private/conference_therudes_im.key;

        location /favicon.ico { alias /var/www/therudes.im/img/favicon.ico; }
        error_page 404 /404/index.html;

        location /pastebin/ {
            proxy_pass          http://conference.therudes.com:5280;
        }

        location /status {
            proxy_pass          http://therudes.com:5280;
        }
    }
    
    server {
        listen 80;
        listen [::]:80;
        root /var/www/therudes.im;
        server_name therudes.im;
        server_name conference.therudes.im;

        location /favicon.ico { alias /var/www/therudes.im/img/favicon.ico; }
        error_page 404 /404/index.html;

        location /pastebin/ {
            proxy_pass          http://conference.therudes.com:5280;
        }

        location /status {
            proxy_pass          http://therudes.com:5280;
        }
    }

### Installing Jekyll
Since Jekyll only needs to be installed on your build system. Below are a few quick how-to's how setting up your build system.

#### Installing Ruby on Ubuntu
On Ubuntu 14.04 LTS, you first need ruby installed on your setup, we will also install the development kit.

    apt-get update; apt-get install -y git g++ ruby ruby-dev

Next install the needed gems and Jekyll

    gem install rails
    gem install rouge
    gem install kramdown
    gem install therubyracer
    gem install jekyll
    gem install jekyll-press
    gem install jekyll-sitemap
    gem install jekyll-less
    gem install jekyll-redirect-from
    gem install jekyll-last-modified-at

Now you may use Jekyll to build the site, using the source provided in this repository.

#### Installing Ruby on Windows
First start out by downloading the current production version of the [Ruby Installer](http://rubyinstaller.org/downloads/) for windows.

##### Installing the Ruby Development Kit
After installing Ruby via the [Ruby Installer](http://rubyinstaller.org/downloads/) talked about above, you must now download the Development Kit.

1. Download the Development Kit from http://rubyinstaller.org/downloads/
1. Extract the contact into a location easy accessible to your command prompt.
1. Open a command prompt, change into the directory that you extracted the content of the Development Kit to and run the command: `rake devkit sfx=1`.

## License

                  GNU GENERAL PUBLIC LICENSE
                    Version 3, 29 June 2007

    mattrude.com XMPP Service Website for im.mattrude.com
    Copyright (C) 2012-2016 Matt Rude <matt@mattrude.com>

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
