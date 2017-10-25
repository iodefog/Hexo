title: iOS项目工程中创建Framework库文件
date: 2015-07-02 17:29:00
categories: 技术
tags: 
description:
---
步骤1.新建一工程 MyFMTest

<!--more-->


![]()![](http://img.blog.csdn.net/20150702213939584?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvbGlob25nbGk1Mjg2Mjg=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center)
![](http://img.blog.csdn.net/20150702213951172?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvbGlob25nbGk1Mjg2Mjg=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center)

![](http://img.blog.csdn.net/20150702214006038?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvbGlob25nbGk1Mjg2Mjg=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center)



步骤二，新建静态库  MyFrameWork

![](http://img.blog.csdn.net/20150702214029775?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvbGlob25nbGk1Mjg2Mjg=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center)![](http://img.blog.csdn.net/20150702214041432?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvbGlob25nbGk1Mjg2Mjg=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center)![](http://img.blog.csdn.net/20150702214053078?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvbGlob25nbGk1Mjg2Mjg=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center)![](http://img.blog.csdn.net/20150702214105576?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvbGlob25nbGk1Mjg2Mjg=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center)




步骤3.关闭MyFrameWork，然后把myFramework库添加MyFMTest里（如图）


![](http://img.blog.csdn.net/20150702214126024?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvbGlob25nbGk1Mjg2Mjg=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center)

![](http://img.blog.csdn.net/20150702214137289?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvbGlob25nbGk1Mjg2Mjg=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center)

把 MyFrameWork 库文件添加进 Link Binary With Libraries

![](http://img.blog.csdn.net/20150702214147727?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvbGlob25nbGk1Mjg2Mjg=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center)

在MyFramework工程里新建 FMObject 文件

![](http://img.blog.csdn.net/20150702214157705?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvbGlob25nbGk1Mjg2Mjg=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center)![](http://img.blog.csdn.net/20150702214207946?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvbGlob25nbGk1Mjg2Mjg=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center)![](http://img.blog.csdn.net/20150702214218732?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvbGlob25nbGk1Mjg2Mjg=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center)

然后在MyFrameWork.h 里如下添加头文件

![](http://img.blog.csdn.net/20150702214228323?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvbGlob25nbGk1Mjg2Mjg=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center)

把FMObject 从Project 挪到 Public 组里

![](http://img.blog.csdn.net/20150702214239092?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvbGlob25nbGk1Mjg2Mjg=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center)
步骤4  在 AppDeleagate 里如下引用文件即可正常编译成功，  import <MyFrameWork/MyFrameWork.h>
![](http://img.blog.csdn.net/20150702214249566?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvbGlob25nbGk1Mjg2Mjg=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center)



步骤4. 如下编译，Build Success， 成功。


![](http://img.blog.csdn.net/20150702214258869?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvbGlob25nbGk1Mjg2Mjg=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center)

总结：就可以把项目分成多个Framework控制的小模块去控制。结构也更加清晰易懂。


如果需要支持ios7，则需要把framework改成静态库
![](http://img.blog.csdn.net/20170211102635464?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvbGlob25nbGk1Mjg2Mjg=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center)





注意：如果引用类别方法出现以下错误，则需要找到主工程的 target －－Build Setting－－Linking－－更改其 Other Linker Flags 为： -all_load 或 -force_load 即可。

![](http://img.blog.csdn.net/20170211102424432?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvbGlob25nbGk1Mjg2Mjg=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center)

![](http://img.blog.csdn.net/20170211102443138?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvbGlob25nbGk1Mjg2Mjg=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center)



、

