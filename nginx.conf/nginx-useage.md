Nginx-Usage
===========

### location

* `=`  开头表示精确匹配
* `^~` 开头表示uri以某个常规字符串开头，不是正则匹配
* `~`  开头表示区分大小写的正则匹配;
* `~*` 开头表示不区分大小写的正则匹配
* `/`  通用匹配, 如果没有其它匹配,任何请求都会匹配到

顺序 no优先级：

(location =) > (location 完整路径) > (location ^~ 路径) > (location ~,~* 正则顺序) > (location 部分起始路径) > (/)

location  = / {
  # 精确匹配 /，主机名后面不能带任何字符串，即使/index.html也匹配不了。
  [ configuration A ] 
}

location  / {
  # 因为所有的地址都以 / 开头，所以这条规则将匹配到所有请求
  # 但是正则和最长字符串会优先匹配
  [ configuration B ] 
}

location /documents/ {
  # 匹配任何以 /documents/ 开头的地址，匹配符合以后，还要继续往下搜索
  # 只有后面的正则表达式没有匹配到时，这一条才会采用这一条
  [ configuration C ] 
}

location ~ /documents/Abc {
  # 匹配任何以 /documents/ 开头的地址，匹配符合以后，还要继续往下搜索
  # 只有后面的正则表达式没有匹配到时，这一条才会采用这一条
  [ configuration CC ] 
}

location ^~ /images/ {
  # 匹配任何以 /images/ 开头的地址，匹配符合以后，停止往下搜索正则，采用这一条。
  [ configuration D ] 
}

location ~* \.(gif|jpg|jpeg)$ {
  # 匹配所有以 gif,jpg或jpeg 结尾的请求
  # 然而，所有请求 /images/ 下的图片会被 config D 处理，因为 ^~ 到达不了这一条正则
  [ configuration E ] 
}

location /images/ {
  # 字符匹配到 /images/，继续往下，会发现 ^~ 存在
  [ configuration F ] 
}

location /images/abc {
  # 最长字符匹配到 /images/abc，继续往下，会发现 ^~ 存在
  # F与G的放置顺序是没有关系的
  [ configuration G ] 
}

location ~ /images/abc/ {
  # 只有去掉 config D 才有效：先最长匹配 config G 开头的地址，继续往下搜索，匹配到这一条正则，采用
    [ configuration H ] 
}

location ~* /js/.*/\.js

### rewrite

##### 指令

* set
* if

直接比较内容时
* =
* !=
正则表达式匹配，其中：
* ~ 为区分大小写匹配
* ~* 为不区分大小写匹配
* !~和!~*分别为区分大小写不匹配及不区分大小写不匹配
文件及目录匹配，其中：
* -f和!-f用来判断是否存在文件
* -d和!-d用来判断是否存在目录
* -e和!-e用来判断是否存在文件或目录
* -x和!-x用来判断文件是否可执行
flag标记有：
* last 相当于Apache里的[L]标记，表示完成rewrite
* break 终止匹配, 不再匹配后面的规则
* redirect 返回302临时重定向 地址栏会显示跳转后的地址
* permanent 返回301永久重定向 地址栏会显示跳转后的地址

一些可用的全局变量有，可以用做条件判断(待补全)
$args
$content_length
$content_type
$document_root
$document_uri
$host
$http_user_agent
$http_cookie
$limit_rate
$request_body_file
$request_method
$remote_addr
$remote_port
$remote_user
$request_filename
$request_uri
$query_string
$scheme
$server_protocol
$server_addr
$server_name
$server_port
$uri

* return

return可用来直接设置HTTP返回状态,比如403,404等(301,302不可用return返回,这个下面会在rewrite提到)

* break

立即停止rewrite检测,跟下面讲到的rewrite的break flag功能是一样的,区别在于前者是一个语句,后者是rewrite语句的flag

* rewrite

用法: rewrite 正则 替换 标志位

break – 停止rewrite检测,也就是说当含有break flag的rewrite语句被执行时,该语句就是rewrite的最终结果 
last – 停止rewrite检测,但是跟break有本质的不同,last的语句不一定是最终结果,这点后面会跟nginx的location匹配一起提到 
redirect – 返回302临时重定向,一般用于重定向到完整的URL(包含http:部分) 
permanent – 返回301永久重定向,一般用于重定向到完整的URL(包含http:部分)

结合QeePHP的例子
```
if (!-d $request_filename) {
    rewrite ^/([a-z-A-Z]+)/([a-z-A-Z]+)/?(.*)$ /index.php?namespace=user&amp;controller=$1&amp;action=$2&amp;$3 last;
    rewrite ^/([a-z-A-Z]+)/?$ /index.php?namespace=user&amp;controller=$1 last;
break;
```

多目录转成参数
```
# abc.domian.com/sort/2 => abc.domian.com/index.php?act=sort&name=abc&id=2
if ($host ~* (.*)\.domain\.com) {
    set $sub_name $1;
    rewrite ^/sort\/(\d+)\/?$ /index.php?act=sort&cid=$sub_name&id=$1 last;
}
```

目录对换
```
# /123456/xxxx -> /xxxx?id=123456
rewrite ^/(\d+)/(.+)/ /$2?id=$1 last;
```

例如下面设定nginx在用户使用ie的使用重定向到/nginx-ie目录下：
```
if ($http_user_agent ~ MSIE) {
    rewrite ^(.*)$ /nginx-ie/$1 break;
}
```

目录自动加"/"
```
if (-d $request_filename){
    rewrite ^/(.*)([^/])$ http://$host/$1$2/ permanent;
}
```

禁止htaccess
```
location ~/\.ht {
    deny all;
}
```

禁止多个目录
```
location ~ ^/(cron|templates)/ {
    deny all;
    break;
}
```

禁止以/data开头的文件
可以禁止/data/下多级目录下.log.txt等请求;
```
location ~ ^/data {
    deny all;
}
```

禁止单个目录
不能禁止.log.txt能请求
```
location /searchword/cron/ {
    deny all;
}
```

禁止单个文件
```
location ~ /data/sql/data.sql {
    deny all;
}
```

给favicon.ico和robots.txt设置过期时间;
这里为favicon.ico为99天,robots.txt为7天并不记录404错误日志
```
location ~(favicon.ico) {
    log_not_found   off;
    expires         99d;
    break;
}
location ~(robots.txt) {
    log_not_found   off;
    expires         7d;
    break;
}
```

设定某个文件的过期时间;这里为600秒，并不记录访问日志
```
location ^~ /html/scripts/loadhead_1.js {
	access_log      off;
	root            /opt/lampp/htdocs/web;
    expires         600;
    break;
}
```

文件反盗链并设置过期时间
这里的return 412 为自定义的http状态码，默认为403，方便找出正确的盗链的请求
```
location ~* ^.+\.(jpg|jpeg|gif|png|swf|rar|zip|css|js)$ {
    valid_referers none blocked *.c1gstudio.com *.c1gstudio.net localhost 208.97.167.194;
    if ($invalid_referer) {
        rewrite ^/ http://leech.c1gstudio.com/leech.gif;
        return 412;
        break;
    }
    access_log   off;
    root /opt/lampp/htdocs/web;

    # 只充许固定ip访问网站，并加上密码
    root  /opt/htdocs/www;
    allow   208.97.167.194;
    allow   222.33.1.2;
    allow   231.152.49.4;
    deny    all;
    auth_basic "C1G_ADMIN";
    auth_basic_user_file htpasswd;

    expires 3d;
    break;
}
```

将多级目录下的文件转成一个文件，增强seo效果
```
/job-123-456-789.html 指向/job/123/456/789.html
rewrite ^/job-([0-9]+)-([0-9]+)-([0-9]+)\.html$ /job/$1/$2/jobshow_$3.html last;
```

将根目录下某个文件夹指向2级目录
如 /shanghaijob/ 指向 /area/shanghai/
如果你将last改成permanent，那么浏览器地址栏显是/location/shanghai/
```
rewrite ^/([0-9a-z]+)job/(.*)$ /area/$1/$2 last;
```

上面例子有个问题是访问 /shanghai 时将不会匹配
```
rewrite ^/([0-9a-z]+)job$       /area/$1/   last;
rewrite ^/([0-9a-z]+)job/(.*)$  /area/$1/$2 last;
```

这样 /shanghai 也可以访问了，但页面中的相对链接无法使用，
如./list_1.html真实地址是/area/shanghia/list_1.html会变成/list_1.html,导至无法访问。
那我加上自动跳转也是不行咯
```
#(-d $request_filename)它有个条件是必需为真实目录，而我的rewrite不是的，所以没有效果
if (-d $request_filename){
    rewrite ^/(.*)([^/])$ http://$host/$1$2/ permanent;
}
```

知道原因后就好办了，让我手动跳转吧
```
rewrite ^/([0-9a-z]+)job$ /$1job/ permanent;
rewrite ^/([0-9a-z]+)job/(.*)$ /area/$1/$2 last;
```

文件和目录不存在的时候重定向：
```
if (!-e $request_filename) {
    proxy_pass http://127.0.0.1;
}

域名跳转
server
     {
             listen       80;
             server_name  jump.c1gstudio.com;
             index index.html index.htm index.php;
             root  /opt/lampp/htdocs/www;
             rewrite ^/ http://www.c1gstudio.com/;
             access_log  off;
     }

多域名转向
        server_name  www.c1gstudio.com www.c1gstudio.net;
        index index.html index.htm index.php;
        root  /opt/lampp/htdocs;

        if ($host ~ "c1gstudio\.net") {
            rewrite ^(.*) http://www.c1gstudio.com$1 permanent;
        }

三级域名跳转
        if ($http_host ~* "^(.*)\.i\.c1gstudio\.com$") {
            rewrite ^(.*) http://top.yingjiesheng.com$1;
            break;
        }

域名镜向
    server
     {
        listen          80;
        server_name     mirror.c1gstudio.com;
        index           index.html index.htm index.php;
        root            /opt/lampp/htdocs/www;
        rewrite ^/(.*)  http://www.c1gstudio.com/$1 last;
        access_log      off;
     }

某个子目录作镜向
location ^~ /zhaopinhui {
  rewrite ^.+ http://zph.c1gstudio.com/ last;
  break;
}
discuz ucenter home (uchome) rewrite
rewrite ^/(space|network)-(.+)\.html$ /$1.php?rewrite=$2 last;
rewrite ^/(space|network)\.html$ /$1.php last;
rewrite ^/([0-9]+)$ /space.php?uid=$1 last;

discuz 7 rewrite
rewrite ^(.*)/archiver/((fid|tid)-[\w\-]+\.html)$ $1/archiver/index.php?$2 last;
rewrite ^(.*)/forum-([0-9]+)-([0-9]+)\.html$ $1/forumdisplay.php?fid=$2&page=$3 last;
rewrite ^(.*)/thread-([0-9]+)-([0-9]+)-([0-9]+)\.html$ $1/viewthread.php?tid=$2&extra=page\%3D$4&page=$3 last;
rewrite ^(.*)/profile-(username|uid)-(.+)\.html$ $1/viewpro.php?$2=$3 last;
rewrite ^(.*)/space-(username|uid)-(.+)\.html$ $1/space.php?$2=$3 last;
rewrite ^(.*)/tag-(.+)\.html$ $1/tag.php?name=$2 last;

给discuz某版块单独配置域名
server_name  bbs.c1gstudio.com news.c1gstudio.com;
     location = / {
        if ($http_host ~ news\.c1gstudio.com$) {
            rewrite ^.+ http://news.c1gstudio.com/forum-831-1.html last;
            break;
    }
}
discuz ucenter 头像 rewrite 优化
location ^~ /ucenter {
     location ~ .*\.php?$
     {
        #fastcgi_pass  unix:/tmp/php-cgi.sock;
        fastcgi_pass  127.0.0.1:9000;
        fastcgi_index index.php;
        include fcgi.conf;     
     }
     location /ucenter/data/avatar {
log_not_found off;
access_log   off;
location ~ /(.*)_big\.jpg$ {
    error_page 404 /ucenter/images/noavatar_big.gif;
}
location ~ /(.*)_middle\.jpg$ {
    error_page 404 /ucenter/images/noavatar_middle.gif;
}
location ~ /(.*)_small\.jpg$ {
    error_page 404 /ucenter/images/noavatar_small.gif;
}
expires 300;
break;
     }
                       }
jspace rewrite
location ~ .*\.php?$
             {
                  #fastcgi_pass  unix:/tmp/php-cgi.sock;
                  fastcgi_pass  127.0.0.1:9000;
                  fastcgi_index index.php;
                  include fcgi.conf;     
             }
             location ~* ^/index.php/
             {
    rewrite ^/index.php/(.*) /index.php?$1 break;
                  fastcgi_pass  127.0.0.1:9000;
                  fastcgi_index index.php;
                  include fcgi.conf;
             }

```