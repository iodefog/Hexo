title: 开源一个统计iPhone上App运行时间和打开次数的小工具
date: 2014-05-14 14:41:00
categories: 技术
tags: 
description:
---
##[时间都去哪儿了？开源一个统计iPhone上App运行时间和打开次数的小工具](http://www.cnblogs.com/gugupluto/p/3561863.html)
         如今，大家每天都有大量时间花在手机上，但是，大家有没有想过自己的时间都花在哪些App上了呢？相信很多人都有这样的需求，不过iOS系统本身并不能显示每个App的运行时间和次数，因此，本人写了这样一个小工具，可以在后台进行监控当前使用的App，对App的打开次数和运行时间进行统计，可以显示今日、本周、或全部统计结果，并能按打开次数、运行时长排序。
       程序使用的是私有API，因此请勿将本文中提到的方法用于需要发布到AppStore的应用。**不过在真机上运行代码，并不需要越狱，只需要有开发者证书即可，因此有证书的朋友可以部署代码到设备上娱乐下。**
       程序原理很简单，首先是播放无声音乐，使程序能保持后台运行，其次启动一个计时器，持续获取当前前台运行的App名称，当前台运行的App发生改变时，即写一条记录到数据库，然后监控设备的锁屏消息，当设备锁屏时，暂停计时器，当设备打开锁屏时，继续计时器。如果设备重启，需要重新打开一次程序，统计才能继续进行。
      运行效果如下：
     ![](http://images.cnitblog.com/blog/542760/201402/231342198252412.png)        ![](http://images.cnitblog.com/blog/542760/201402/231342330751193.png) 
      程序的要点如下：
（1）播放无声音乐
       使用开源代码MMPDeepSleepPreventer
 
（2）获取前台运行App bundleId及App名称
       获取前台运行的App Bundle Id：SBFrontmostApplicationDisplayIdentifier
       获取App 名称 ：SBSCopyLocalizedApplicationNameForDisplayIdentifier
       获取App图标：SBSCopyIconImagePNGDataForDisplayIdentifier
       具体使用方法参见[《iphone SprintBoard部分私有API总结》](http://www.gugupluto.com/?p=56) 及 代码。
（3）监控设备锁屏消息
       使用CFNotificationCenterAddObserver对"com.apple.springboard.lockcomplete"和"com.apple.springboard.lockstate"进行监控。根据得到的状态，可以知道设备是锁屏还是打开非锁屏。
   代码下载：[https://github.com/gugupluto/iOSAppTime ](https://github.com/gugupluto/iOSAppTime)      
ios系统升级，这里的一些私有参数已无效