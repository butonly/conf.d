# Nginx

## Configure Make Install

默认编辑：

```sh
apt-get install build-essential libpcre3-dev zlib1g-dev libssl-dev libxml2-dev libxslt1-dev libgeoip-dev libgd-dev libgoogle-perftools-dev libatomic-ops-dev libperl-dev && \
tar -zxvf nginx-1.10.0.tar.gz && \
cd nginx-1.10.0 && \
./configure && make && make install && \
/usr/local/nginx/sbin/nginx && \
cd ..
```

编译参数：

```sh
./configure --with-file-aio --with-google_perftools_module --with-http_addition_module --with-http_auth_request_module --with-http_dav_module --with-http_degradation_module --with-http_flv_module --with-http_geoip_module --with-http_gunzip_module --with-http_gzip_static_module --with-http_image_filter_module --with-http_mp4_module --with-http_perl_module --with-http_random_index_module --with-http_realip_module --with-http_secure_link_module --with-http_slice_module --with-http_ssl_module --with-http_stub_status_module --with-http_sub_module --with-http_v2_module --with-http_xslt_module --with-libatomic --with-mail --with-mail_ssl_module --with-pcre --with-pcre-jit --with-poll_module --with-select_module --with-stream --with-stream_geoip_module --with-stream_realip_module --with-stream_ssl_module --with-stream_ssl_preread_module --with-threads \
	--add-module=../modules/ngx_devel_kit-0.3.0 \
	--add-module=../modules/echo-nginx-module-0.60 \
	--add-module=../modules/nginx-upsync-module-1.0.0 \
	--add-module=../modules/array-var-nginx-module-0.05 \
	--add-module=../modules/nginx-statsd-0.0.1 \
	--add-module=../modules/lua-nginx-module-0.10.7 \
	--add-module=../modules/headers-more-nginx-module-0.32 \
	--add-module=../modules/ngx-fancyindex-0.4.1 \
	--add-module=../modules/ngx_cache_purge-2.3 \
	--add-module=../modules/set-misc-nginx-module-0.31 \
	--add-module=../modules/ngx_pagespeed-latest-beta
```

## Config

* 配置文件示例：[conf](confg)
* [Nginx-Usage](nginx-useage.md)
* [Nginx-Rewrite](nginx-rewrite.md)
* [Nginx-Upgrade](nginx-upgrade.md)

## Nginx Source Code

https://github.com/taobao/nginx-book
https://github.com/openresty/nginx-tutorials
https://github.com/y123456yz/reading-code-of-nginx-1.9.2
https://github.com/lebinh/ngxtop

## Nginx Configure

https://github.com/lebinh/nginx-conf
https://github.com/h5bp/server-configs-nginx

## Nginx Modules

### Nginx WAF

* https://github.com/SpiderLabs/ModSecurity/
* https://github.com/nbs-system/naxsi

### Others

* https://github.com/GUI/lua-resty-auto-ssl
* https://github.com/alexazhou/VeryNginx
* https://github.com/mailru/graphite-nginx-module
* https://github.com/brg-liuwei/ngx_kafka_module
* https://github.com/voxpupuli/puppet-nginx
* https://github.com/zebrafishlabs/nginx-statsd
* https://github.com/mdirolf/nginx-gridfs
* https://github.com/openresty/redis2-nginx-module
* https://github.com/aperezdc/ngx-fancyindex
* https://github.com/weibocom/nginx-upsync-module
* https://github.com/calio/form-input-nginx-module
* https://github.com/calio/iconv-nginx-module
* https://github.com/google/ngx_brotli
* https://github.com/vozlt/nginx-module-vts
* https://github.com/vkholodkov/nginx-upload-module
* https://github.com/masterzen/nginx-upload-progress-module
* https://github.com/cuber/ngx_http_google_filter_module
* https://github.com/wandenberg/nginx-push-stream-module
* https://github.com/loveshell/ngx_lua_waf
* https://github.com/yaoweibin/nginx_tcp_proxy_module
* https://github.com/alibaba/nginx-http-concat
* https://github.com/pagespeed/ngx_pagespeed
* https://github.com/arut/nginx-rtmp-module
* https://github.com/simpl/ngx_devel_kit
* https://github.com/FRiCKLE/ngx_cache_purge
* https://github.com/openresty/headers-more-nginx-module
* https://github.com/openresty/set-misc-nginx-module
* https://github.com/openresty/echo-nginx-module
* https://github.com/openresty/lua-nginx-module
* https://github.com/openresty/encrypted-session-nginx-module
* https://github.com/evanmiller/mod_zip
* https://github.com/openresty/xss-nginx-module
* https://github.com/xiaokai-wang/nginx-stream-upsync-module
* https://bitbucket.org/nginx-goodies/nginx-sticky-module-ng
* https://github.com/vkholodkov/nginx-upload-module
* https://github.com/masterzen/nginx-upload-progress-module
* https://github.com/Lax/ngx_http_accounting_module
* https://github.com/cubicdaiya/ngx_small_light
* https://github.com/openresty/memc-nginx-module
* https://github.com/arut/nginx-rtmp-module
* https://github.com/calio/iconv-nginx-module
* https://github.com/cfsego/limit_upload_rate
* https://github.com/slact/nchan
* https://github.com/wandenberg/nginx-push-stream-module
* https://github.com/ideawu/icomet
