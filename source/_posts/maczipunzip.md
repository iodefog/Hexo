title: mac zip unzip 命令
date: 2015-09-06 16:09:00
categories: 技术
tags: 
description:
---
最通俗的用法
zip -q -r -e -m -o myfile.zip someThing
-q 表示不显示压缩进度状态
-r 表示子目录子文件全部压缩为zip  //这部比较重要，不然的话只有something这个文件夹被压缩，里面的没有被压缩进去
-e 表示你的压缩文件需要加密，终端会提示你输入密码的
// 还有种加密方法，这种是直接在命令行里做的，比如zip -r -P Password01! modudu.zip SomeDir, 就直接用Password01!来加密modudu.zip了。
-m 表示压缩完删除原文件
-o 表示设置所有被压缩文件的最后修改时间为当前压缩时间
 
<!--more-->


当跨目录的时候是这么操作的
zip -q -r -e -m -o '\user\someone\someDir\someFile.zip' '\users\someDir'

unzip命令 

语法：unzip [选项] 压缩文件名.zip 

各选项的含义分别为： 

-x 文件列表 解压缩文件，但不包括指定的file文件。 

-v 查看压缩文件目录，但不解压。 

-t 测试文件有无损坏，但不解压。 

-d 目录 把压缩文件解到指定目录下。 

-z 只显示压缩文件的注解。 

-n 不覆盖已经存在的文件。 

-o 覆盖已存在的文件且不要求用户确认。 

-j 不重建文档的目录结构，把所有文件解压到同一目录下。 

例1：将压缩文件text.zip在当前目录下解压缩。 

$ unzip text.zip 

例2：将压缩文件text.zip在指定目录/tmp下解压缩，如果已有相同的文件存在，要求unzip命令不覆盖原先的文件。 

$ unzip -n text.zip -d /tmp 

例3：查看压缩文件目录，但不解压。 

$ unzip -v text.zip 



