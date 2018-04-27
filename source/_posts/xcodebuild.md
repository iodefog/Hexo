title: Xcode 打包
categories: 技术
tags: 
description:

---

## 1、修改bundle identifier

```
sed -i '' s/com.lhl.oldid/com.lhl.newid/g /Users/dcw0505/Desktop/test/test.xcodeproj/project.pbxproj


```

  s 表示替换命令，/com.lhl.oldid/表示匹配 com.lhl.oldid ，/Hcom.lhl.newid/表示把匹配替换成com.lhl.newid 
 -i 参数直接修改文件内容


## 2.修改应用名

```
/usr/libexec/PlistBuddy -c "Set :CFBundleDisplayName $appName" /Users/dcw0505/Desktop/test/test/info.plist

```

## PlistBuddy介绍

plist是Mac种非常普遍的一种文件格式，类似xml，通过键值对的方式来进行一些配置。而PlistBuddy则是Mac自带的专门解析plist的小工具，Buddy为好朋友，伙伴的意思。从名字不难看出PlistBuddy对plist文件的友好支持。

###  查看帮助

```
/usr/libexec/PlistBuddy --help
```

### 打印info.plist文件

```
/usr/libexec/PlistBuddy -c "print" info.plist
```

### 添加普通字段:

```
/usr/libexec/PlistBuddy -c 'Add :Version string 1.0' info.plist
```

### 添加数组字段，分两步走，注意：key之间用 : 隔开，且不能有空格：

```
# 先添加key值
/usr/libexec/PlistBuddy -c 'Add :Application array' info.plist
# 添加value值
yans67deMacBook-Pro:needfiles huangyg$ /usr/libexec/PlistBuddy -c 'Add :Application: string app1' info.plist
yans67deMacBook-Pro:needfiles huangyg$ /usr/libexec/PlistBuddy -c 'Add :Application: string app2' info.plist
yans67deMacBook-Pro:needfiles huangyg$ /usr/libexec/PlistBuddy -c 'Add :Application: string app3' info.plist
```

### 添加字典字段，分两步走：

```
# 先添加key值
/usr/libexec/PlistBuddy -c 'Add :Person dict' info.plist
# 添加value值,
/usr/libexec/PlistBuddy -c 'Add :Age string secret' info.plist
/usr/libexec/PlistBuddy -c 'Add :Person:Name string yans67' info.plist
/usr/libexec/PlistBuddy -c 'Add :Person:sex string boy' info.plist
/usr/libexec/PlistBuddy -c 'Add :Person:weight string 65' info.plist
```

### 打印字段相应的值：

```
 /usr/libexec/PlistBuddy -c 'Print :Person' info.plist
```

### 在array中我们还可以根据下标打印某个特定的值

```
/usr/libexec/PlistBuddy -c 'Print :Application:2' info.plist
```
### 删除字段相应的值：

```
/usr/libexec/PlistBuddy -c 'Delete :Version' info.plist
```

### 修改某个字段相应的值：

```
/usr/libexec/PlistBuddy -c 'Set :Application:1 string "thi is app1"' info.plist
```

### 当有两个plist文件的时候，我们可以对其进行合并操作

```
# 将A.plist 合并到 B.plist中
/usr/libexec/PlistBuddy -c 'Merge A.plist'  B.plist
```



参考：

[https://coolshell.cn/articles/9104.html](https://coolshell.cn/articles/9104.html)