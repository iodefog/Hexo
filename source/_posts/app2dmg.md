title: appdmg 转换 mac app 到 DMG文件
categories: 技术
-----------
#[appdmg 转换 mac app 到 DMG文件](#appdmg 转换 mac app 到 DMG文件)
#[制作ICNS图标](#制作ICNS图标)

# appdmg 转换 mac app 到 DMG文件

初始化
```
npm install -g appdmg
```

<!--more-->

用法
```
appdmg <json-path> <dmg-path>
```

例如：
```
appdmg ./mvideo.json ~/Desktop/mvideo.dmg

```

json文件

```
{
  "title": "MVideo",
  "icon": "Now96.icns",
  "background": "test-background.jpg",
  "contents": [
    { "x": 448, "y": 344, "type": "link", "path": "/Applications" },
    { "x": 192, "y": 344, "type": "file", "path": "MVideo.app" }
  ]
}
```

详解json文件

![image](/img/app2dmg_help.png)
 

# 制作ICNS图标

可以通过终端去生成icns 文件.
1.打开工具（可以选择内置的终端，或者用iTerm）
2.代码如下（例如：）
```
cd ~/Desktop
mkdir test.iconset

```
3.用你制作好的png文件copy这个文件夹里
```
ls 
icon_128x128.png icon_128x128@2x.png icon_256x256.png icon_256x256@2x.png 
icon_512x512.png icon_512x512@2x.png

```
4.切换到上一层，生成icns
```
cd ..
iconutil -c icns test.iconset

```
5.生成icns，完成


参考：

[https://www.npmjs.com/package/appdmg](https://www.npmjs.com/package/appdmg)
[https://blog.caicai.me/post/icns](https://blog.caicai.me/post/icns)

