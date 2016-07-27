Nginx-Upgrade
============

### 按需编译Nginx

### 重命名旧版本Nginx二进制文件，Nginx不好停止服务

```sh
# mv /usr/local/nginx/sbin/nginx /usr/local/nginx/sbin/nginx.old
```

### 拷贝新编译的二进制文件，覆盖掉原来二进制文件

```sh
# cp objs/nginx /usr/local/nginx/sbin/
```

### 在源码目录执行make upgrade

切记前后两次nginx安装路径需要相同，否者需要手动upgrade

```sh
# make upgrade
```
