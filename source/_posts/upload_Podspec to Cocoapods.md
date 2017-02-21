title: 上传Podspec到Cocoapods
date: 2017-02-14 17:57:00
categories: 技术
tags: [上传, Podspec, Cocoapods]
description:
---
1、cd 到工程目录下 创建xxx.podspec文件  xxx为工程名



```objc
 pod spec create xxx   //xxx为工程名
```

生成xxx.podspec
2、修改xxx.podspec文件内容 


```objc
vi xxx.podspec
```

s.name  pods名称
s.version 版本号  此版本号需要与github中tag的内容一致
s.summary 简短说明
s.homepage github工程的链接地址
s.source  github工程的地址追加.git   
3.之后验证 xxx.podspec文件是否有效


```objc
 pod  spec lint
```

如果未验证通过 出现错误或警告  根据错误提示进行修改 xxx.podspec文件即可
4.git 上传至 oschina或者github 后，标记当前源码版本号，不然发布会报错
	git tag '1.0.1'
	git push --tags
	


5.设置本地pod对应的版本号


```objc
set the new version to 1.0.1set the new tag to 1.0.1
```


6、注册cocoapods维护者信息


```objc
pod trunk me  //查看自己的注册信息
```

如果没有注册过,输入下面的命令 并根据命令进行注册


```objc
pod trunk register xxxxx@qq.com 'author name' --description='macbook pro' --verbose
```

7、上传pod 


```objc
pod trunk push xxxx.podspec --allow-warnings
```

或者


```objc
pod trunk push
```





