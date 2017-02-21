title: 通过 itms:services://? 在线安装ipa ，跨过app-store
date: 2014-04-28 16:30:00
categories: 技术
tags: 
description:
---
##

##

##

##

【转】


1.需要一个html文件,引导下载用户在线安装ipa



<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>一键安装掌上综调iPhone版</title>
  </head>
  
  <body>
        <a href='itms-services://?action=download-manifest&url=http://222.177.4.242/ios/d.plist'>一键安装掌上综调iPhone版</a>
  </body>
</html>





2. 上文中的d.plist文件内容如下，其实它是一个XML文件，有关plist文件，请自行查阅google


<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
   <key>items</key>
   <array>
       <dict>
           <key>assets</key>
           <array>
               <dict>
                   <key>kind</key>
                   <string>software-package</string>
                   <key>url</key>
                   <string>http://222.177.4.242/download?attachId=022DB5EAF88A57B175D24060DCD1BA70</string>
               </dict>
               <dict>
                   <key>kind</key>
                   <string>display-image</string>
                   <key>needs-shine</key>
                   <true/>
                   <key>url</key>
                   <string>http://222.177.4.242/ios/icon.png</string>
               </dict>
               <dict>
                   <key>kind</key>
                   <string>full-size-image</string>
                   <key>needs-shine</key>
                   <true/>
                   <key>url</key>
                   <string>http://222.177.4.242/ios/icon.png</string>
               </dict>
           </array><key>metadata</key>
           <dict>
               <key>bundle-identifier</key>
               <string>com.ccssoft.mopclient.chongqing</string>
               <key>bundle-version</key>
               <string>1.0.0</string>
               <key>kind</key>
               <string>software</string>
               <key>subtitle</key>
               <string>掌上综调</string>
               <key>title</key>
               <string>掌上综调</string>
           </dict>
       </dict>
   </array>
</dict>
</plist>



上面2中的http://222.177.4.242/download?attachId=022DB5EAF88A57B175D24060DCD1BA70 这是ipa包所在的网络地址


3.自行找一个icon.png放在上面两个文件的同一个目录，此图片用作在iphone上显示程序图标。 http://222.177.4.242/ios/icon.png


4.使用iphone safari浏览器，浏览http://222.177.4.242/ios/d.html文件，即可安装了。简单吧。




承上：



#IOS7.1 企业应用 证书无效 已解决   
关于IOS7.1企业版发布后，用户通过sarafi浏览器安装无效的解决方案：


通过测试，已经完美解决。


方案一:
http://blog.csdn.net/zhaoxy_thu/article/details/21133399


方案二:最简单，实用。


使用dropBox


如何安装，自己度之。
当你使用XCODE发布安装包IPA和PLIST文件后，将IPA仍然保存在你常用保存的网站上，只要可以正常连接下载即可。
PLIST文件是供手机版SAFARI解析的文件，里面包含有IPA的下载地址。所以我们的重点就是将PLIST文件保存在支持HTTPS的网站上。并且供用户访问。


将你生成的PLIST文件上传到dropBox后，你就能在文件列表中看到你已经上传的文件。然后在此文件上右键选择共享，此时会要求你输入共享人的邮箱，不管它。直接在弹出的对话框中选择右下角的复制，这个时候，你已经拿到了我们需要用的HTTPS连接。比如为:


itms-services://?action=download-manifest&url=https://www.dropbox.com/s/veimpxpa2fm0cqo/×××.plist


，这个连接还不能在手机版的SARAFI上使用，我们需要二次加工。


将连接中标为红色的www.dropbox.com替换成dl.dropboxusercontent.com即为:



itms-services://?action=download-manifest&url=https://dl.dropboxusercontent.com/s/veimpxpa2fm0cqo/×××.plist


ok,我们终于拿到了我们需要的HTTPS连接。
因为考虑到IOS7.1之前的系统仍然是HTTP访问，故我们需要做以一下处理


#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_7_0
                trackUrl =itms-services://?action=download-manifest&url=https://dl.dropboxusercontent.com/s/veimpxpa2fm0cqo/×××.plist;
#else
  trackUrl =你以前的的PLIST文件的地址;

#endif



而至于dropBox的使用，请自己查看相关文档。





