title: iOS生成服务器所需证书pem或P12
categories: 技术
tags: iOS , Object-C
description:

---

本文主要记录制作服务器（例如php）利用pem推送服务

<!--more-->

基本流程：

1.利用“钥匙串”请求证书

2.创建证书，下载cer文件

3.双击安装下载的cer文件后，导出p12证书

4.利用命令行转换pem文件

5.如果需要转换为p12

6.验证证书是否可用

具体步骤：

1.利用钥匙串请求证书

![image](/img/request_csr.png)

Apple建议这样填写

![image](/img/9962780C-E852-497E-87C1-013CA3FCB461.png)

保存，得到"CertificateSigningRequest.certSigningRequest"文件。这是请求所有证书的基础。


2.创建证书，下载cer文件

进入苹果开发者中心:https://developer.apple.com/cn/ Certificates, IDs & Profiles

![image](/img/B996E06D-EB2B-45F8-9DCA-37740CF79AED.png)

![image](/img/3094613-6b5c3eae15e96f21.png)

创建 “iOS Development” 和 “iOS Distribution” 以及“Identifiers->App IDs”证书后，才可以创建推送证书。

创建方法类似，此处省略800字。

把做的证书下载下来。

![image](/img/66851C9E-F106-4524-A11F-A193EF4A0833.png)

分别得到发布开发cer和发布cer

"aps_development.cer" 和 "aps.cer"


3.双击安装下载的cer文件后，导出p12证书

![image](/img/12EFBBB0-FC0A-4D6E-8F9D-1D1BD7F2F9C2.png)

分别导出开发证书和发布证书

"Apple Development IOS Push Services- com.in.inlan.p12" 和 "Apple Push Services- com.in.inlan.p12"


4.利用命令行转换pem文件

1). 先把下载下的cer转换为pem

```
$ openssl x509 -inform der -in aps_development.cer -out devPushChatCert.pem

$ openssl x509 -inform der -in aps.cer -out PushChatCert.pem               
```

2). 将钥匙串中的p12转换成pem

```
$  openssl pkcs12 -nocerts -out devPushChatKey.pem -in Apple\ Development\ IOS\ Push\ Services-\ com.in.inlan.p12

$ openssl pkcs12 -nocerts -out PushChatKey.pem -in Apple\ Push\ Services-\ com.in.inlan.p12  
```

3). 将上面生成的2中pem转为一个pem

```
$ cat devPushChatCert.pem devPushChatKey.pem > dev_ck.pem

$ cat PushChatCert.pem PushChatKey.pem > ck.pem

```

5.如果需要转换为p12

```
$ openssl pkcs12 -export -in dev_ck.pem -out dev_pushcer.p12

$ openssl pkcs12 -export -in ck.pem -out pushcer.p12

```

6.验证证书是否可用

整理有个写好的脚本可用（内部替换所需deviceToken即可）

[push demo](/file/push.zip)

```php
$ php ios-push.php 

```
