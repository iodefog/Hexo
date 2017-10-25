title: 利用Python实现BT种子转化为磁力链接
date: 2017-02-027 17:46:00
categories: 技术
tags: python, bt, magnet, torrent
description:
---


利用Python实现BT种子转化为磁力链接

方案是：利用python的bencode模块，用起来比较简单

* 首先安装 pip [getpip] 地址:https://bootstrap.pypa.io/get-pip.py
[getpip]:https://bootstrap.pypa.io/get-pip.py

<!--more-->


* 第二 安装bencode

```python	
pip install bencode
```

* 第三 vim，生成bt2magnet.py

[bt2magnet.py]
[bt2magnet.py]:./python/bt2magnet.py

```python
#! /usr/local/bin/python 
# -*- coding: cp936 -*-

# @desc python通过BT种子生成磁力链接  
# @date 2015/11/10 
# @author pythontab.com 
import bencode 
import sys 
import hashlib 
import base64 
import urllib 
#获取参数 
torrentName = sys.argv[1] 
#读取种子文件 
torrent = open(torrentName, 'rb').read() 
#计算meta数据 
metadata = bencode.bdecode(torrent) 
hashcontents = bencode.bencode(metadata['info']) 
digest = hashlib.sha1(hashcontents).digest() 
b32hash = base64.b32encode(digest) 
#打印 
print 'magnet:?xt=urn:btih:%s' % b32hash

```
* 最后， 在命令行里执行命令

```
python bt2url.py 70A429316D53032552B67734D53AB0BC51A2A4D9.torrent

```

* 结果:

```
magnet:?xt=urn:btih:OCSCSMLNKMBSKUVWO42NKOVQXRI2FJGZ
```
