title: 整理和收集一些私有api知识和技巧，不可上传AppStore，否则会被拒绝
date: 2014-05-16 10:26:00
categories: 技术
tags: 
description:
---
`//知道怎么用私有api，要怎么获得``   ``//要导入#import
 <objc/runtime.h>``   ``NSString``*className
 = NSStringFromClass([``UIView``class``]);``   ``//这里是uiview，可以改成自己想要的``   ` `   ``const``char``*cClassName
 = [className``
UTF8String``];``   ` `   ``id``theClass
 = objc_getClass(cClassName);``   ` `   ``unsigned``int``outCount;``   ` `   ``Method``*m
 =  class_copyMethodList(theClass,&outCount;);``  ` `   ``NSLog(``@"%d"``,outCount);``   ``for``(``int``i
 = ``0``;
 i<outCount; i++) {``       ``SEL``a
 = method_getName(*(m+i));``       ``NSString``*sn
 = NSStringFromSelector(a);``       ``NSLog(``@"%@"``,sn);` `   ``}``
``*********************************************************************``
```下面已实验，可以的
装载请注明 http://www.cnblogs.com/xiongwj0910/archive/2012/08/16/2642988.html
第一天。搜索了一下 “iOS越狱开发” 搜索的东西比较杂乱。总之还是先安装了class－dump工具
class-dump 这是一个用于导出frameWork文件中私有头文件的工具。想进行越狱开发 必不可少。
以下为转载的博文
首先介绍下private API 它共分为两类：1 在官方文档中没有呈现的API（在frameworks 下隐藏）2 苹果明确申明不能使用的API ，在privateFrameworks 下然后我们用到的工具是class-dump+DumpFrameworks.plclass-dump可以从编译后的Objective-C的二进制文件中提取对应的数据结构及函数等声明class-dump下载地址[http://www.codethecode.com/projects/class-dump/](http://www.codethecode.com/projects/class-dump/ "http://www.codethecode.com/projects/class-dump/")DumpFrameworks.pl是一个脚本，会在你的主目录下生成private的.h文件DumpFrameworks.pl下载地址：[http://ericasadun.com/HeaderDumpKit/](http://ericasadun.com/HeaderDumpKit/ "http://ericasadun.com/HeaderDumpKit/")git地址：[https://github.com/shuhongwu/HackSpringDemo/blob/master/DumpFrameworks.pl](https://github.com/shuhongwu/HackSpringDemo/blob/master/DumpFrameworks.pl)pl脚本需要简单的修改一下路径。 用法：1 将下载好的 class-dump 放入usr/local/bin 下.    如果 ‘/usr/local/bin’ 不知道在哪里，可以在terminal 下输入 ‘open -a Finder /usr/local/bin’ 以便打开目录.   记着 class-dump 要 使用 chmod 修改下执行权限.   例如：在usr/local/bin 对 class-dump 修改，可以这    样在terminal 切换到 usr/local/bin 目录下: chmod 777 class-dump .2 将DumpFrameworks.pl 放入任意目录下.同样需要修改执行权限. 3. OK..现在所有的准备工作作好了. 我们在 terminal 的任意目录下 输入 ： ./DumpFrameworks.pl   等待…   会有一个Heards 文件夹在你的主目录下. 里面包含了 Frmeworks 和 privateFrameworks 下所有的私有 API 这里说明一下，我在使用的时候有时候会报错，class-dump报错：Warning: This file does not contain any Objective-C runtime information. 目前还没有找到解决方案，估计是有些Frmeworks是用C写的，所以没法导出来。 usr/local/bin这个路径我是没有找到的。不过没关系  只需要 完整的class－dump路径 －H 完整的框架路径 -o -Header（文件夹名称）就可以了。例如:/Users/ws/Desktop/class-dump/class-dump -H /Volumes/Xcode/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS5.1.sdk/System/Library/Frameworks/CoreTelephony.framework/CoreTelephony
  -o Headers /Users/ws/Desktop/class-dump/class-dump 是我的完整路径 /Volumes/Xcode/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS5.1.sdk/System/Library/Frameworks/CoreTelephony.framework/CoreTelephony
 这个是完整的CoreTelephony框架路径Headers 文件夹名称 运行之后就会有文件导入到Headers文件夹中了。 后续会有相应更详细的文章。
`  ` 
`
`