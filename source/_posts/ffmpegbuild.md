title: ffmpeg 编译静态库，搞了好久，终于搞成功了.根据网上教程做的
date: 2014-05-13 17:37:00
categories: 技术
tags: 
description:
---
1.首先，先有ffmpeg，然后需要另外的一个文件，gas-preprocessor.pl  所有的一切具备之后，下面让我们开始编译。
2.然后我在ffmpeg里建了一个文件夹，命名为armv7，这个自己标记，记的是啥意思就行

<!--more-->

3../configure --prefix=/Users/zhangdongqiankun/Downloads/kolyvan-kxmovie-2c5324b/kxmovie/ffmpeg-iphone-build/armv7 --disable-ffmpeg --disable-ffplay --disable-ffserver --enable-dxva2 --enable-vda --enable-vdpau --disable-debug --enable-cross-compile --enable-gpl --enable-pic --disable-asm --sysroot=/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS7.1.sdk --target-os=darwin --arch=armv7 --cpu=cortex-a8 --extra-cflags='-arch armv7' --extra-ldflags='-arch armv7' --cc=/Applications/XCode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/clang  --extra-ldflags=-L/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS7.1.sdk/usr/lib/system
解释，1）.把刚才建立的文件路径直接赋值给--prefix，这个编译后的文件就会保存到上面建立的文件里
2）.iPhoneOS7.1版本，是电脑里iOS的版本，我电脑里有两个6.1和7.1，这里用的7.1，回头再试6.1的
3）.可以看到configure 里 --arch=armv7 ，这个生成的armv7 是iPhone5等试用的版本，模拟器用i386,iphone 5s 用armv7s，一会全部生成，合并一下
在网上找了很多，用--prefix直接给路径成功了，别的一直就配置失败
4.输入上面这句回车，成功后会出现类似：
License: LGPL version 2.1 or later
Creating config.mak and config.h...
libavutil/avconfig.h is unchanged


WARNING: pkg-config not found, library detection may fail.
localhost:ffmpeg apple$ 
5.然后输入 sudo make，这个编译时间有点长，编译完成会出现下面界面，这个界面一直就这样，网上查了，大家说到达 STRIPffprobe就是成功了,所以继续下一步，我是新建了一个shell跑下面的代码
![]()

6.继续输入代码 sudo make install，这个执行很短，生成静态库，我是好几个代码都没走这个，一直纠结为啥没出来静态库，掉坑里了。。。
![]()

7，然后直接去刚才建的文件里查看生成的静态库，
![]()

看！成功了。^_^
8.继续整armv7s的静态库 ，
执行
 make clean 命令就可以了。  接下来你可以照此方法编译armv7,跟armv7s框架下的。

建立armv7s目录，其他步骤同上
./configure --prefix=/Users/zhangdongqiankun/Downloads/kolyvan-kxmovie-2c5324b/kxmovie/ffmpeg-iphone-build/armv7s --disable-ffmpeg --disable-ffplay --disable-ffserver --enable-dxva2 --enable-vda --enable-vdpau --disable-debug --enable-cross-compile --enable-gpl --enable-pic --disable-asm --sysroot=/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS7.1.sdk --target-os=darwin --arch=armv7s
 --cpu=cortex-a8 --extra-cflags='-arch armv7s' --extra-ldflags='-arch armv7s' --cc=/Applications/XCode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/clang  --extra-ldflags=-L/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS7.1.sdk/usr/lib/system

9.
继续整i386的静态库 ，
执行 make clean 命令就可以了。  接下来你可以照此方法编译i386,跟i386框架下的。

建立i386目录，其他步骤同上
./configure --prefix=/Users/zhangdongqiankun/Downloads/kolyvan-kxmovie-2c5324b/kxmovie/ffmpeg-iphone-build/i386 --disable-ffmpeg --disable-ffplay --disable-ffserver --enable-dxva2 --enable-vda --enable-vdpau --disable-debug --enable-cross-compile --enable-gpl --enable-pic --disable-asm --sysroot=/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS7.1.sdk --target-os=darwin --arch=i386 --cpu=cortex-a8 --extra-cflags='-arch i386' --extra-ldflags='-arch i386' --cc=/Applications/XCode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/clang  --extra-ldflags=-L/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS7.1.sdk/usr/lib/system

我这边没好使，还没解决
问题如下：
![]()

这个继续研究


10.运行lipo方法，合并静态库

lipo -create lib/i386/libavcodec.a lib/arm7/libavcodec.a lib/arm7s/libavcodec.a -output lib/libavcodec.a
lipo -create lib/i386/libavformat.a lib/arm7/libavformat.a lib/arm7s/libavformat.a -output lib/libavformat.a
lipo -create lib/i386/libavdevice.a lib/arm7/libavdevice.a lib/arm7s/libavdevice.a -output lib/libavdevice.a
lipo -create lib/i386/libavutil.a lib/arm7/libavutil.a lib/arm7s/libavutil.a -output lib/libavutil.a
lipo -create lib/i386/libswscale.a lib/arm7/libswscale.a lib/arm7s/libswscale.a -output lib/libswscale.a
这样就可以放到项目用了


