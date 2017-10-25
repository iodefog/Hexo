title: CocoaPods安装使用及配置私有库
date: 2015-01-26 18:31:00
categories: 技术
tags: 
description:
---
#CocoaPods安装使用及配置私有库
从前端到obj-c有小半年了,文章又快有一年没有更新过了,前几天才把域名续费了3年,感叹第一个三年就这样过去了….所以决定不能再像以前那样懒了,每天坚持把自己的学习都记录下来然后有空的时候整理下发布到小站,于是有了obj-c的第一篇.
## 如何安装?
1.安装ruby环境,添加淘宝ruby镜像
> `$ gem sources --remove https://rubygems.org/
> 
> //等有反应之后再敲入以下命令
> 
> $ gem sources -a http://ruby.taobao.org/`
2.查看是否设置成功:
> $ gem sources -l
3.然后安装cocoapods:
> $ sudo gem install cocoapods
4.查看cocoapods是否支持某个类库
> $ pod search 类库名,支持模糊查询(如:AFNetworking)
## 如何使用?
- 在项目根目录下新建一个“Podfile”的文件(记住一定得叫这个名儿,而且木有后缀)

注:Podfile也可以放在任何位置,但是需要在Podfile顶部使用”xcodeproj”关键字指定工程的路径,如下:
[![Podfile指明xcodeproj](http://www.exiatian.com/wp-content/uploads/2014/06/32afcb3ad9172cab6f446517fcf5cf8b-e1402762730559.jpeg)](http://www.exiatian.com/wp-content/uploads/2014/06/32afcb3ad9172cab6f446517fcf5cf8b.jpeg)Podfile指明xcodeproj
但是执行pod install命令后,生成的文件放在了Podfile所在的目录.
- 编辑Podfile文件输入以下信息

> platform :iOS, ‘7.0’\\所有库支持的IOS最低版本
> pod ‘AFNetworking’, ‘~> 2.0’\\版本号
注:有些第三方库需要指明:platform 支持的IOS最低版本,否则在pod install时会报错,如下图,提示AFNetworking最低支持IOS6.0和OS X 10.8
[![cocoapods指明ios版本](http://www.exiatian.com/wp-content/uploads/2014/06/358b2924f6658133f11788ffdf1f4e94-e1402763175351.jpeg)](http://www.exiatian.com/wp-content/uploads/2014/06/358b2924f6658133f11788ffdf1f4e94-e1402763175351.jpeg)cocoapods指明ios版本
- 然后在项目podfile所在目录下运行:(会在你当前项目中导入podfile所配置的库,所以要在项目目录下运行)

> $ pod install
注意上述命令运行完毕后终端输出的最后一段话,意思就是以后打开项目就用CocoaPodsDemo.xcworkspace 打开，而不是之前的.xcodeproj文件。
> [!] From now on use `CocoaPodsDemo.xcworkspace`.
经过以上步骤后,我们现在可以打开CocoaPodsDemo.xcworkspace启动我们的新工程了.新工程中已经通过cocoapods引入并配置好了我们刚在podfile写的需要依赖的第三方库了.
## 引入第三方库后找不到头文件?
在项目的Targe-Build Settings-Search Paths-User Header Searcj Paths中添加
${SRCROOT} 值为 recursive
如下图:
[![cocoapods配置头文件](http://www.exiatian.com/wp-content/uploads/2014/06/7f006d0de3578191991becb2417e1c86-e1402763095899.jpeg)](http://www.exiatian.com/wp-content/uploads/2014/06/7f006d0de3578191991becb2417e1c86-e1402763095899.jpeg)cocoapods配置头文件
## 如何编译从github上checkout下来的一个已包含CocoPods类库的项目?
打开终端进入你所下载项目的根目录,执行以下命令,后会得到上面的那句话:
> $ pod update
等待命令运行完毕后,同样最后会输出
> [!] From now on use `xxxxx.xcworkspace`.
## 如何删除cocopods?
1. 删除工程文件夹下的Podfile、Podfile.lock及Pods文件夹
2. 删除xcworkspace文件
3. 使用xcodeproj文件打开工程，删除Frameworks组下的Pods.xcconfig及libPods.a引用
4. 在工程设置中的Build Phases下删除Check Pods Manifest.lock及Copy Pods Resources

[![删除cocoapods](http://www.exiatian.com/wp-content/uploads/2014/06/D465CDE3-3582-49EA-B535-3400C3B29EB5-e1402763591159.jpg)](http://www.exiatian.com/wp-content/uploads/2014/06/D465CDE3-3582-49EA-B535-3400C3B29EB5-e1402763591159.jpg)删除cocoapods
## CocoaPods常用命令
1、pod install
根据Podfile文件指定的内容，安装依赖库，如果有Podfile.lock文件而且对应的Podfile文件未被修改，则会根据Podfile.lock文件指定的版本安装。
每次更新了Podfile文件时，都需要重新执行该命令，以便重新安装Pods依赖库。
2、pod update
若果Podfile中指定的依赖库版本不是写死的，当对应的依赖库有了更新，无论有没有Podfile.lock文件都会去获取Podfile文件描述的允许获取到的最新依赖库版本。
3、pod search
命令格式为：
> $ pod search 类库名,支持模糊查询(如:AFNetworking)
[![pod search功能](http://www.exiatian.com/wp-content/uploads/2014/06/97dedd66f04a9756be10f273d3fde08e-e1402763691838.jpeg)](http://www.exiatian.com/wp-content/uploads/2014/06/97dedd66f04a9756be10f273d3fde08e.jpeg)pod search功能
红框中的信息为AFNetworking 最新版本,Version中显示了历史版本,根据这些信息来编写我们的Podfile文件如:
> pod ‘AFNetWorking’, ‘~> 2.2.4′
这句话具体含义是什么呢?
当我们通过cocopods引入依赖库时，需要显示或隐式注明引用的依赖库版本，具体写法和表示含义如下
> pod ‘AFNetworking’      //不显式指定依赖库版本，表示每次都获取最新版本
> pod ‘AFNetworking’, ‘2.0’     //只使用2.0版本
> pod ‘AFNetworking’, ‘> 2.0′     //使用高于2.0的版本
> pod ‘AFNetworking’, ‘>= 2.0′     //使用大于或等于2.0的版本
> pod ‘AFNetworking’, ‘< 2.0′     //使用小于2.0的版本
> pod ‘AFNetworking’, ‘<= 2.0′     //使用小于或等于2.0的版本
> pod ‘AFNetworking’, ‘~> 0.1.2′     //使用大于等于0.1.2但小于0.2的版本
> pod ‘AFNetworking’, ‘~>0.1′     //使用大于等于0.1但小于1.0的版本
> pod ‘AFNetworking’, ‘~>0′     //高于0的版本，写这个限制和什么都不写是一个效果，都表示使用最新版本
4、pod setup
用于跟新本地电脑上的保存的Pods依赖库tree。由于每天有很多人会创建或者更新Pods依赖库，这条命令执行的时候会相当慢，还请耐心等待。我们需要经常执行这条命令，否则有新的Pods依赖库的时候执行pod search命令是搜不出来的。
①多个target中使用相同的Pods依赖库
比如，名称为CocoaPodsTest的target和Second的target都需要使用Reachability、SBJson、AFNetworking三个Pods依赖库，可以使用link_with关键字来实现，将Podfile写成如下方式：
> link_with ‘CocoaPodsTest’, ‘Second’
> platform :ios
> pod ‘Reachability’,  ‘~> 3.0.0′
> pod ‘SBJson’, ‘~> 4.0.0′
> platform :ios, ‘7.0’
> pod ‘AFNetworking’, ‘~> 2.0′
这种写法就实现了CocoaPodsTest和Second两个target共用相同的Pods依赖库。
②不同的target使用完全不同的Pods依赖库
CocoaPodsTest这个target使用的是Reachability、SBJson、AFNetworking三个依赖库，但Second这个target只需要使用OpenUDID这一个依赖库，这时可以使用target关键字，Podfile的描述方式如下：
> target :’CocoaPodsTest’ do
> platform :ios
> pod ‘Reachability’,  ‘~> 3.0.0′
> pod ‘SBJson’, ‘~> 4.0.0′
> platform :ios, ‘7.0’
> pod ‘AFNetworking’, ‘~> 2.0′
> end
> target :’Second’ do
> pod ‘OpenUDID’, ‘~> 1.0.0′
> end
其中，do/end作为开始和结束标识符。
## Podfile.lock文件
在使用CocoaPods，执行完pod install之后，会生成一个Podfile.lock文件。这个文件看起来跟我们关系不大，实际上绝对不应该忽略它。
该文件用于保存已经安装的Pods依赖库的版本，通过CocoaPods安装了SBJson、AFNetworking、Reachability三个POds依赖库以后对应的Podfile.lock文件内容为：
> PODS:
> – AFNetworking (2.1.0):
> – AFNetworking/NSURLConnection
> – AFNetworking/NSURLSession
> – AFNetworking/Reachability
> – AFNetworking/Security
> – AFNetworking/Serialization
> – AFNetworking/UIKit
> – AFNetworking/NSURLConnection (2.1.0):
> – AFNetworking/Reachability
> – AFNetworking/Security
> – AFNetworking/Serialization
> – AFNetworking/NSURLSession (2.1.0):
> – AFNetworking/NSURLConnection
> – AFNetworking/Reachability (2.1.0)
> – AFNetworking/Security (2.1.0)
> – AFNetworking/Serialization (2.1.0)
> – AFNetworking/UIKit (2.1.0):
> – AFNetworking/NSURLConnection
> – Reachability (3.0.0)
> – SBJson (4.0.0)
> DEPENDENCIES:
> – AFNetworking (~> 2.0)
> – Reachability (~> 3.0.0)
> – SBJson (~> 4.0.0)
> SPEC CHECKSUMS:
> AFNetworking: c7d7901a83f631414c7eda1737261f696101a5cd
> Reachability: 500bd76bf6cd8ff2c6fb715fc5f44ef6e4c024f2
> SBJson: f3c686806e8e36ab89e020189ac582ba26ec4220
> COCOAPODS: 0.29.0
Podfile.lock文件最大得用处在于多人开发。当团队中的某个人执行完pod install命令后，生成的Podfile.lock文件就记录下了当时最新Pods依赖库的版本，这时团队中的其它人check下来这份包含Podfile.lock文件的工程以后，再去执行pod install命令时，获取下来的Pods依赖库的版本就和最开始用户获取到的版本一致。如果没有Podfile.lock文件，后续所有用户执行pod install命令都会获取最新版本的SBJson，这就有可能造成同一个团队使用的依赖库版本不一致，这对团队协作来说绝对是个灾难！
在这种情况下，如果团队想使用当前最新版本的SBJson依赖库，有两种方案：
1. 更改Podfile，使其指向最新版本的SBJson依赖库；
2. 执行pod update命令；

鉴于Podfile.lock文件对团队协作如此重要，我们需要将它添加到版本管理中。
## 如何制作自己的Cocopods库
1.在github上新建一个工程
[![github上新建pod工程](http://www.exiatian.com/wp-content/uploads/2014/06/41f2bfaad9a94db46c75ed7514634890-e1402763923600.jpeg)](http://www.exiatian.com/wp-content/uploads/2014/06/41f2bfaad9a94db46c75ed7514634890-e1402763923600.jpeg)github上新建pod工程
license类型
正规的仓库都应该有一个license文件，Pods依赖库对这个文件的要求更严，是必须要有的。因此最好在这里让github创建一个，也可以自己后续再创建。我使用的license类型是MIT。
把项目clone到本地然后在根目录下新建MyPodDemo.podspec
或使用命令
	$ pod spec create MyPodDemo
Spec文件编写:
	Pod::Spec.new do |s|
	 s.name = "MyPodDemo"
	 s.version = "0.0.1"
	 s.summary = "A short description of MyPodDemo."
	 s.description = <<-DESC
	 A longer description of MyPodDemo in Markdown format.
	 * Think: Why did you write this? What is the focus? What does it do?
	 * CocoaPods will be using this to generate tags, and improve search results.
	 * Try to keep it short, snappy and to the point.
	 * Finally, don't worry about the indent, CocoaPods strips it!
	 DESC
	 s.homepage = "https://github.com/goingta/MyPodDemo"
	 s.license = "MIT"
	 s.author = { "goingta" => "tangle1128@gmail.com" }
	 s.source = { :git => "https://github.com/goingta/MyPodDemo.git", :tag => "0.0.1" }
	 s.source_files = "MyPodDemo/Src", "MyPodDemo/Src/**/*.{h,m}"
	 s.requires_arc = true
	 # s.framework = "SomeFramework"
	 # s.frameworks = "SomeFramework", "AnotherFramework"
	 # s.library = "iconv"
	 # s.libraries = "iconv", "xml2"
	 # s.dependency "JSONKit", "~> 1.4"
	 # s.dependency "AFNetworking", "~> 2.2.4"
	 end
自解析:
	 name: 导入pod后的目录名
	 version: 当前版本号
	 deployment_target: 配置的target
	 prefix_header_file: 预编译头文件路径，将该文件的内容插入到Pod的pch文件内
	 source: 来源的具体路径，是http链接还是本地路径
	 requires_arc: 是否需要arc
	 source_files: 指定该目录下包含哪些文件
	 其他可选参数还包括：
	 dependency: 指定依赖，如果依赖的库不存在或者依赖库的版本不符合要求将会报错
	 libraries: 指定导入的库，比如sqlite3
	 frameworks: 指定导入的framework
	 weak_frameworks: 弱链接，比如说一个项目同时兼容iOS6和iOS7，但某一个framework只在iOS7上有，这时候如果用强链接，那么在iOS7上运行就会crash，使用weak_frameworks可以避免这种情况。
整个podspec语法是一个嵌套结构从Pod::Spec.new do |s|到最后一个end是最大的循环，表示整个podspec导入的文件。中间每一个subspec到end结束是一个子目录，Pods会为每个subspec创建一个逻辑目录，相当于Xcode的group概念。|**|中间是subspec的名字，可以随便命名，但后面使用的名称必须一致。
通配符说明
> a{bb,bc}def.{h,m}表示四个文件abbdef.h abbdef.m abcdef.h abcdef.m
> *.{h,m,mm}表示所有的.h .m .mm文件
> Class/**/*.{h,m}表示Class目录下的所有.h .m文件
写完podspec文件后使用pod spec lint验证spec是否合格,有error则需要修改
 
[![spec文件验证](http://www.exiatian.com/wp-content/uploads/2014/06/686c51fb0080acd0c78c7a92711729ce-e1402764345311.jpeg)](http://www.exiatian.com/wp-content/uploads/2014/06/686c51fb0080acd0c78c7a92711729ce-e1402764345311.jpeg)spec文件验证
## 上传代码至github
上传podspec文件到CocoaPods仓库(fork一下,修改完成后在push上去等待审核)
将我们刚刚生成的MyPodDemo.spec 文件上传到Cocoapods官方specs仓库中 :
链接为：[https://github.com/CocoaPods/Specs](https://github.com/CocoaPods/Specs "cocopods specs地址")
## 私有库实现,编写podfile
如果由于某些原因我们编写的库不能公开,但是又想使用pods来进行管理,要怎么办呢?
首先我们要将我们刚刚在github上建的仓库改为Private(不然还用Public搞毛啊)
然后修改我们项目的podfile,与已加入Cocopods仓库的公有库相比我们只需要指明私有库低git地址,如下:
	platform :ios, '6.0'
	pod 'MyPodDemo', :git => 'https://github.com/goingta/MyPodDemo.git' //私有库
	pod 'CocoaLumberjack'//公有库
## 版本控制和冲突(引用自[http://objccn.io/issue-6-4/](http://objccn.io/issue-6-4/))
CocoaPods 使用语义版本控制 – Semantic Versioning 命名约定来解决对版本的依赖。由于冲突解决系统建立在非重大变更的补丁版本之间，这使得解决依赖关系变得容易很多。例如，两个不同的 pods 依赖于 CocoaLumberjack 的两个版本，假设一个依赖于2.3.1，另一个依赖于 2.3.3，此时冲突解决系统可以使用最新的版本 2.3.3，因为这个可以向后与 2.3.1 兼容。
但这并不总是有效。有许多第三方库并不使用这样的约定，这让解决方案变得非常复杂。
当然，总会有一些冲突需要手动解决。如果一个库依赖于 CocoaLumberjack 的 1.2.5，另外一个库则依赖于 2.3.1，那么只有最终用户通过明确指定使用某个版本来解决冲突。
## 配置非ARC文件(8.5号补充)
前几天项目中由于历史原因,导致有一个私有的pods库中某几个文件是在非ARC时代写的,如果要进行修改工程量浩大,于是乎要对这几个文件单独处理,这几个文件不使用arc其他文件使用arc,网上查了一些资料,只需要对source_file进行修改并排除那几个不使用ARC的文件就可以了,大致修改如下:
	Pod::Spec.new do |s|
	 s.name = "MyPodDemo"
	 s.version = "0.0.1"
	 s.summary = "A short description of MyPodDemo.
	 s.homepage = "https://github.com/goingta/MyPodDemo"
	 s.license = "MIT"
	 s.author = { "goingta" => "tangle1128@gmail.com" }
	 s.source = { :git => "https://github.com/goingta/MyPodDemo.git", :tag => "0.0.1" }
	 s.source_files = "MyPodDemo"
	 non_arc_files = 'MyPodDemo/NoArcFile1.{h,m}','MyPodDemo/NoArcFile2.{h,m}'
	 s.requires_arc = true
	
	 s.exclude_files = non_arc_files
	 s.subspec 'no-arc' do |sna|
	 sna.requires_arc = false
	 sna.source_files = non_arc_files
	 end
	end

--------------------------------------  补充：--------------------------------------

## fork一份CocoaPods官方的Specs仓库
这种方法已经摒弃，最新方式是使用trunk提交

## 四、提交修改文件到github
经过步骤三，向本地的git仓库中添加了不少文件，现在需要将它们提交到github仓库中去。提交过程分以下几步：
##[]() 1、pod验证
执行以下命令：[view
 source](http://www.it165.net/pro/html/201403/10126.html#viewSource "view source")[print](http://www.it165.net/pro/html/201403/10126.html#printSource "print")[?](http://www.it165.net/pro/html/201403/10126.html#about "?")`1.``$
 set the ``new` `version
 to ``1.0``.``0``2.``$
 set the ``new` `tag
 to ``1.0``.``0`这两条命令是为pod添加版本号并打上tag。然后执行pod验证命令：[view
 source](http://www.it165.net/pro/html/201403/10126.html#viewSource "view source")[print](http://www.it165.net/pro/html/201403/10126.html#printSource "print")[?](http://www.it165.net/pro/html/201403/10126.html#about "?")`1.``$
 pod lib lint`如果一切正常，这条命令执行完后会出现下面的输出：[view
 source](http://www.it165.net/pro/html/201403/10126.html#viewSource "view source")[print](http://www.it165.net/pro/html/201403/10126.html#printSource "print")[?](http://www.it165.net/pro/html/201403/10126.html#about "?")`1.``->
 WZMarqueeView (``1.0``.``0``)``2.` `3.``WZMarqueeView
 passed validation.`到此，pod验证就结束了。 需要说明的是，在执行pod验证命令的时候，打印出了任何warning或者error信息，验证都会失败！如果验证出现异常，打印的信息会很详细，大家可以根据对应提示做出修改。

##[]() 2、本地git仓库修改内容上传到github仓库
依次执行以下命令：[view
 source](http://www.it165.net/pro/html/201403/10126.html#viewSource "view source")[print](http://www.it165.net/pro/html/201403/10126.html#printSource "print")[?](http://www.it165.net/pro/html/201403/10126.html#about "?")`1.``$
 git add -A && git commit -m ``"Release
 1.0.0."``2.``$
 git tag ``'1.0.0'``3.``$
 git push --tags``4.``$
 git push origin master`上述命令均属git的范畴，这里不多述。如果一切正常，github上就应该能看到自己刚添加的内容了。
以前我们用的podspec为ruby格式，而trunk带来了更方便的json格式，以后可以用json来配置pod。 之前我们发布的pod也会转换未json文件
## 继续
首先更新了用trunk之后，CocoaPods 需要0.33版本以上的，用 `pod --version`查看，如果版本低，需要更新，之前有介绍更新方法。
下一步注册trunk
	pod trunk register orta@cocoapods.org 'Orta Therox' --description='macbook air'
你注册的时候需要替换邮箱和名字，加上 `--verbose` 可以看到详细信息。
然后顺利的话你会收到一份邮件，需要点击验证。
	pod trunk me //查看自己的注册信息
![](http://img2.tuicool.com/QvyeIne.jpg)
当然，如果你的pod是由多人维护的，你也可以添加其他维护者
	pod trunk add-owner ARAnalytics kyle@cocoapods.org
## 创建podspec
执行命令:
	pod spec create HZWebViewController
会在当前目录下生成 `HZWebViewController.podspec` 文件，然后我们编辑这个文件。
podspec文件里面有很多注释。我们看个例子
一眼看去就很明白了，不用一一解释了，当然，这里的配置项远远多于这些。
ok这里配置完成之后，需要把你的源码push到github上，tag一个版本号并且发布一个release版本，这样podspec文件中的s.source的值才能是准确的。
这些操作也不属于本文的所研究的范畴。
## 提交
上面的工作完成之后，我们就可以开始 `trunk push` 了
`pod trunk push` 命令会首先验证你本地的podspec文件(是否有错误)，之后会上传spec文件到trunk，最后会将你上传的podspec文件转换为需要的json文件
第一步验证podspec文件也可以自己去做 `pod spec lint Peanut.podspec`
成功部署之后，CocoaPods会在Twitter上@你
我们可以看看我们提交的名字为:HZWebViewController的pod
	pod search HZWebViewController
![](http://img1.tuicool.com/MJbuyi.jpg)
我们也可以在本地的 `~/.cocoapods` 路径下看到,转换之后的json文件
![](http://img0.tuicool.com/zIRreqB.jpg)

##补充 Claim your Pod
如果你之前提交过pod，那么trunk之后你需要去(Claim your Pod)认领
查看进度https://github.com/CocoaPods/Specs/pulls
 
