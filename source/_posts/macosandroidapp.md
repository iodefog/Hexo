title: Mac OS上反编译android app的环境搭建
date: 2016-01-18 11:22:00
categories: 技术
tags: 
description:
---
## 已测试，可以反编译出源代码。以下为参考，感谢作者


很多时候，我们出于学习或者安全测试等的目的，需要对andorid app的安装文件进行反编译来查看源代码，下面我们来一起搭建Mac os 下的反编译环境。
## 安装环境
建立基本文件夹
```
	mkdir -p ~/study/apkkiller/soft/bin
	mkdir -p ~/study/apkkiller/soft/src
	mkdir -p ~/study/apkkiller/output/
```
	
<!--more-->

	
andorid app的安装文件为apk包，要反编译apk文件，需要下载apktool和dex2jar这两个软件，它们均托管在google code上：
	http://code.google.com/p/android-apktool/
	http://code.google.com/p/dex2jar/
	
从以上两个页面找到下载地址，这里我们找到的是 apktool1.5.2 和 dex2jar-0.0.9.15的下载地址：

```
	cd ~/study/apkkiller/soft/src
	wget http://android-apktool.googlecode.com/files/apktool1.5.2.tar.bz2
	wget http://dex2jar.googlecode.com/files/dex2jar-0.0.9.15.zip
```

解压后文件存放在如下目录:

```
	~/study/apkkiller/soft/src/apktool1.5.2
	~/study/apkkiller/soft/src/dex2jar-0.0.9.15
```
	
为了方便使用，建立两个软连接:

```objc
ln -s ~/study/apkkiller/soft/src/apktool1.5.2/apktool.jar ~/study/apkkiller/soft/bin/apktool
ln -s ~/study/apkkiller/soft/src/dex2jar-0.0.9.15/dex2jar.sh ~/study/apkkiller/soft/bin/dex2jar
	
```

## 测试反编译环境

下面开始来反编译我们的测试apk文件，看看环境是否可以正常运行

```objc
	cd ~/study/apkkiller
	mkdir -p ~/study/apkkiller/output/test/source
	mkdir -p ~/study/apkkiller/output/test/result
	
	cp ./test.apk ./output/test/source/test.zip
	unzip ./output/test/source/test.zip -d ./output/test/source/test
	
	cp ./output/test/source/test/classes.dex ./output/test/source/classes.dex
	~/study/apkkiller/soft/bin/dex2jar ./output/test/source/classes.dex
	# output ./output/test/source/classes_dex2jar.jar
```

要查看反编译后的文件，可以下载`jd-gui`工具，打开上面生成的`./output/test/source/classes_dex2jar.jar` 文件即可,
 该工具可以将源码包都导出来。jd-gui从下面的地址下载：

```
	http://jd.benow.ca/
	http://jd.benow.ca/jd-gui/downloads/jd-gui-0.3.5.osx.i686.dmg
```
	
apk的资源文件都存在上面我们解压的文件夹`./output/test/source/test`中，里面有很多xml文件，但是是加密的，无法直接查看。这时，就需要用到apktool工具了：
```
	java -jar ~/study/apkkiller/soft/bin/apktool d ./test.apk ./output/test/source/test_resource
```
	
将导出的源码和资源文件合并，就得到我们想要的结果了。
原文链接：[http://tabalt.net/blog/decompile-andoroid-app-on-mac/](http://tabalt.net/blog/decompile-andoroid-app-on-mac/)
本博文章如无说明均为原创，转载时请注明以上链接
