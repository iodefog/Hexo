title: iOS证书及ipa包重签名
date: 2016-08-24 14:38:00
categories: 技术
tags: 

---

### 闲来无事，玩了玩重签名，成功搞定重签名


准备工作：

**1.准备你需要重新签名的ipa。**


**2.制作entitlements.plist **

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


这里关键点在于id的正确，这点搞了好久，总是和网上找的不一样。我这里用了“[iPhone](https://pan.baidu.com/s/1o7OLrRG)[配置实用工具](https://pan.baidu.com/s/1o7OLrRG)”这个工具来查看证书的，找到你的证书

![](../img/20160824143715637.jpg)


**3.选中你的证书，点击左上角导出按钮，导出成embedded.mobileprovision**


**4.解压ipa**

```
  upzip xxx.ipa  
```

**5.移除老的证书 **

```
 rm -rf  Payload/xxx.app/_CodeSignature 
 rm -rf  Payload/xxx.app/embedded.mobileprovision
```

**6.替换证书**

```
cp  embedded.mobileprovision  Payload/xxx.app/embedded.mobileprovision**
```

**7.进入到钥匙串，找到对应的证书名称。进行重签名**

```
certifierName="iPhone Distribution: Shenzhen Test Technology Co., Ltd."  

codesign -f -s $certifierName  --entitlements entitlements.plist Payload/xxx.app  

```



**8.进入到Payload/xxx/Info.plist,修改Bundle identifier 注：我这个地方修改就好使了，不知道是不是必须修改**


**9.打包成ipa**

```
  zip -r newxxx.ipa Payload    
```

---

### 以上流程，我写了一个脚本，如下：

**resign.sh**

```

IPAName=$1

rm -rf new_${IPAName}.ipa
rm -rf Payload

unzip ${IPAName}.ipa

rm -rf Payload/${IPAName}.app/_CodeSignature 
rm -rf Payload/${IPAName}.app/Embedded.mobileprovision

cp Embedded.mobileprovision Payload/${IPAName}.app/embedded.mobileprovision

echo $CertifierName

codesign -f -s "iPhone Distribution: BEIJING SOHU NEW MEDIA INFORMATION TECHNOLOGY CO. Ltd."  --entitlements entitlements.plist Payload/${IPAName}.app

codesign -f -s "iPhone Distribution: BEIJING SOHU NEW MEDIA INFORMATION TECHNOLOGY CO. Ltd."  --entitlements entitlements.plist Payload/${IPAName}.app/Frameworks/*

zip -r new_${IPAName}.ipa Payload
```

使用方法：

* 1.把Embedded.mobileprovision， entitlements.plist， resign.sh， xxx.ipa 放到同一个文件夹下
* 2.利用终端，cd到文件夹下，执行以下命令。

``` 
sh resign.sh VipVideo-iPhone
```

*注意:VipVideo-iPhone 一定是scheme名称。查找方式，保存ipa成.zip格式，解压，得到Palaod->VipVideo-iPhone。这个VipVideo-iPhone才是真正的scheme。*
