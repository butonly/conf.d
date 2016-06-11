#!/usr/bin/env bash

cd /etc/yum.repos.d
wget http://mirrors.163.com/.help/fedora-163.repo
wget http://mirrors.163.com/.help/fedora-updates-163.repo
wget http://mirrors.sohu.com/help/fedora-sohu.repo
wget http://mirrors.sohu.com/help/fedora-updates-sohu.repo
wget http://lug.ustc.edu.cn/wiki/_export/code/mirrors/help/fedora?codeblock=0
wget http://lug.ustc.edu.cn/wiki/_export/code/mirrors/help/fedora?codeblock=1
wget http://mirrors.yun-idc.com/fedora-cds.repo
wget http://mirrors.yun-idc.com/fedora-updates-cds.repo
dnf makecache
cd -

# 安装插件 让系统自动选择最快的软件源
dnf install yum-fastestmirror
# 在dnf配置文件 /etc/dnf/dnf.conf 后面加一行fastestmirror=true
echo "fastestmirror=true" >> /etc/dnf/dnf.conf

# 配置RPMFusion仓库
sudo dnf install --nogpgcheck http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-23.noarch.rpm

# 安装VLC媒体播放器
# dnf install vlc -y

# 安装多媒体编码

# dnf install gstreamer-plugins-bad gstreamer-plugins-bad-free-extras gstreamer-plugins-ugly gstreamer-ffmpeg gstreamer1-libav gstreamer1-plugins-bad-free-extras gstreamer1-plugins-bad-freeworld gstreamer-plugins-base-tools gstreamer1-plugins-good-extras gstreamer1-plugins-ugly gstreamer1-plugins-bad-free gstreamer1-plugins-good gstreamer1-plugins-base gstreamer1

# 卸载你不需要的软件

# 安装Adobe Flash

# 配置Chorme源
cp yum.repo.d/google-chrome.repo /etc/yum.repo.d

dnf install chrome

