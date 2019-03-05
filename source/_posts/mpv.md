title:  mpv播放器在mac上的使用

---

## 安装

### 1. brew 安装 

```
brew install mpv
```

### 2.源码安装

下载源码：[https://github.com/mpv-player/mpv/](https://github.com/mpv-player/mpv/)

```
$ ./bootstrap.py
$ ./waf configure
$ ./waf
$ ./waf install

```

### 生成app

网上说可以使用 brew linkapps mpv,但是新版本的brew已经将linksapps操作给删掉了.
直接执行 brew cask install mpv即可, 安装之后发现mpv已经出现在了lauchpad里面并且可以打开使用了.

### 配置

```
// 切换到mpv文件夹
$ /Users/yourname/.config/mpv

// 创建配置文件
$ touch mpv.conf
```

附mpv.conf:
```
# mpv.conf
hwdec=auto
autofit-larger=92%
video-sync=display-resample
sub-codepage=enca:zh:utf8
sub-auto=fuzzy
sub-font-size=40
sub-shadow-offset=0
sub-color="#ffffffff"
sub-font="STZhongsong"
sub-codepage=utf8:gb18030
screenshot-template=mpv-screenshot-%f-%p
screenshot-format=png
osd-font="STZhongsong"
osd-font-size=36
--script=/Users/yourname/.config/mpv/autoload.lua
```
* 注意使用的时候把最后一行的yourname改掉

### 播放

```
$ mpv http://dlhls.cdn.zhanqi.tv/zqlive/43626_vQOn9.m3u8
```
