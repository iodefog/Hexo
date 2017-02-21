title: iMessage 通讯录发送
date: 2014-12-11 11:12:00
categories: 技术
tags: 
description:
---
怎样实现iMessage群发
Apple公司全线在mac os与ios两个操作系统上内置了FaceTime与iMessage两个应用。完美替代运营商的短信与电话。并且FaceTime与iMessage的帐号不仅仅与Apple ID 绑定，同时也与使用这Apple ID的手机号码绑定，这样的漏洞自然给无孔不入的中国的群发垃圾信息商们提供了后门。
这样iPhone的iMessage时不时就能收到以邮件为发送者的垃圾iMessage，尤其是嘀嗒打车群发的最多，听说是厦门一家公司操刀的。针对iMessage的群发实现，新闻稿上说是花几分钟写个脚本就可以了。可惜我花时间研究了好几次，也没有实现大批量群发的实现，倒是把自己的Apple ID搞的电脑与手机不同步了。
我研究怎么实现iMessage群发先是从XMPP协议开始的，因为Apple MAC os上的ichat是XMPP客户端，可以连接iMessage服务器，同时也可连接gtalk与weibo私信。但后面发现iMessage的服务器验证是加密，没办法实现非ichat XMPP客户端连接iMeesage服务器，那就自然没办法实现程序控制往iMeesage服务器批量发送信息。
只能通过MAC OS或者iOS自带的程序往iMeesage服务器发送信息，那要实现群发，自然只能想办法去调用自带的这ichat客户端，在MAC OS系统上Apple公司提供一种叫Apple script的脚本来自动实现任务。可能通过`tell
 application "Messages"`就可以激活iMessage客户端自动发送信息。这样实现的群发的思路就很清楚了
1.通过AppleScript实现[批量注册itune帐号](https://github.com/aaronfreimark/Apple-ID-AppleScript)
2.通过AppleScript实现自动取一个itune帐号群发100个APPle ID的iMessage

	set EMAIL to "EMAIL_DEL_DESTINATARI" -- el destinatari ha de tenir l'iMessage activat
	set MSG to "COS_DEL_MISSATGE"
	set N to the 1000 -- nombre de vegades que s'enviarà el missatge
	set APPLE_ID to "E:" -- la teva Apple ID que ha de tenir iMessage activat
	repeat N times
	    tell application "Messages"
	        send MSG to buddy EMAIL of service APPLE_ID
	    end tell
	end repeat
	

看来新闻稿没有说错，实现iMessage群发确实只要几分钟写脚本。但懂用使用iMessage的用户显然不是买iPhone装逼用的用户，你群发的iMessage除骚扰又能带来什么样的效果哟。
后面在网上搜索到一个更详细的博客说明，[转载如下](http://blog.csdn.net/zhaoxy2850/article/details/9255165)：
iMessage介绍
iMessage是苹果设备（iPad、iPhone、iPod touch）自带的免费信息发送应用。它的信息通过网络发送，不同于运营商短信。目前iMessage日活跃用户1.9亿，日发送约20亿条。
iMessage优势
iMessage与传统短信不同，具有以下优势：
- 目标人群明确，均为苹果用户，消费能力较强
- 文字数量不限，同时还可以添加表情和图片
- 可以添加网址、下载链接等，用户可以直接通过手机访问
- 不会被手机安全卫士拦截
- 转发就像手机短信一样方便
- 无发送成本
- 送达终端的概率极高

iMessage推送技术实现
群发iMessage主要需要攻破两个技术难点，一个是iMessage账号的获取，另一个是群发iMessage。
iMessage账号获取
iMessage账号目前获取的方法主要是扫描手机号码。扫描手机号码可以通过代码自动扫描，也可以通过人工筛选。通过代码自动扫描本人暂未发现很好的方法，建议大家可以从以下两方面着手：
- 1.编写AppleScript脚本控制Mac OS自带的iMessage客户端进行验证，类似于群发iMessage。发送一条iMessage之后，如果捕获到发送失败的异常则不是iMessage账号
- 2.研究iOS系统中Message framework中的私有api，通过私有api进行验证

要进行人工筛选，也可以通过Mac OS自带的iMessage客户端。方法是编写程序，将要验证的号码输出到文件中，以逗号分隔。再将文件中的号码粘贴到iMessage客户端的地址栏，iMessage客户端会自动逐个检验该号码是否为iMessage账号，检验速度视网速而定。其中红色表示不是iMessage账号，蓝色表示iMessage账号以及未检验的账号。如图：
![image](http://note.youdao.com/yws/res/5122/555A9B4686F843D8A1E7332A44CA06DC)
检验过程中有可能会出现停止的现象，可以全选所有号码后，剪切再粘贴即可继续检验。
iMessage群发
检验完所有账号后，可以从中选取出iMessage账号进行群发。群发有两个方法，一个还是通过iMessage客户端，另一个是通过AppleScript脚本控制iMessage客户端发送。
- 通过iMessage客户端发送，可直接将号码粘贴至地址栏，填写内容，发送即可。
- 通过ApplseScript控制iMessage客户端的脚本如下：
	tell application "Messages"
	set csvData to read "/Users/xxxx/Desktop/test.csv"  
	set csvEntries to paragraphs of csvData
	repeat with i from 1 to count csvEntries
	set phone to (csvEntries's item i)'s text
	set myid to get id of first service
	set theBuddy to buddy phone of service id myid
	send "今天北京晴，气温13到27度；周二晴，气温11到26度，北风3-4级；周三晴，气温11到24度，微风<3" to theBuddy
	end repeat
	end tell

以上代码可从一个csv文件中读取出iMessage账号，并通过iMessage客户端逐个发送iMessage消息。

需要注意如下问题：
- 1.由于该脚本是控制iMessage客户端进行发送，所以必须在MacOS 10.8以上（10.7系统中的iMessage Beta版本已无法使用）的系统中运行，同时开启iMessage程序。
- 2.该脚本在发送iMessage时并不是后台发送，所以当发送量很大时，会导致iMessage客户端运行缓慢，甚至无法开启。可通过清空所有已发送的iMessage或注销账号解决。
- 3.通过脚本发送的iMessage账号必须是在当前iMessage客户端中检验过的，否则会报“不能获得“buddy id "C0B35E7F-A0FB-49E1-BDD7-C867BC06D920:+86136xxxx0000"”。

从上面转载的博文上可以看出来，这哥们主要是做了简单少数号码的尝试，没有真正大量群发过，但他在最后也提出了真正群发会遇到问题，三个问题解决方案如下：
- 第一个问题用mac os系统或者黑苹果装10.8操作系统，会自带messages程序，这程序系统自带，千万不会发现打不开去删除Messages程序，删除就只能重装系统了。并且是先打开Messages程序，再启动apple script脚本，不然运行不正常。
- 第二个问题，在发送过程中加入同步删除的代码,但同步一条一条删除时有时会失败，所以再增加发一定量后再批量删除一次的操作，正常的流程应该是打开Messages程序->循环号码库->读取一个号码->发送一条信息->等待1秒->删除此条信息->判断是否未删除的超过100条，是批量删除->循环号码库。这样就可以保证Messages程序不会去占百分一百多的CPU或者几个G的内存。
	tell application "Messages"
	set csvData to read "/Users/xxxx/Desktop/test.csv"  
	set csvEntries to paragraphs of csvData
	repeat with i from 1 to count csvEntries
	set phone to (csvEntries's item i)'s text
	set myid to get id of first service
	set theBuddy to buddy phone of service id myid
	send "今天北京晴，气温13到27度；周二晴，气温11到26度，北风3-4级；周三晴，气温11到24度，微风<3" to theBuddy
	delay 1 -延时一秒，不然取不到已发达的内容
	set FailNum to (get count chat)
	if FailNum>100 then
	repeat with j from 1 to FailNum
	set phone to (get name of chat (FailNum-j))
	set DelMsg to "iMessage;-;" & phone 
	if exists (text chat id DelMsg) then
	delete text chat id DelMsg
	end if
	end repeat
	end if
	end repeat
	end tell

- 第三个问题，在messages程序的imessage帐号中设置用来群发的imessage帐号。就没有问题了。

