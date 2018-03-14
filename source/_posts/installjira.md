title: Mac上手把手搭建jira(破解版)环境
date: 2017-11-08
categories: 技术
tags: Mac, jira, MySQL

---
* [一、首先安装MySQL-我这里是使用dmg安装的](#一、首先安装MySQL-我这里是使用dmg安装的)
* [二、下载jira安装包，我这里使用的是jira7.3.8的安装包破解版](#二、下载jira安装包我这里使用的是jira7-3-8的安装包破解版)

## 一、首先安装MySQL-我这里是使用dmg安装的

dmg下载地址：[https://dev.mysql.com/downloads/mysql/](https://dev.mysql.com/downloads/mysql/)

### 1.下载后，双击安装，不再赘述。 
(注意：安装最后会提示一个初始密码，那个截图请保留，修改密码时需要。这里好多文章都没提示，导致我忽略后，又重新安装第二遍)

### 2.启动mysql

点击左上角的 🍎->系统偏好设置->MySql

![image](/img/212689DB-F902-4E1E-9266-DC83A62AA07A.jpeg)

开启 mysql 服务

![image](/img/23D785AE-9774-465C-84F3-EB32EF7E81FF.jpeg)

### 3.修改 mysql 密码

命令行中执行

```bash

$ mysql -uroot -p
// 输入上面下载安装提示的初始密码

// 只需要修改密码就行，其他key值不需要修改
$ SET PASSWORD FOR 'root'@'localhost' = PASSWORD('123456');

```

如果提示 "commod not found" , 我们还需要将mysql加入系统环境变量。

```bash
(1).进入/usr/local/mysql/bin,查看此目录下是否有mysql，见pic6。
(2).执行vim ~/.bash_profile
    在该文件中添加mysql/bin的目录，见pic7：
    PATH=$PATH:/usr/local/mysql/bin
添加完成后，按esc，然后输入wq保存。
最后在命令行输入source ~/.bash_profile
```


### 修改MySQL默认字符集为UTF-8，否则有可能启动jira失败
 
####  1.首先进入数据库，输入show variables like '%char%';可以看到未修改的字符集编码是这样的

在MySQL中，输入：

```base

show variables like '%char%';
```

借用一张图说明效果：
![image](/img/cf4235ff685d50ab910d158f3ef536df.png)

#### 2.退出MySQL页面，同时进入系统偏好设置里关闭MySQL数据库服务器。

#### 3.cd /usr/local/mysql/support-files/ 进入该路径，然后ls查看该路径下的文件

```
$ cd /usr/local/mysql/support-files/
$ ls

```

![image](/img/QQ20171108170804.png)


下面这点也是我按照他的步骤写的，就不改了。贴过来看吧

第一种修改方式： 
如果有以.cnf后缀结尾的文件，那么就可以修改mysql配置文件/etc/my.cnf 
```
sudo cp /usr/local/mysql/support-files/my-medium.cnf /etc/my.cnf 
sudo vi /etc/my.cnf 
```
[client]部分加入： 
default-character-set=utf8 
[mysqld]部分加入： 
character-set-server=utf8 
修改完毕之后再启动mysql 
想必大家已经看到了，我的是没有.cnf文件的，所以自然有

第二种修改方式： 
```
cd /etc 		//进入该路径下 
sudo mkdir my.cnf 	//创建新文件 
sudo vi my.cnf  	//打开该文件 
```
i 进入编辑模式，然后将该文章末尾的一段文本全部复制到该文件下，记住，一个符号都不能少！ 
esc退出编辑模式 
:wq!强制保存退出

#### 4.重新打开数据库服务，然后进入数据库再次输入show variables like ‘%char%’;就可以呈现下面的状态： 


### 其他：附上卸载MySQL的命令，清除所有文件

在OSX中安装Mysql如果一旦出现错误，很难卸载，需要手动删除部分Mysql运行和配置文件，如下为删除相关文件的shell，可能不存在，但尽量查找并删除，避免出现一些莫名问题。

```base
sudo rm /usr/local/mysql
sudo rm -rf /usr/local/mysql*
sudo rm -rf /Library/StartupItems/MySQLCOM
sudo rm -rf /Library/PreferencePanes/My*
vim /etc/hostconfig  (and removed the line MYSQLCOM=-YES-)
rm -rf ~/Library/PreferencePanes/My*
sudo rm -rf /Library/Receipts/mysql*
sudo rm -rf /Library/Receipts/MySQL*
sudo rm -rf /var/db/receipts/com.mysql.*

```

参考：[http://www.jianshu.com/p/b02be6026a2a](http://www.jianshu.com/p/b02be6026a2a)


## 二、下载jira安装包我这里使用的是jira7-3-8的安装包破解版

### 1.下载jira


jira7.3.8安装包下载：[https://downloads.atlassian.com/software/jira/downloads/atlassian-jira-software-7.3.8-x64.bin](https://downloads.atlassian.com/software/jira/downloads/atlassian-jira-software-7.3.8-x64.bin)


jira7.3.8破解包下载:[https://page00.ctfile.com/fs/15323800-217438995](https://page00.ctfile.com/fs/15323800-217438995)


### 2.下载后解压到某个路径下，比如Desktop

### 3.运行/atlassian-jira-software-7.3.8-standalone/bin下的config.sh脚本，设置JIra_Home,设置自定义的数据库（可以测试连接是否成功，别忘了打开MySQL）。如图：

```bash
$ cd ~/Desktop/atlassian-jira-software-7.3.8-standalone/bin
$ sh config.sh
```

![image](/img/1422632-1c2029dfd508d230.png)

![image](/img/1422632-bf47e02854631072.png)

### 4.在atlassian-jira-software-7.3.8-standalone/atlassian-jira/WEB-INF/lib中放入破解文件。文件分享地址(破解文件地址:[提取码m7e3](https://pan.baidu.com/share/init?surl=kUAogtT))


### 5.启动JIra使用如下命令。运行/atlassian-jira-software-7.3.8-standalone/bin下的start-jira.sh脚本


### 6.打开[http://localhost:8080/](http://localhost:8080/)


不出意外，就会成功！我搭建时，因为MySQL字符集不正确，饶了一大圈。不过我已经提前让你修改正确了，应该没毛病的。

![image](/img/timg.jpg)