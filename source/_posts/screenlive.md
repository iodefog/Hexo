title: FFmpeg 直播 命令
date: 2017-06-06 17:12:00
categories: 技术
tags: 
description:
---

一、FFmpeg 录制屏幕并推流直播

可以继续扩展例子1，直播当前屏幕的内容，向大家介绍一下怎么通过几行命令搭建一个测试用的直播服务：

Step 1：首先安装 docker： 访问 https://www.docker.com/products/docker ，按操作系统下载安装。
<!--more -->

Step 2：下载 nginx-rtmp 镜像：

```
docker pull chakkritte/docker-nginx-rtmp
```

Step 3：创建 nginx html 路径，启动 docker-nginx-rtmp

```
mkdir ~/rtmp
```

docker run -d -p 80:80 -p 1935:1935 -v ~/rtmp:/usr/local/nginx/html chakkritte/docker-nginx-rtmp
Step 4：推送屏幕录制到 nignx-rtmp

```
ffmpeg -y -loglevel warning -f avfoundation -i 2 -r 30 -s 480x320 -threads 2 -vcodec libx264  -f flv rtmp://127.0.0.1/live/test
```

Step 5：用 ffplay 播放

```
ffplay rtmp://127.0.0.1/live/test
```

二、FFmpeg 推流正常视频直播

```
ffmpeg -re -i "太平洋战争[1280高清中 英双字]EP01.rmvb" -vcodec h264 -f flv rtmp://localhost:1935/rtmplive/maopian01

ffplay rtmp://localhost:1935/rtmplive/maopian01
```
