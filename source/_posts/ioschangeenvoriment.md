title: iOS 快速切换开发环境
date: 2015-03-12 14:55:00
categories: 技术
tags: 
description:
---

转自：  [http://blog.csdn.net/yadonghaoren/article/details/38423159](http://blog.csdn.net/yadonghaoren/article/details/38423159)


step1: 添加自定义的配置
project Navigationor --> PROJECT --> Info -->Configurations(+) -->Depulicate"Debug" Configuration. 如图：
![](http://img.blog.csdn.net/20140807180858812?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQveWFkb25naGFvcmVu/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center)
注意：
选择Depulicate "Debug" Configuration 则新的配置环境是debug模式。
选择Depulicate “Release" Configuration 则新的配置环境是Release模式。

<!--more-->


step2: 添加关键字
****-info.plists --> add {Key:Configuration  Value:${CONFIGURATION}}
![](http://img.blog.csdn.net/20140807181637038?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQveWFkb25naGFvcmVu/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center)

step3:创建配置文件newfile--> iOS Resource --> Property List   并named Environment.plist![](http://img.blog.csdn.net/20140807181942875?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQveWFkb25naGFvcmVu/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center)


step4:创建单利从plist中读取数据
![](http://img.blog.csdn.net/20140807182558452?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQveWFkb25naGFvcmVu/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center)

此时编译一下如果不通过，提示pod library 找不到的解决方法：
Targets－－》buildsetting －－》 搜索searchPaths －－》 将Framework、Library、userHeader 对应的searchPath中都添加$(BUILD_DIR)/Release$(EFFECTIVE_PLATFORM_NAME)。

技巧：
可以通过编辑scheme来设置自己的环境变量，具体操作如下：
edit Scheme －－> Run ***.app -- > Arguments  ---> Environment Variables -->添加相应的name & value。
如何取得自定义得环境变量值：

   NSString * element = [[[NSProcessInfo processInfo] environment] objectForKey:@"TestEnvironment"];
    NSLog(@"element = %@",element);



