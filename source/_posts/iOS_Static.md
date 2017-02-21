title: iOS项目工程中创建静态库文件(.a)库文件
date: 2015-07-02 18:10:00
categories: 技术
tags: 
description:
---
步骤1.创建工程HLStaticTest
![](http://img.blog.csdn.net/20150702183251117?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvbGlob25nbGk1Mjg2Mjg=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center)![](http://img.blog.csdn.net/20150702183311814?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvbGlob25nbGk1Mjg2Mjg=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center)
步骤2.创建静态库文件
![](http://img.blog.csdn.net/20150702183332392?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvbGlob25nbGk1Mjg2Mjg=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center)

![](http://img.blog.csdn.net/20150702183351991?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvbGlob25nbGk1Mjg2Mjg=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center)

![](http://img.blog.csdn.net/20150702183413925?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvbGlob25nbGk1Mjg2Mjg=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center)


步骤3. 关闭HLStatic，回到HLStaticTest
![]()
![]()![](http://img.blog.csdn.net/20150702183511880?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvbGlob25nbGk1Mjg2Mjg=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center)![](http://img.blog.csdn.net/20150702183544277?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvbGlob25nbGk1Mjg2Mjg=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center)
![]()

Targets - 》Build Phases ->Link Binary With Libraries![](http://img.blog.csdn.net/20150702183609116?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvbGlob25nbGk1Mjg2Mjg=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center)
![](http://img.blog.csdn.net/20150702183625515?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvbGlob25nbGk1Mjg2Mjg=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center)
![]()![](http://img.blog.csdn.net/20150702183646135?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvbGlob25nbGk1Mjg2Mjg=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center)
![]()

然后进入到  Targets -> Build Setting ->Header Search Paths
![]()![](http://img.blog.csdn.net/20150702183709714?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvbGlob25nbGk1Mjg2Mjg=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center)
![]()![](http://img.blog.csdn.net/20150702183728962?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvbGlob25nbGk1Mjg2Mjg=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center)

步骤 4. 进入AppDelegate

![]()![]()![](http://img.blog.csdn.net/20150702183745967?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvbGlob25nbGk1Mjg2Mjg=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center)

![]()![](http://img.blog.csdn.net/20150702183802106?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvbGlob25nbGk1Mjg2Mjg=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center)

工程中创建静态库文件(.a)库文件 成功



