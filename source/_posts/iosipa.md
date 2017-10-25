title: iOS证书及ipa包重签名
date: 2016-08-24 14:38:00
categories: 技术
tags: 
description:
---
闲来无事，玩了玩重签名，成功搞定重签名


准备工作：
1.准备你需要重新签名的ipa。


2.制作entitlements.plist 

code 如下： 注意 VB2VQ6GKB2.com.test.enterprise 这个是使用下图箭头所指标识  VB2VQ6GKB2 相应变换。这个应该都会吧

<!--more-->


```html
<?xml version="1.0" encoding="UTF-8"?>  
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">  
<plist version="1.0">  
<dict>  
    <key>keychain-access-groups</key>
    <array>
        <string>VB2VQ6GKB2.*</string>
    </array>
    <key>get-task-allow</key>
    <false/>
    <key>application-identifier</key>
    <string>VB2VQ6GKB2.com.test.enterprise</string>
    <key>com.apple.developer.team-identifier</key>
    <string>VB2VQ6GKB2</string>
    <key>aps-environment</key>
    <string>production</string>
</dict>  
</plist> 
```


这里关键点在于id的正确，这点搞了好久，总是和网上找的不一样。我这里用了“[iPhone](https://pan.baidu.com/s/1o7OLrRG)[配置实用工具副本](https://pan.baidu.com/s/1o7OLrRG)”这个工具来查看证书的，找到你的证书
![](http://img.blog.csdn.net/20160824143715637?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQv/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center)


3.选中你的证书，点击左上角导出按钮，导出成embedded.mobileprovision


4. 解压ipa
  upzip xxx.ipa  


5.  移除老的证书 
 rm -rf  Payload/xxx.app/_CodeSignature 
 rm -rf  Payload/xxx.app/embedded.mobileprovision


6.  copy  embedded.mobileprovision  Payload/xxx.app/embedded.mobileprovision


7.进入到钥匙串，找到对应的证书名称。进行重签名
certifierName="iPhone Distribution: Shenzhen Test Technology Co., Ltd."  
codesign -f -s $certifierName  --entitlements entitlements.plist Payload/xxx.app  
![](http://img.blog.csdn.net/20170208161443140?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvbGlob25nbGk1Mjg2Mjg=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center)



8.进入到Payload/xxx/Info.plist,修改Bundle identifier 注：我这个地方修改就好使了，不知道是不是必须修改


9.打包成ipa
  zip -r newxxx.ipa Payload    



