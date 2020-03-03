#!/usr/bin/env bash

block="\
map_hash_max_size 262144;\
map_hash_bucket_size 262144;\
\
map \$uri \$redirect_https {
    /hunkware/dailyhuddle/huddleboard.php 0;
    /hunkware/dailyhuddle/topsalesagents.php 0;
    /hunkware/dailyhuddle/topagentbookingpercent.php 0;
    /hunkware/dailyhuddle/systemstatus.php 0;
    /images/TrucksCartoon.png 0;
    /images/wood-background.jpg 0;
    /images/sales-background.jpg 0;
    /images/hunkwareonline.jpg 0;
    /hunkware/css/bootstrap.min.css 0;
    /cisco/ciscocheckserviceable.php 0;
    /cisco/ciscocheckjobs.php 0;
    /cisco/ciscogetjobdate.php 0;
    /cisco/ciscochecktracking.php 0;
    /hunkware/API/ClientCreate.php 0;
    /hunkware/API/ClientCreate800Junk.php 0;
    /hunkware/API/ClientCreateHomeAdvisor.php 0;
    /hunkware/API/ClientCreateiReuse.php 0;
    /hunkware/API/ClientCreateMobile.php 0;
    /hunkware/API/ClientCreateMosquitoHunters.php 0;
    /hunkware/API/ClientCreatePickUpMyDonation.php 0;
    default 1;
}\
\
server {

    client_max_body_size 500M;

    listen ${3:-80};
    listen ${4:-443} ssl http2;
    server_name .$1 .*api\-chhj.ngrok.io;

    set \$WEB_ROOT $2;

    root \$WEB_ROOT;
    
    ssl_certificate     /etc/nginx/ssl/$1.crt;
    ssl_certificate_key /etc/nginx/ssl/$1.key;

    charset utf-8;
    add_header 'Access-Control-Allow-Origin' '*' always;
    add_header 'Access-Control-Allow-Credentials' 'true' always;
    add_header 'Access-Control-Allow-Methods' 'GET,OPTIONS,PUT,PATCH,POST,DELETE,HEAD' always;
    add_header 'Access-Control-Allow-Headers' 'Authorization,CHHJ-Request-Data,DNT,X-CustomHeader,Keep-Alive,User-Agent,X-Requested-With,If-Modified-Since,Cache-Control,Content-Type,Content-Range,Range,X-API-KEY,Origin,Accept,Access-Control-Request-Method,Access-Control-Request-Headers' always;

    add_header Strict-Transport-Security \"max-age=63072000; includeSubdomains; preload\";
    add_header X-Content-Type-Options nosniff;
    
    if (\$request_method = OPTIONS ) {
        return 200;
    }

    if (\$redirect_https = 1) {
      set \$redirectflags redirect;
    }

    if (\$https != \"on\") {
      set \$redirectflags \"\${redirectflags}+https\";
    }

    if (\$redirectflags = 'redirect+https') {
       return 301 https://\$server_name\$request_uri;
    }
    
    location = / {
        return 301 /info;
    }

    location / {
        try_files \$uri \$uri.html \$uri/ @extensionless-php;
        index  index.php index.html index.htm;
        expires 168h;
        add_header Pragma public;
        add_header Cache-Control \"public, must-revalidate, proxy-revalidate\";
    }

    location ~ \.php$ {
        try_files \$uri =404;
        fastcgi_pass    unix:/var/run/php/php$5-fpm.sock;
        fastcgi_index   index.php;
        include         fastcgi_params;
        fastcgi_read_timeout 300;
        fastcgi_param SCRIPT_FILENAME \$document_root\$fastcgi_script_name;
        fastcgi_param PHP_AUTH_USER \$remote_user;
        fastcgi_param PHP_AUTH_PW \$http_authorization;
        fastcgi_param CHHJ_ENV \"HOMESTEAD\";
        expires -1;
    }

    location ~* \.(js|css|png|jpg|svg|jpeg|gif|ico)$ {
        expires 2d;
        add_header Cache-Control \"public, no-transform\";
    }

    location @extensionless-php {
        rewrite ^(.*)$ \$1.php last;
    }
    
    location /hunkware-new {
        try_files \$uri \$uri.html \$uri/ @extensionless-php;
    }
    
    rewrite ^/(.*)$ /index.php last;

    rewrite ^/systino/service.asmx$ /api/rest/v1/listen360/getjobs;
    
    location /hunkware/bookingflow/quotingtool {
        if (-f \$request_filename) {
            break;
        }
    
        rewrite ^/hunkware/bookingflow/quotingtool(.*)$ /hunkware/bookingflow/quotingtool/index.html last;
    }
    

    # Enable Gzip compressed.
    gzip on;

    # Enable compression both for HTTP/1.0 and HTTP/1.1.
    gzip_http_version  1.1;

    # Compression level (1-9).
    # 5 is a perfect compromise between size and cpu usage, offering about
    # 75% reduction for most ascii files (almost identical to level 9).
    gzip_comp_level    5;

    # Don't compress anything that's already small and unlikely to shrink much
    # if at all (the default is 20 bytes, which is bad as that usually leads to
    # larger files after gzipping).
    gzip_min_length    256;

    # Compress data even for clients that are connecting to us via proxies,
    # identified by the \"Via\" header (required for CloudFront).
    gzip_proxied       any;

    # Tell proxies to cache both the gzipped and regular version of a resource
    # whenever the client's Accept-Encoding capabilities header varies;
    # Avoids the issue where a non-gzip capable client (which is extremely rare
    # today) would display gibberish if their proxy gave them the gzipped version.
    gzip_vary          on;

    # Compress all output labeled with one of the following MIME-types.
    gzip_types
      application/atom+xml
      application/javascript
      application/json
      application/rss+xml
      application/vnd.ms-fontobject
      application/x-font-ttf
      application/x-web-app-manifest+json
      application/xhtml+xml
      application/xml
      font/opentype
      image/svg+xml
      image/x-icon
      text/css
      text/plain
      text/x-component;
    # text/html is always compressed by HttpGzipModule
    
    error_page 404 /50xx.html;
    error_page 500 502 503 504 /50xx.html;
    location = /50xx.html {
        root /efs;
        internal;
    }

}"

echo "$block" > "/etc/nginx/sites-available/$1"
ln -fs "/etc/nginx/sites-available/$1" "/etc/nginx/sites-enabled/$1"
