title: 命令行提取assets.car中的图片，2x and 3x图片
date: 2016-03-18 16:46:00
categories: 技术
tags: 
description:
---
怎么提取assets.car中的图片，找到了这篇文章：[提取assets.car中的图片
 :: Coding Forever](http://io.diveinedu.com/2015/01/15/%E6%8F%90%E5%8F%96Assets.car%E4%B8%AD%E7%9A%84%E5%9B%BE%E7%89%87.html) 
第一个方法试了不行，app在我的OS X 10.10上打不开。
最后用了第二个方法，不过原始链接里面不支持@3x图片，因而选择了别人fork的一个版本：[G-P-S/cartool: Export images
 from OS X / iOS .car CoreUI archives](https://github.com/G-P-S/cartool) 

<!--more-->

clone后在你的Xcode里编译一下，得到cartool文件，然后执行命令：./cartool Assets.car outputDir，就可以提取图片了。


转自：[http://my.oschina.net/ioslighter/blog/624715](http://my.oschina.net/ioslighter/blog/624715)

git代码路径：[https://github.com/G-P-S/cartool](https://github.com/G-P-S/cartool)


