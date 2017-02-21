title: ffmpeg 最方便的生产静态库的方案，一键到位，
date: 2014-05-13 23:28:00
categories: 技术
tags: 
description:
---
###[Compile ffmpeg for iOS 6, support Simulator & armv7 & armv7s](http://witcheryne.iteye.com/blog/1734706)
**博客分类：** - [iphone & ipad](http://witcheryne.iteye.com/category/249787)

[iOS](http://www.iteye.com/blogs/tag/iOS)[ffmpeg](http://www.iteye.com/blogs/tag/ffmpeg)In the posts, I will show how to use ffmpeg on iOS.
 
**This posts is a document for this project: **
[https://github.com/lvjian700/ffmpegc-demo](https://github.com/lvjian700/ffmpegc-demo)
 
**Now, ffmpec support x264 module. If you use the script before, please check your version first. **
 
##What is [ffmpeg](http://ffmpeg.org/) ?
FFmpeg is a complete, across-platform solution to record, convert and stream audio and video. 
##Why use ffmpeg?
- Play h.264 video
- encoding capture video to h.264 video(It need ffmpeg h.264 module.)
- publish a av stream
- subscribe a rtsp av stream

##Before use ffmpegc-demo, you should download and compile ffmpeg:
I made a repository to make the step easy:Shell代码  [![收藏代码](http://witcheryne.iteye.com/images/icon_star.png)]( "收藏这段代码")1. git clone git@github.com:lvjian700/ffmpegc.git  
2. cd ffmpegc  
3. ./install-ffmpeg.sh  

 [https://github.com/lvjian700/ffmpegc](https://github.com/lvjian700/ffmpegc)###If compile complete, you can find universal library in ffmpeg/build folder:
1. ffmpeg core library:![](http://dl2.iteye.com/upload/attachment/0085/0318/11a437db-5e28-3fd5-9ab3-4dd93f4147e5.png)
 2. ffmpeg x264 module. x264 is a H.264/MPEG-4 AVC encoder ![](http://dl2.iteye.com/upload/attachment/0085/0320/380b5f32-3b5e-3e6c-b4dd-49e74191977e.png "点击查看原始大小图片")
 ##Using ffmpeg
###1. Clone project first:
Java代码  [![收藏代码](http://witcheryne.iteye.com/images/icon_star.png)]( "收藏这段代码")1. git@github.com:lvjian700/ffmpegc-demo.git  

###2.Open in XCode and copy build/*.a and x264/build/*.a to libs/ folder of the project:
![](http://dl2.iteye.com/upload/attachment/0085/0325/82f6bf73-e1bd-3703-a6db-83a292bcb9b8.png "点击查看原始大小图片")
 
###3. Add them to project link library
Project References -> Targets -> Build Phases -> Link Binary With Librarys
![](http://dl.iteye.com/upload/attachment/0077/0400/120bf08f-a399-329b-a977-bc412ab4a7f2.png "点击查看原始大小图片")
 ###4. Add dependences library:
Project References -> Targets -> Build Phases -> Link Binary With LibrarysAdd two library:- libbz.dylib
- libz.dylib
- libiconv.2.4.0.dylib

![](http://dl.iteye.com/upload/attachment/0077/0405/76568674-6942-3d9c-919b-b7c265fc89a3.png)
 ###5. Add Header Search Paths:
Project References -> Targets -> Build Settings -> **Header Search Paths**1. add ffmpeg core header paths:![](http://dl.iteye.com/upload/attachment/0077/0407/97b61036-201b-37c9-8355-9500aa0ade29.png "点击查看原始大小图片")
 2. add x264 header paths:![](http://dl2.iteye.com/upload/attachment/0085/0323/7746423e-3af6-329e-a827-d5c4ee037f6c.png)
   
###6. Now, run project ...
![](http://dl.iteye.com/upload/attachment/0077/0409/4ac5fe50-df31-3dee-80ff-936c7605973c.png "点击查看原始大小图片")
 
Some useful document:
[《How to prepare your mac for ios development with ffmpeg libraries》](http://www.tangentsoftworks.com/blog/2012/11/12/how-to-prepare-your-mac-for-ios-development-with-ffmpeg-libraries/)
[《ffmpeg configure options》 -pdf](http://www.tangentsoftworks.com/blog/wp-content/uploads/2012/11/FFmpeg-Configure-Options.pdf)
