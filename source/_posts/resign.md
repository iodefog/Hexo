
title : 闲来无事，玩了玩重签名，成功搞定重签名

---

准备工作：

### 1. 准备你需要重新签名的ipa
### 2. 制作entitlements.plist 
这里关键点在于id的正确，这点搞了好久，总是和网上找的不一样。我这里用了“iPhone配置实用工具副本”这个工具来查看证书的，找到你的证书
<!-- more -->

code 如下：
[objc] view plain copy 在CODE上查看代码片派生到我的代码片

```
<?xml version="1.0" encoding="UTF-8"?>    
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">    
<plist version="1.0">    
<dict>    
<key>keychain-access-groups</key>  
<array>  
<string>828E9CDH56.*</string>  
</array>  
<key>get-task-allow</key>  
<false/>  
<key>application-identifier</key>  
<string>828E9CDH56.com.test.enterprise</string>  
<key>com.apple.developer.team-identifier</key>  
<string>828E9CDH56</string>  
<key>aps-environment</key>  
<string>production</string>  
</dict>    
</plist>    
```

### 3. 选中你的证书，点击左上角导出按钮，导出成embedded.mobileprovision
![image](/img/20160824143715637.jpg)

### 4. 解压ipa
```
upzip youripa.ipa  
```

### 5.  移除老的证书 
[python] view plain copy 在CODE上查看代码片派生到我的代码片
```
rm -rf  Payload/your.app/_CodeSignature   
rm -rf  Payload/test.app/embedded.mobileprovision  
```

### 6. copy  第3步导出的embedded.mobileprovision  Payload/your.app/embedded.mobileprovision

### 7.进入到Payload/NewT66y/Info.plist,修改Bundle identifier (非必须)

### 8. 进入到钥匙串，找到对应的证书名称。进行重签名。如果里面有动态库，则需要再对动态库进行签名
```
//重签名应用
certifierName="iPhone Distribution: xxx"  
codesign -f -s $certifierName  --entitlements entitlements.plist Payload/your.app  

//重签名应用中的embeded framework（如果存在的话就需要运行）
/usr/bin/codesign -f -s "iPhone Distribution: xxx" --entitlements entitlements.plist Payload/12121212.app/Frameworks/* 

```

### 8.1. 进入到钥匙串，找到对应的证书名称。进行重签名

```
对framrworks中的文件签名，再利用codesign 命令查看，
codesign -vv -d /Users/Rufus/Desktop/test/Payload/12121212.app/Frameworks/libswiftDarwin.dylib 
````

### 9.打包成ipa
```
zip -r NewApp.ipa Payload    
```
