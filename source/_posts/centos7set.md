title: CentOS 7 最小安装模式配置服务记录
categories: 技术, Apache , centos
tags: 
description:

---

CentOS 7 最小安装模式配置服务记录

# linux ISO镜像
下载地址: [http://mirrors.aliyun.com](http://mirrors.aliyun.com)




# 查看本机的ip地址

```
$ ifconfig

-bash: ifconfig: command not found


// 可查ip命令
$  ip addr

```

# 配置工具

```
// 更新yum
yum updagate


// 安装Wget
yum install wget
```

CentOS 7 ifconfig install

```
# yum install net-tools
```

# Apache 

### Apache 安装

```
$ yum install httpd
```

安装过程中会提示"is this ok [y/d/N]"，输入y，回车即可。

```
systemctl start httpd.service     // 启动
systemctl stop httpd.service      // 停止
systemctl restart httpd.service   // 重启apache

systemctl status httpd.service    // 运行状态
systemctl enable httpd.servic     // 重启服务器时自动启动Apache 服务

vim /etc/httpd/conf/httpd.conf    // 编辑 配置文件

```

### 改变 Apache 默认的站点根目录

```
mkdir /home/lhl/developer/www    // 新建文件

```

修改下 Apache 的配置文件

```
vi /etc/httpd/conf/httpd.conf
```

修改

```
# DocumentRoot "/var/www/html"
DocumentRoot "/home/lhl/developer/www"

<Directory "/home/lhl/developer/www">

    Options Indexes FollowSymLinks
    AllowOverride None
    Order allow,deny
    Allow from all
</Directory>


# <Directory "/var/www/html">
<Directory "/home/lhl/developer/www">
    Options Indexes FollowSymLinks
    AllowOverride All
    Require all granted
</Directory>
```

### 查询日志

```
cat /var/log/httpd/error_log
```

### 解决403文件

把自定义路径下的文件夹全部改成 777权限, 750权限不够

```
chmod -R 777 /home/lhl/developer/www
```

如果在selinux成为问题的情况下，而不是仅仅禁用它，这个页面和这个页面给了命令授予访问权限：
```
chcon -R -t httpd_sys_content_t /home/lhl/developer/www
```

### 安装MariaDB

CentOS 7.0中，已经使用MariaDB替代了MySQL数据库

1、安装MariaDB


```
yum install mariadb mariadb-server #询问是否要安装，输入Y即可自动安装,直到安装完成

systemctl start mariadb.service #启动MariaDB

systemctl stop mariadb.service #停止MariaDB

systemctl restart mariadb.service #重启MariaDB

systemctl enable mariadb.service #设置开机启动

cp /usr/share/mysql/my-huge.cnf /etc/my.cnf #拷贝配置文件（注意：如果/etc目录下面默认有一个my.cnf，直接覆盖即可）
```

2、为root账户设置密码


```
mysql_secure_installation
```
回车，根据提示输入Y

输入2次密码，回车

根据提示一路输入Y

最后出现：Thanks for using MySQL!

MariaDB密码设置完成，重新启动 MariaDB：
```
systemctl restart mariadb.service #重启MariaDB
```

### 安装PHP

1、安装PHP
```
yum install php #根据提示输入Y直到安装完成
```
2、安装PHP组件，使PHP支持 MariaDB
```
yum install php-mysql php-gd libjpeg* php-ldap php-odbc php-pear php-xml php-xmlrpc php-mbstring php-bcmath php-mhash
```
#这里选择以上安装包进行安装，根据提示输入Y回车
```
systemctl restart mariadb.service #重启MariaDB

systemctl restart httpd.service #重启apache
```

### php配置
```
vi /etc/php.ini #编辑

date.timezone = PRC #把前面的分号去掉，改为date.timezone = PRC

disable_functions = passthru,exec,system,chroot,scandir,chgrp,chown,shell_exec,proc_open,proc_get_status,ini_alter,ini_alter,ini_restore,dl,openlog,syslog,readlink,symlink,popepassthru,stream_socket_server,escapeshellcmd,dll,popen,disk_free_space,checkdnsrr,checkdnsrr,getservbyname,getservbyport,disk_total_space,posix_ctermid,posix_get_last_error,posix_getcwd, posix_getegid,posix_geteuid,posix_getgid, posix_getgrgid,posix_getgrnam,posix_getgroups,posix_getlogin,posix_getpgid,posix_getpgrp,posix_getpid, posix_getppid,posix_getpwnam,posix_getpwuid, posix_getrlimit, posix_getsid,posix_getuid,posix_isatty, posix_kill,posix_mkfifo,posix_setegid,posix_seteuid,posix_setgid, posix_setpgid,posix_setsid,posix_setuid,posix_strerror,posix_times,posix_ttyname,posix_uname

#列出PHP可以禁用的函数，如果某些程序需要用到这个函数，可以删除，取消禁用。

expose_php = Off #禁止显示php版本的信息

short_open_tag = ON #支持php短标签

open_basedir = .:/tmp/  #设置表示允许访问当前目录(即PHP脚本文件所在之目录)和/tmp/目录,可以防止php木马跨站,如果改了之后安装程序有问题(例如：织梦内容管理系统)，可以注销此行，或者直接写上程序的目录/data/www.osyunwei.com/:/tmp/
```
:wq! #保存退出
```
systemctl restart mariadb.service #重启MariaDB

systemctl restart httpd.service #重启apache
```

其他：
CentOS7搭建配置Nginx+PHP+MySQL
[https://www.jianshu.com/p/495a02eb2672](https://www.jianshu.com/p/495a02eb2672)


参考：
[https://www.jianshu.com/p/12aa3791e4d5](https://www.jianshu.com/p/12aa3791e4d5)
[https://askubuntu.com/questions/451922/apache-access-denied-because-search-permissions-are-missing](https://askubuntu.com/questions/451922/apache-access-denied-because-search-permissions-are-missing)
[http://yunkus.com/centos7-apache-service-install-config/](http://yunkus.com/centos7-apache-service-install-config/)

[https://www.centos.org/forums/viewtopic.php?t=51249](https://www.centos.org/forums/viewtopic.php?t=51249)