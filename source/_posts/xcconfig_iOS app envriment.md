title: 用xcconfig文件配置iOS app环境变量
date: 2016-08-16 16:53:00
categories: 技术
tags: 
description:
---
#app开发中通常都会涉及到多个环境，Debug、Release等。环境切换时可能就会涉及到服务器url的切换，或者一些第三方sdk的appid的切换。最初我是通过在代码中添加变量的方式来设置环境的：
	static let isRelease = true
	static let serverURL = isRelease ? "prod server url" : "dev server url"
然而这样做的缺陷是，每一次要切换环境的时候都需要去更改这个变量，多次修改后还是会比较烦。并且通常开发中可能会有不止两个环境。所以，配置app环境变量能够更好的解决环境切换的问题。
配置app环境变量的方式有多种，我选择了一种我感觉比较直观的方式来配置——使用xcconfig文件。
##需求
Xcode默认会提供两种配置环境：Debug 和 Release，这两者的区别：
- Debug 会多一些调试信息（网上很多人说release，环境下不能断点之类的，自己测试后发现断点什么的和debug、release没有关系，后面会详细说）
- Release 运行速度快很多，流畅。打的包大小可能要比debug小一些

在我的开发中主要是会用到3种环境：
- 测试服务器debug
- 偶尔会切换到正式服务器debug
- 上架（正式服务器，release）

默认提供的两种还不太够用。。。
根据以上需求，操作步骤大致如下：
##1、添加Build Configuration
打开项目的workspace，进入xcode的主界面。
选中主要工程的project -> info , 找到Configurations, 点击下方的“＋”
![](http://upload-images.jianshu.io/upload_images/1748971-8d924a0586334e07.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
Snip20160813_4.png从图中可以看到两个已经添加好的Configuration: Debug 和 Release
选择“deplicate debug configuration”,添加一个新的configuration,命名为ReleaseTest:
![](http://upload-images.jianshu.io/upload_images/1748971-c306a5df02ee6cba.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
Snip20160814_5.png从图上可以看到，三个configuration都已经有了默认的configuration set(也就是xxconfig文件)。这是因为我的工程中已经包含了cocoapods。默认的configuration set是pods添加的。
这个时候新增加的build configuration并没有对应的pods的xcconfig，所以项目会报错。把新建的configuration 对应的set 设置为none
![](http://upload-images.jianshu.io/upload_images/1748971-e32ba6ac74eb4627.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
Snip20160814_6.png命令行运行
	pod install
完成之后如下图
![](http://upload-images.jianshu.io/upload_images/1748971-717b4fe3a5d646ab.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
Snip20160814_9.png##2、新建并配置xcconfig文件
common + "n", 选择 iOS -> Other -> Configuration settings file
![](http://upload-images.jianshu.io/upload_images/1748971-78f2a366a661d6a1.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
Snip20160814_7.png新建4个xxconfig文件，我采用一下命名：
![](http://upload-images.jianshu.io/upload_images/1748971-9389ce75443f0f53.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
Snip20160814_8.png其中：
CommonConfig.xcconfig 文件中放一些通用的配置，例如build version等
其他三个文件分别对应三个build configuration.
在CommonConfig中添加：
	BUILD_VERSION = 1.0.0
DebugConfig:
	/*
	    导入公共 config
	*/
	#include"CommonConfig.xcconfig"
	/*
	    导入pods 对应的 config
	*/
	#include"Pods/Target Support Files/Pods/Pods.debug.xcconfig"
	
	APP_DISPLAY_NAME = 测试服
	CONFIG_FLAG = DEBUG
ReleaseConfig:
	#include"CommonConfig.xcconfig"
	#include"Pods/Target Support Files/Pods/Pods.release.xcconfig"
	
	APP_DISPLAY_NAME = 真名
	CONFIG_FLAG = RELEASE
ReleaseTestConfig:
	#include"CommonConfig.xcconfig"
	#include"Pods/Target Support Files/Pods/Pods.releasetest.xcconfig"
	
	APP_DISPLAY_NAME = 正式服
	CONFIG_FLAG = RELEASE_TEST
其中：
	#include"Pods/Target Support Files/Pods/Pods.releasetest.xcconfig"
可能会因为项目名称的不同导致路径不同，如果不太确定的可以再次pod install。pods会给出提示，其中包含了正确的路径。
> **重点： pod 使用说明**
> [!] CocoaPods did not set the base configuration of your project because your project already has a custom config set. In order for CocoaPods integration to work at all, please either set the base configurations of the target `configTest` to`Pods/Target
>  Support Files/Pods/Pods.debug.xcconfig` or include the `Pods/Target Support
>  Files/Pods/Pods.debug.xcconfig` in your build configuration.
完成以上后，把build configuration切换成对应的新建的文件：
![](http://upload-images.jianshu.io/upload_images/1748971-f1a525371228d3c3.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
Snip20160814_10.png##2、设置环境变量
完成上面的步骤就已经添加好了环境，剩下的就是设置环境变量
在Info.plist文件中，设置Bundle name 为
	${APP_DISPLAY_NAME}
应用的名称就会根据配置改变了。
![](http://upload-images.jianshu.io/upload_images/1748971-de1d8d6dac8fe640.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
Snip20160814_11.png然而在代码中需要根据环境改变某些变量的值怎么办呢？
###1、设置预编译头参数
####OC
Project -> Build settings -> Apple LLVM 7.1 - Preprocessing
在 preprocessor 中添加
	${CONFIG_FLAG}=1
![](http://upload-images.jianshu.io/upload_images/1748971-f4f2cdbc0fc7d379.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
Snip20160814_12.png####Swift
Project -> Build settings -> Swift Compiler - Custom Flags
在 other swift flags 中添加
	－D ${CONFIG_FLAG}
![](http://upload-images.jianshu.io/upload_images/1748971-3b518f9014a62ce5.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
Snip20160814_21.png####然后
代码中：
	struct AppConfig {
	    private enum AppConfigType {
	        case Debug
	        case Release
	        case ReleaseTest
	    }
	
	    private static var currentConfig: AppConfigType {
	        #if DEBUG = 1
	            return .Debug
	        #elseif RELEASE_TEST = 1
	            return .ReleaseTest
	        #else
	            return .Release
	        #endif
	    }
	
	    static var webServerURL: String {
	        switch currentConfig {
	        case .Debug:
	            return "test url"
	        default:
	            return "release url"
	        }
	    }
	}
其他变量也可以采用以上方式配置。
###添加多个scheme,方便配置切换
![](http://upload-images.jianshu.io/upload_images/1748971-51d9d056d783628d.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
Snip20160814_14.png![](http://upload-images.jianshu.io/upload_images/1748971-785b380092076a20.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
Snip20160814_18.png在scheme中改变build configuration即可实现不同的环境切换，也可以添加多个scheme实现更方便的切换
![](http://upload-images.jianshu.io/upload_images/1748971-4fa370bb13cef1fb.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
Snip20160814_19.png![](http://upload-images.jianshu.io/upload_images/1748971-4b165b90ff55f1c0.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
Snip20160814_20.png**添加的新scheme需要在manage scheme中勾选shared，git上的其他人才能看到新scheme**
![](http://upload-images.jianshu.io/upload_images/1748971-b97ffc642c9a2b15.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
Snip20160814_22.png###DEMO及推荐
[XCConfig Demo](https://github.com/MangoMade/XCConfigTestDemo)
[http://www.jianshu.com/p/9b8bc8351223](http://www.jianshu.com/p/9b8bc8351223)
