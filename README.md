# Communication Service Website Source

[![GitHub license](https://img.shields.io/github/license/mattrude/xmpp-site-lite.svg)](https://github.com/mattrude/xmpp-site-lite/blob/master/LICENSE) [![Open Issues](https://img.shields.io/github/issues-raw/mattrude/xmpp-site-lite.svg)](https://github.com/mattrude/xmpp-site-lite/issues) [![Maintenance](https://img.shields.io/maintenance/yes/2018.svg)](http://github.com/mattrude/xmpp-site-lite)

This is the website for a XMPP service.

### Site Components 

* [Bootstrap 4.0](https://getbootstrap.com/) (via CDN)

## Installing Site

Installing this site is no diffrent then installing anyother [Jekyll](https://jekyllrb.com/) site.  You will need to download the source and compile it.  The compiled output will be the full HTML output.

### 1. Clone the site

    git clone https://github.com/mattrude/xmpp-site-lite.git
    cd xmpp-site-lite

### 2. Update Dependencies

    bundler update

### 3. Build the site

    bundle exec jekyll build

### 4. Setting up the Webserver

#### Nginx Configuration

    server {
        listen 80;
        listen [::]:80;
        server_name im.example.com;
        server_name conference.example.com;
        server_name proxy.example.com;
        server_name pubsub.example.com;
        server_name upload.example.com;
        error_log off;

        location '/.well-known/acme-challenge' {
            default_type "text/plain";
            root /var/www/im.example.com;
        }

        location / {
            return              301 https://$server_name$request_uri;
        }
    }

    server {
        listen 443 ssl http2;
        listen [::]:443 ssl http2;
        server_name im.example.com;
        server_name conference.example.com;
        server_name upload.example.com;
        root /var/www/im.example.com;
        index index.html;
        error_log off;

        ssl_certificate         /etc/letsencrypt/live/im.example.com/fullchain.pem;
        ssl_certificate_key     /etc/letsencrypt/live/im.example.com/privkey.pem;
        ssl_stapling on;

        error_page 404 /404.html;

        location /upload {
            proxy_pass http://upload.example.com:5280/upload;
            proxy_set_header Host upload.example.com;
            proxy_buffering off;
            tcp_nodelay on;
        }

        location /pastebin {
            proxy_pass http://conference.example.com:5280;
            proxy_set_header Host conference.example.com;
            proxy_buffering off;
            tcp_nodelay on;
        }

        location /admin {
            proxy_pass http://im.example.com:5280/admin/;
            proxy_set_header Host example.com;
            proxy_buffering off;
            tcp_nodelay on;
        }

        location /log {
            proxy_pass http://conference.example.com:5280/muc_log/;
            proxy_set_header Host conference.example.com;
            proxy_buffering off;
            tcp_nodelay on;
        }

        location /http-bind {
            proxy_pass http://im.example.com:5280/http-bind;
            proxy_set_header Host example.com;
            proxy_buffering off;
            tcp_nodelay on;
        }

        location /status {
            proxy_pass http://im.example.com:5280/status;
            proxy_set_header Host example.com;
            proxy_buffering off;
            tcp_nodelay on;
        }

        location /register {
            proxy_pass http://localhost:5280/register_web;
            proxy_set_header Host im.example.com;
            proxy_buffering off;
            tcp_nodelay on;
        }

        location /register_web {
            proxy_pass http://localhost:5280/register_web;
            proxy_set_header Host im.example.com;
            proxy_buffering off;
            tcp_nodelay on;
        }

        location ~* /files {
            return 404;
        }

        location ~* \.(?:css|ico|js|jpeg|jpg)$ {
            expires 1y;
            add_header Cache-Control "public";
        }

        location / {
        }
    }

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
