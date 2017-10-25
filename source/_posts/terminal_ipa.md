title: 终端命令行打包成ipa，基础用法
date: 2015-07-24 16:35:00
categories: 技术
tags: 
description:
---
第一步，切到项目目录
例如   cd /Users/lhl/Downloads/iOSAppTime-master


第二步 执行命令
xcodebuild clean


完事后，执行
xcodebuild build

<!--more-->


注意：如果使用了pod，使用上面可能会报错，编译失败，请使用下面代码执行
xcodebuild -workspace ~/Documents/Codings/Dev/ios-user/yourAPP.xcworkspace -scheme yourAPP ONLY_ACTIVE_ARCH=NO TARGETED_DEVICE_FAMILY=1 DEPLOYMENT_LOCATION=YES



执行完成后结尾出现
![](http://img.blog.csdn.net/20150724162533599?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQv/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center)



第三步 ： 把 .app 转换成 ipa
这里需要使用 xcrun
xcrun -sdk iphoneos packageApplication -v  /Users/lhl/Downloads/iOSAppTime-master/build/Release-iphoneos/AppTime.app -o ~/Desktop/AppTime.ipa


然后桌面就会有ipa包了
![]()



其他具体用法如下：  
/usr/bin/xcrun -sdk iphoneos PackageApplication –v [{TARGET}.app] -o [{TARGET}.ipa] --sign [{Iphone Distribution:xxx}] –embed [{xxx.mobileprovision}] 
其中：-v 对应的是app文件的绝对相对路径 –o 对应ipa文件的路径跟文件名 –sign 对应的是 发布证书中对应的公司名或是个人名 –embed 对应的是发布证书文件 注意如果对应的Distribution 配置中已经配置好了相关证书信息的话 –sign 和 –embed可以忽略






