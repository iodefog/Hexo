title: 命令行发送邮件并修改发送人,避免自动邮件归置到垃圾邮件
date: 2016-03-16 17:47:00
categories: 技术
tags: 
description:
---
1.安装home-brew


```objc
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

```
如果安装提示error：
curl: (35) Server aborted the SSL handshake
<!--more-->

解决方案：

1.不过安装前，因为OS X El Capitan引入了系统完整性保护机制，使用Homebrew的同学请在升级后执行


```objc
sudo chown $(whoami):admin /usr/local && sudo chown -R $(whoami):admin /usr/local
```


2.在命令中添加 --insecure


```objc
/usr/bin/ruby -e "$(curl -fsSL --insecure  https://raw.githubusercontent.com/Homebrew/install/master/install)"  
```
卸载命令

```objc
sudo ruby -e "$(curl -fsSL --insecure https://raw.githubusercontent.com/Homebrew/install/master/uninstall)"
```



2.安装msmtp


```objc
brew install msmtp 

```



3.配置**vi ~/.mailrc  **
**粘贴 **

```objc
set sendmail=/usr/local/bin/msmtp
```


**
**
****
**vi ~/.msmtprc**
**注意把邮件密码设置为你的邮箱密码**
****


```objc
defaults
logfile ~/.msmtp.log

account honglili@sohu-inc.com
host mail.sohu-inc.com
port 25
auth login
from honglili@sohu-inc.com
user honglili@sohu-inc.com
password *******

# this next line is crucial: you have to point to the correct security certificate for GMail.
# If this doesn't work, check the mstmp documentation
# at http://msmtp.sourceforge.net/documentation.html for help
#
# This next line should all be on one long line:
#tls_trust_file /path/to/Thawte Roots/Thawte SSLWeb Server Roots/thawte Premium Server CA/Thawte Premium Server CA.pem

# Set a default account
# You need to set a default account for Mail
account default : honglili@sohu-inc.com

# end msmtprc

```

4.~/.msmtprc 需要设置正确的访问权限
```objc
chmod 600 ~/.msmtprc
```


5.发送邮件

echo 'hello world' | mail -s "Subject" 305897143@qq.com 
mail -s "test mail" 305897143@qq.com  < ./head.jpg

注：-s "Subject" 指修改标题   < ./head.jpg 重定向内容

其他
发送附件：
cat head.jpg| uuencode head.jpg | mail -s "test" 305897143@qq.com





