title: Mac 利用 Apache 下的 HTTPS 服务 在线应用 安装 服务
date: 2017-02-15 11:50:00
categories: 技术
tags: [Mac, Apache, HTTPS, 在线安装, 应用]
description:
---
1.创建ssl文件夹


```objc
sudo mkdir /private/etc/apache2/ssl 
```


2.切换到ssl文件夹


```objc
cd /private/etc/apache2/ssl
```


3.生成ssh等文件相关证书（server.key  +  server.key.pub）




```objc
sudo ssh-keygen -f server.key
```


4.生成.csr 文件


```objc
sudo openssl req -new -key server.key -out request.csr
```


注意：Common Name 推荐填写自己的ip，
![](http://img.blog.csdn.net/20170215113732595?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvbGlob25nbGk1Mjg2Mjg=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center)



5. 生成.crt文件


```objc
 sudo openssl x509 -req -days 365 -in request.csr -signkey server.key -out server.crt
```



结果如下:
![](http://img.blog.csdn.net/20170215112357497?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvbGlob25nbGk1Mjg2Mjg=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center)



6.配置SSL服务

1.)编辑 httpd.conf 文件


```objc
sudo vim /private/etc/apache2/httpd.conf
```

把以下三行代码前头的注释去掉



```objc
LoadModule ssl_module libexec/apache2/mod_ssl.so
Include /private/etc/apache2/extra/httpd-ssl.conf
Include /private/etc/apache2/extra/httpd-vhosts.conf
```

2.)编辑 httpd-ssl.conf 文件




```objc
sudo vim /private/etc/apache2/extra/httpd-ssl.conf
```


把以下两行代码的注释去掉



```objc
SSLCertificateFile "/private/etc/apache2/server.crt"
SSLCertificateKeyFile "/private/etc/apache2/server.key"
```

3.)httpd-vhosts.conf 文件





```objc
sudo vim /private/etc/apache2/extra/httpd-vhosts.conf
```



在末尾添加如下代码。  内容改成自己的内容。 ServerName 改成自己iP


```objc
<VirtualHost *:443>
  SSLEngine on
  SSLCertificateFile /private/etc/apache2/ssl/server.crt
  SSLCertificateKeyFile /private/etc/apache2/ssl/server.key
  ServerName 10.2.15.163
  DocumentRoot "/Users/lhl/Sites/"
</VirtualHost>
```

7.测试配置及重启Apache


```objc
sudo apachectl -t   //如果它提示：Syntax OK 
sudo apachectl restart
```

浏览器输入 https://10.2.9.163 即可访问成功。
注意如果提示不安全访问，请双击安装 server.crt 文件
8.配置在线安装app环境
1.)配置plist文件
![](http://img.blog.csdn.net/20170215114305004?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvbGlob25nbGk1Mjg2Mjg=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center)

code 如下  news.plist

```objc
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
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
					<string>https://10.2.15.163/ipa/news.ipa</string>
				</dict>
			</array>
			<key>metadata</key>
			<dict>
				<key>bundle-identifier</key>
				<string>com.sohu.news</string>
				<key>kind</key>
				<string>software</string>
				<key>title</key>
				<string>sohunews</string>
			</dict>
		</dict>
	</array>
</dict>
</plist>
```



2.配置html文件


```objc
<html>
<head>
<meta charset="utf-8" mime-types="text/plain">
<title> 测试安装包 </title>
</head>

<body>
<h1>第一次连接请先安装证书,以后就不需要安装了</h1>

<h2>
证书:<a href="https://10.2.15.163/ipa/server.crt">profile</a>
</h2>

<h2>HTTPS:<a href="itms-services://?action=download-manifest&url=https://10.2.15.163/ipa/news.plist">
news-02/13-15:35
</a>
</h2>

</body>

</html>
```


效果：
![](http://img.blog.csdn.net/20170215115806323?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvbGlob25nbGk1Mjg2Mjg=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center)
最终文件夹文件为：
![](http://img.blog.csdn.net/20170215114820303?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvbGlob25nbGk1Mjg2Mjg=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center)



访问 https://10.2.15.163/ipa.html 即可访问安装应用测试包。


其他：手机也需要先安装crt证书文件才可以下载测试包。


