title: FFmpeg学习记录、整理
categories: 技术
tags: ffmpeg, player
description:

---

“FFmpeg”这个单词中的“FF”指的是“Fast Forward”[2]。有些新手写信给“FFmpeg”的项目负责人，询问FF是不是代表“Fast Free”或者“Fast Fourier”等意思，“FFmpeg”的项目负责人回信说：“Just for the record, the original meaning of "FF" in FFmpeg is "Fast Forward"...”

<!--more-->
[目录](#)
* [基本介绍](#基本介绍)
* [常用命令解析](#常用命令解析)
* [添加水印](#添加水印)


------------------------------------------------

# 基本介绍

### 组成组件：

| 命令 | 说明 | 
| ------ | ------ |
| ffmpeg | 一个命令行工具，用来对视频文件转换格式，也支持对电视卡即时编码 |
| ffserver | 一个HTTP多媒体即时广播流服务器，支持时光平移 |
| ffplay | 一个简单的播放器，基于SDL与FFmpeg库 |
| libavcodec | 包含全部FFmpeg音频/视频编解码库 |
| libavformat | 包含demuxers和muxer库 |
| libavutil | 包含一些工具库 |
| libpostproc | 对于视频做前处理的库 |
| libswscale | 对于视频作缩放的库 |

### 参数：

FFmpeg可使用众多参数，参数内容会根据ffmpeg版本而有差异，使用前建议先参考参数及编解码器的叙述。此外，参数明细可用ffmpeg -h显示；编解码器名称等明细可用ffmpeg -formats显示。
下列为较常使用的参数：

1. 主要参数

|【参数】	|【说明】|【示例】|
| ------ | ------ | ------ |
| -i "路径" | 指定需要转换的文件路径 | -i ./mm.mp4 | 
| -f | 设置输出格式。 | 
| -y | 若输出文件已存在时则覆盖文件。 | 
| -fs | 超过指定的文件大小时则结束转换。 | 
| -ss | 从指定时间开始转换。 | 
| -t | 从-ss时间开始转换（如-ss 00:00:01.00 -t 00:00:10.00即从00:00:01.00开始到00:00:11.00）。 | 
| -title | 设置标题。 | 
| -timestamp | 设置时间戳。 | 
| -vsync | 增减Frame使影音同步。 | 

2. 视频参数

|【参数】	|【说明】|【示例】|
| ------ | ------ | ------ |
| -bitexac | 使用标准比特率|
| -b | v——设置视频流量，默认为200Kbit/秒。指定压缩比特率（单位请引用下方注意事项）| -b 1500 |
| -r | 设置帧率值，默认为25。帧速率(非标准数值会导致音画不同步【标准值为15或29.97】)| -r 15 |
| -s | 设置画面的宽与高。指定分辨率大小| -s 320*240 |
| -aspect | 设置画面的比例。
| -vn | 不处理视频，于仅针对声音做处理时使用。|
| -vcodec xvid | 使用xvid压缩|
| -vcodec( -c:v ) | 设置视频视频编解码器，未设置时则使用与输入文件相同之编解码器。|
| -qmin | 设定最小质量 | -qmin 10 |
| -qmax | 与-qmin相反，可以与-qmin同时使用 | -qmax 30 |
| -sameq |  使用与源视频相同的质量 |

3. 声音参数

|【参数】	|【说明】|【示例】|
| ------ | ------ | ------ |
| -b:a | 设置每Channel（最近的SVN版为所有Channel的总合）的流量。（单位请引用下方注意事项） | 
| -ar | 设定声音采样率(8000，11025，22050) | -ar 22050 |
| -ac | 设定声道数：1为单声道，2为立体声 | -ac 2 |
| -acodec aac | 设置声音编解码器，未设置时与视频相同，使用与输入文件相同之编解码器。 | 
| -an | 不处理声音，于仅针对视频做处理时使用。 | 
| -vol | 设置音量大小，256为标准音量。（要设置成两倍音量时则输入512，依此类推。） | 
| -ab <比特率> | 设定声音比特率(-ac设为立体声时要以一半比特率来设置，比如192kbps的就设成96) | -ab 96 |


* 注意事项
以-b:v及-b:a首选项流量时，根据使用的ffmpeg版本，须注意单位会有kbits/sec与bits/sec的不同。（可用ffmpeg -h显示说明来确认单位。）
例如，单位为bits/sec的情况时，欲指定流量64kbps时需输入 -b:a 64k；单位为kbits/sec的情况时则需输入 -b:a 64。
以-acodec及-vcodec所指定的编解码器名称，会根据使用的ffmpeg版本而有所不同。例如使用AAC编解码器时，会有输入aac与libfaac的情况。此外，编解码器有分为仅供解码时使用与仅供编码时使用，因此一定要利用ffmpeg -formats确认输入的编解码器是否能运作。

[参考wiki百科](https://zh.wikipedia.org/wiki/FFmpeg)


------------------------------------------------

# 常用命令解析


下载一个视频到本地并转换为MP4类型  ffmpeg -i 远程url或者本地视频  到本地
```bash
ffmpeg -i http://videodata.url ./成都日本版.mp4
```

下载一个视频到本地并转换成mp3类型  ffmpeg -i 远程url或者本地视频  到本地
```bash
ffmpeg -i http://videodata.url ./成都日本版.mp4
```

【转换文件格式的同时抓缩微图】   
```base
 ffmpeg -i "test.avi" -y -f image2 -ss 8 -t 0.001 -s 350x240 "test.jpg"  
```
讲解： -i 后面跟输入文件  -y 覆盖  -f 转换格式为image2  -ss 起点 -t 时长  -s 指定分辨率大小  "test.jpg" 最后生成的文件

【对已有flv抓图】   
```
 ffmpeg -i "test.flv" -y -f image2 -ss 8 -t 0.001 -s 350x240 "test.jpg"  
```
-ss后跟的时间单位为秒

 



------------------------------------------------


# 添加水印

### 1. 添加图片水印

```
// 添加图片水印
  ffmpeg -i inputfile -vf  "movie=masklogo,scale= 60: 30[watermask]; [in] [watermask] overlay=30:10 [out]" outfile

//  在视频mm.mp4上添加水印图64.png 位置为右上角，输出新文件为mm1.mp4
ffmpeg -i mm.mp4 -vf "movie=64.png ,scale=64*64[watermask];[in][watermask] overlay=main_w-overlay_w-40:30 [out]" ./mm1.mp4

```

marklogo:添加的水印图片；

scale：水印大小，水印长度＊水印的高度；

overlay：水印的位置，距离屏幕左侧的距离＊距离屏幕上侧的距离；mainW主视频宽度， mainH主视频高度，overlayW水印宽度，overlayH水印高度

　　左上角overlay参数为 overlay=0:0

　　右上角为 overlay= main_w-overlay_w:0

　　右下角为 overlay= main_w-overlay_w:main_h-overlay_h

　　左下角为 overlay=0: main_h-overlay_h

 上面的0可以改为5，或10像素，以便多留出一些空白。

### 2. 水印合流

```
   ffmpeg -i input -i logo -filter_complex 'overlay=10:main_h-overlay_h-10' output
```

input:输入流

logo：水印文件，也可以是一个流。

注意：需要编译时把相应的解码器编译。例如PNG图片。需要编译PNG解码器。Ffmpeg才能够识别图片文件，把图片做为一 种流。注意：PNG图片必须含有alpha通道。Overlay过滤器是根据alpha通道来进行复盖的。所以，你想要透明效果时，须先制做一张透明的PNG图片。

output：输出流

也可以用下面命令：  ffmpeg -i input  -vf 'movie=long.png[logo];[in][logo]overlay=10:10[out]' output     ，movie过滤器用来把两个流组合成一个流。它有一个输出PAD。


### 字幕文件转换

字幕文件有很多种，常见的有 .srt , .ass 文件等,下面使用FFmpeg进行相互转换。

* 将.srt文件转换成.ass文件

```
ffmpeg -i subtitle.srt subtitle.ass
```

将.ass文件转换成.srt文件
```
ffmpeg -i subtitle.ass subtitle.srt
```

集成字幕，选择播放
```
ffmpeg -i input.mp4 -i subtitles.srt -c:s mov_text -c:v copy -c:a copy output.mp4
```

解析：
-c:s 设置字幕解码器。未设置是字幕解码与输入文件相同   
-c:v 设置视频视频编解码器，未设置时则使用与输入文件相同之编解码器 
-c:a 设置声音编解码器，未设置时与视频相同，使用与输入文件相同之编解码器。


* 嵌入SRT字幕到视频文件

单独SRT字幕
字幕文件为subtitle.srt
```
ffmpeg -i video.avi -vf subtitles=subtitle.srt out.avi
```

嵌入在MKV等容器的字幕
将video.mkv中的字幕（默认）嵌入到out.avi文件
```
ffmpeg -i video.mkv -vf subtitles=video.mkv out.avi
```

将video.mkv中的字幕（第二个）嵌入到out.avi文件
```
ffmpeg -i video.mkv -vf subtitles=video.mkv:si=1 out.avi
```

嵌入ASS字幕到视频文件
```
ffmpeg -i video.avi -vf "ass=subtitle.ass" out.avi
```

不能加载fontconfig文件
```
Fontconfig error: Cannot load default config file
[Parsed_ass_0 @ 0000000002bfa3e0] No usable fontconfig configuration file found,
 using fallback.
Fontconfig error: Cannot load default config file
```
出现类似错误的原因是无法加载字体配置文件。


-------------------


其他常用命令

1.    提取视频 （Extract Video）
```
ffmpeg -i Life.of.Pi.has.subtitles.mkv -vcodec copy –an  videoNoAudioSubtitle.mp4
```
 参考：[http://www.cnblogs.com/wainiwann/p/4128154.html](http://www.cnblogs.com/wainiwann/p/4128154.html)
2.    提取音频（Extract Audio）
```
ffmpeg -i Life.of.Pi.has.subtitles.mkv -vn -acodec copy audio.ac3
```
 参考：[http://stackoverflow.com/questions/9913032/ffmpeg-to-extract-audio-from-video](http://stackoverflow.com/questions/9913032/ffmpeg-to-extract-audio-from-video)
3.    提取字幕（Extract Subtitle）
```
ffmpeg -i Life.of.Pi.has.subtitles.mkv-map 0:s:0 sub1.srt
```
参考：[http://superuser.com/questions/583393/extract-subtitle-from-video](http://superuser.com/questions/583393/extract-subtitle-from-video)


***********************


***********************
