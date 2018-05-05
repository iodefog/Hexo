title: 手把手利用Google cloud platform 建立VPS
categories: 技术,vps

-----------

手把手利用Google cloud platform 建立VPS

## 1.准备工作
1. 一张VISA信用卡
2. Google 账户
3. 由于 Google 在中国是不存在的，所以 要有代理
4. 下载[ShadowsocksX](/file/ShadowsocksX.zip)


300刀一年的有效期，使用最低配的话，可以玩一年，每个月有86G的流量，个人使用足够了吧......

## 2.开始申请
选择国家

很多人说不能选中国，后面会无法通过，不过我用的就是中国的，已经通过了。如果觉得不保险，可以用虚拟的美国身份 

随机生成美国身份[http://www.haoweichi.com/Index/random](http://www.haoweichi.com/Index/random)

填写注册信息和信用卡
根绝你的身份和信用卡账单地址如实填写就好了，如实也包括上面的美国身份。

信用卡会扣除1美元，过一会就会返还。


## 3.设定防火墙
* 从选单中找到网路- VPC网路- 防火墙规则
![image](https://upload-images.jianshu.io/upload_images/2968083-b34d227bf49e10cc.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/653)
* 选择建立防火墙规则
![image](https://wx3.sinaimg.cn/mw690/699c2d0fly1fesgxm2qxpj20ml0mymyg.jpg)

* 选择目标
* ip范围输入 0.0.0.0/0
* 建立完毕可以看到刚刚建立的规则




## 3.申请静态IP
这个步骤可有可无。具体区别请看以下描述。

* 静态IP地址 被分配到一个项目长期直到它们被明确地释放，并且保持附着到一个实例，即使当实例停止，直到它们被明确地分离。
* 临时IP地址 分配给一个实例只有等到它重新启动或终止。 如果一个实例被终止或停止时，分配给该实例的任何临时的外部IP地址被释放回通用计算引擎IP地址池，成为可以使用的其他项目。 当停止实例再次启动，一个新的临时外部IP地址被分配给该实例。
直接访问 ： https://console.cloud.google.com/networking/addresses/list

或者在菜单中依次点击 【网络】–>  【外部IP地址】 –> 【保留静态IP】

区域可选亚洲东部、欧洲、美国 等地。推荐亚洲！
![](https://51.ruyo.net/wp-content/uploads/2016/09/4.png)

PS : 静态IP只能申请一个！！！

## 4.开启一个新的Project
这边范例名称使用personal VPN
![image](https://upload-images.jianshu.io/upload_images/2968083-6b44ef610481cbb1.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/700)

## 5.建立VM执行个体

* 从左侧开启选单，寻找Compute Engine，找到VM执行个体
![image](https://upload-images.jianshu.io/upload_images/2968083-5785c7cb3254b162.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/700)

* 等待VM执行个体初始化完成
![image](https://upload-images.jianshu.io/upload_images/2968083-dc884f70e1746190.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/700)

* 选择建立
![image](https://upload-images.jianshu.io/upload_images/2968083-b56c6c195402d947.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/644)

* 设定VM 名称以及位置与配备
![image](https://51.ruyo.net/wp-content/uploads/2016/09/5.png)
![](https://51.ruyo.net/wp-content/uploads/2016/09/6.png)


### 6.配置SSH

* 需要点两下SSH 

![](https://img-blog.csdn.net/20180119220707358?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvY2hvdXhpaGFv/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)

1. 第一步输入 "sudo -i " ,获取root权限.

![](https://img-blog.csdn.net/20180119220733572?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvY2hvdXhpaGFv/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)
2. 第二步运行如下代码

```
wget --no-check-certificate https://raw.githubusercontent.com/teddysun/shadowsocks_install/master/shadowsocks-go.sh
chmod +x shadowsocks-go.sh
./shadowsocks-go.sh 2>&1 | tee shadowsocks-go.log
```

黏贴进去然后  回车 。执行完毕后

![image](/img/QQ20180505-133654.png)


参考资料：

[Google Cloud服务免费申请试用以及使用教程](https://51.ruyo.net/2144.html)

[Shadowsocks Python版一键安装脚本](https://www.jianshu.com/p/9625bfbc1bf4)

[用Google Cloud搭建免费一年的SS](https://www.jianshu.com/p/6bd66829a1ce)

[用谷歌cloud搭建可以学上网方式](https://blog.csdn.net/chouxihao/article/details/79111121)