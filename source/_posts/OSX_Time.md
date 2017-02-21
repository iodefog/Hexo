title: OSX系统添加定时任务
date: 2016-11-28 14:34:00
categories: 技术
tags: 
description:
---
#转载：[http://honglu.me/2014/09/20/OSX%E7%B3%BB%E7%BB%9F%E6%B7%BB%E5%8A%A0%E5%AE%9A%E6%97%B6%E4%BB%BB%E5%8A%A1/](http://honglu.me/2014/09/20/OSX%E7%B3%BB%E7%BB%9F%E6%B7%BB%E5%8A%A0%E5%AE%9A%E6%97%B6%E4%BB%BB%E5%8A%A1/)

#OS X是苹果Mac的操作系统。今天遇到了一个想向系统里添加定时任务的问题。比如我想在12点运行一个脚本，而这个时间我又要出去吃饭。这个时候就可以通过增加定时任务的办法来解决。
这里主要提供两种方式：
[]()##[](http://honglu.me/2014/09/20/OSX%E7%B3%BB%E7%BB%9F%E6%B7%BB%E5%8A%A0%E5%AE%9A%E6%97%B6%E4%BB%BB%E5%8A%A1/#crontab命令 "crontab命令")crontab命令
crontab是Linux下的定时任务命令，OS X显然也是支持这个命令的。下面说一下如何使用:
crontab [-u username] [-l|-e|-r]
相关参数：
-u ：只有 root 才能进行这个任务，也就是帮其他使用者建立/移除 crontab 工作排程；
-e ：编辑 crontab 的工作內容
-l ：查看 crontab 的工作內容
-r ：移除所有的 crontab 的工作內容，若仅仅移除一项，请用 -e 去编辑。
crontab file [-u user]：用指定的文件替代目前的crontab。
例一：用 dmtsai 的身份在每天的 12:00 发信给自己
	$ sudo crontab -e
	# 此时会进入 vi 编辑器！注意到，每项工作都是一行。
	# 基本格式：* * * * * command 
	0 12 * * * mail dmtsai -s"at 12:00" < /home/dmtsai/.bashrc
	#分 时 日 月 周 |<==============指令串========================>|
	$ sudo crontab -l
	# 查看已经添加的定时任务
	
前面五个参数(星号)代表的意义：
代表意义分钟小时日期月份周数字范围0-590-231-311-120-7例二：12：00执行这个Python脚本
	$ sudo crontab -e
	0 12 * * * /usr/bin/python /Users/aigo/Documents/demo.py
	
###[](http://honglu.me/2014/09/20/OSX%E7%B3%BB%E7%BB%9F%E6%B7%BB%E5%8A%A0%E5%AE%9A%E6%97%B6%E4%BB%BB%E5%8A%A1/#使用问题： "使用问题：")使用问题：
1. 如果使用crontab -e编辑无法保存，说明你还没有相关文件，你可以新建一个txt文件，文件内协商你要执行的任务。然后通过`sudo
 crontab file`这个命令来新建相关文件，然后你就可以通过`crontab
 -e`来修改定时任务了
2. 通过上面的命令介绍可见crontab的最小时间间隔是一分钟

###[](http://honglu.me/2014/09/20/OSX%E7%B3%BB%E7%BB%9F%E6%B7%BB%E5%8A%A0%E5%AE%9A%E6%97%B6%E4%BB%BB%E5%8A%A1/#参考 "参考")参考
[鸟哥的Linux私房菜
 - 例行性工作排程 (crontab)](http://linux.vbird.org/linux_basic/0430cron.php#cron)
[Linux
 crontab定时执行任务 命令格式与详细例子](http://www.jb51.net/LINUXjishu/19905.html)
[Mac
 os下定时启动一个脚本](http://blog.sina.com.cn/s/blog_60b45f2301011hqp.html)
##[](http://honglu.me/2014/09/20/OSX%E7%B3%BB%E7%BB%9F%E6%B7%BB%E5%8A%A0%E5%AE%9A%E6%97%B6%E4%BB%BB%E5%8A%A1/#launchctl-定时任务-推荐 "launchctl 定时任务(推荐)")launchctl
 定时任务(推荐)
这个是通过plist配置的方式来实现定时任务的，其优点就是最小时间间隔是一秒
plist脚本存放路径为/Library/LaunchDaemons或/Library/LaunchAgents，其区别是后一个路径的脚本当用户登陆系统后才会被执行，前一个只要系统启动了，哪怕用户不登陆系统也会被执行。
可以通过两种方式来设置脚本的执行时间。一个是使用StartInterval，它指定脚本每间隔多长时间（单位：秒）执行一次；另外一个使用StartCalendarInterval，它可以指定脚本在多少分钟、小时、天、星期几、月时间上执行，类似如crontab的中的设置。
例:
新建一个shell文件`/Users/aigo/Documents/AutoMakeLog.sh`
	#!/bin/sh
	/usr/bin/python /Users/aigo/Documents/AutoMakeLog.py
	
脚本要改成可执行的权限
	chmod 777 AutoMakeLog.sh
	
进入到`~/Library/LaunchAgents`下建一个plist文件`com.aigo.launchctl.plist`
	<?xml version="1.0" encoding="UTF-8"?>
	<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
	<plistversion="1.0">
	<dict>
	<key>Label</key>
	<string>com.aigo.launchctl.plist</string>
	<key>ProgramArguments</key>
	<array>
	<string>/Users/aigo/Documents/AutoMakeLog.sh</string>
	</array>
	<key>StartCalendarInterval</key>
	<dict>
	<key>Minute</key>
	<integer>4</integer>
	<key>Hour</key>
	<integer>13</integer>
	</dict>
	<key>StandardOutPath</key>
	<string>/Users/aigo/Documents/AutoMakeLog.log</string>
	<key>StandardErrorPath</key>
	<string>/Users/aigo/Documents/AutoMakeLog.err</string>
	</dict>
	</plist>
	
> label这里就是给这个任务名个名字，这里一般取plist的文件名，这个名字不能和其它的plist重复。AutoMakeLog.sh就是我们要执行的脚本，StartCalendarInterval里边的参数是说每一天13点4分的时候执行一下脚本。
然后就可以用下面的几个命令进行操作我们做好的任务了。
	launchctl load   com.aigo.launchctl.plist
	launchctl unload com.aigo.launchctl.plist
	launchctl start  com.aigo.launchctl.plist
	launchctl stop   com.aigo.launchctl.plist
	launchctl list
	
- 要让任务生效，必须先load命令加载这个plist
- 如果任务呗修改了，那么必须先unload，然后重新load
- start可以测试任务，这个是立即执行，不管时间到了没有
- 执行start和unload前，任务必须先load过，否则报错
- stop可以停止任务
- ProgramArguments内不能直接写命令，只能通过shell脚本来执行

上面的任务我们也可以指定为每隔30秒执行一次，如下
	<?xml version="1.0" encoding="UTF-8"?>
	<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
	<plistversion="1.0">
	<dict>
	<key>Label</key>
	<string>com.aigo.launchctl.plist</string>
	<key>ProgramArguments</key>
	<array>
	<string>/Users/aigo/Documents/AutoMakeLog.sh</string>
	</array>
	<key>KeepAlive</key>
	<false/>
	<key>RunAtLoad</key>
	<true/>
	<key>StartInterval</key>
	<integer>30</integer>
	</dict>
	</plist>
	
###[](http://honglu.me/2014/09/20/OSX%E7%B3%BB%E7%BB%9F%E6%B7%BB%E5%8A%A0%E5%AE%9A%E6%97%B6%E4%BB%BB%E5%8A%A1/#参考-1 "参考")参考
[launchd.plist官方说明](https://developer.apple.com/library/mac/documentation/Darwin/Reference/ManPages/man5/launchd.plist.5.html)
[Mac
 使用 launchctl 定时运行程序](http://my.oschina.net/jackin/blog/263024)
[管理OSX后台服务](http://blog.ixtr.me/2012/05/osx%E5%90%8E%E5%8F%B0%E6%9C%8D%E5%8A%A1%E7%AE%A1%E7%90%86/)
[mac
 os 定期任务配置](http://www.netingcn.com/mac-os-plist.html)
