
title:  Python爬虫下载‘凡人修仙传’有声小说
---

* 方法一：
使用 urllib.urlretrieve(）方法下载

```
# -*- coding: utf-8 -*-  
import urllib   
import urllib2   
#import request     
# 下载地址前缀  
url = 'http://t.kanshulou.com/玄幻/凡人修仙传/'  
mp3Count = 0  
while (mp3Count < 1631):  
mp3Count = mp3Count + 1;  
#    格式化字符串 即 3.mp3 -> 003.mp3  
downloadURL = "%s%03d.mp3" % (url,mp3Count)  
print "%s" % downloadURL  
#    下载MP3代码  
urllib.urlretrieve("%s" % downloadURL, "%03d.mp3" % mp3Count)  

print "下载完成" 

```
<!--more-->

![image](/img/5DB7932B-8382-41BE-877B-0D420CBF63A9.png)

* 方法二：

```
#!/usr/bin/env python  
#! -*- coding: utf-8 -*-  
import urllib,urllib2,cookielib  
import re  
import os,time  
import datetime  

oldNow = datetime.datetime.now()  
print "开始时间 %s" % oldNow  
urlp = 'http://t.kanshulou.com/玄幻/凡人修仙传/003.mp3'  

urlopen = urllib.URLopener()  
fp = urlopen.open(urlp)  
data = fp.read()  
#清除并以二进制写入  
f = open("003.mp3", 'w+b')  
f.write(data)  
f.close()  

newNow = datetime.datetime.now()  
# .microseconds  
print "结束时间 %s" % newNow  
# 执行秒数  
print "耗时%ds" % (newNow-oldNow).seconds  
# 执行微秒数  
print "耗时%dms" % (newNow-oldNow).microseconds  
```
![image](/img/6DAFBEC9-58AD-4862-86A6-503CA3C27E68.png)

