title: New export options Plist in Xcode 9
date: 2017-9-18 17:14:00
categories: 技术
tags: 
description:
---

即使Xcode 9还处于测试阶段，Bitrise已经有一个Xcode 9堆栈，许多人在尝试心情时使用它。👨🔬

然而，由于新的导出选项，几个版本失败。我们正在进行更新Xcode Archive以自动检测此新选项的步骤。直到我们发布修复程序，让我们看看问题和解决方案。

<!--more-->



# 之前Xcode 9

Xcode 7引入了命令行工具的exportOptionsPlist标志xcodebuild来指定IPA导出参数。（要查看可用的IPA导出选项调用：xcodebuild -h并Available keys for -exportOptionsPlist:在命令的输出中搜索。）

在Xcode 9之前，最小exportOptionsPlist指定exportMethod：

``` objc
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
    <dict>
        <key>method</key>
        <string>development</string>
    </dict>
</plist>
```
这些导出选项仍然可用，并且当您在本地Xcode中导出IPA时，您仍然必须选择这些选项。

当您使用IDE第一次导出您的IPA时，您需要Select a method for distribution定义该method键exportOptionsPlist。（所有其他选项可以类似地映射到UI选项。）
Xcode Archive for iOS如果将Select method for export输入设置为，则该步骤可以根据嵌入到.xcarchive文件中的配置配置文件来确定所需的导出选项auto-detect。

# 但是用Xcode 9 ...⚠

使用Xcode 9的xcodebuild工具，您需要比以前的Xcode版本更具体：如果您使用auto-detect导出方法在Xcode 9.0.x堆栈上运行该步骤，您将收到以下错误消息：

```
"Error Domain=IDEProvisioningErrorDomain Code=9 \"\"ios-simple-objc.app\" requires a provisioning profile.\" 
UserInfo={NSLocalizedDescription=\"ios-simple-objc.app\" requires a provisioning profile., NSLocalizedRecoverySuggestion=Add 
a profile to the \"provisioningProfiles\" dictionary in your Export Options property list.}"
```

从日志中可以看到，您需要将provisioningProfiles密钥添加到exportOptionsPlist文件中，并且此值应描述应使用哪个配置文件对哪个包ID进行签名。

# 目前的解决方案

所以你必须让你的本地Xcode 9为你生成exportOptions文件，一旦你的Xcode生成了这个文件，你可以用这些选项配置Xcode存档步骤：

* 1.使用 Xcode 9 打开项目.
* 2.Archive项目 Product->Archive.
* 3.Archive项目完成后，将生成的.xcarchive文件导出到IPA文件中。Xcode将在生成的IPA文件旁边复制使用的exportOptionsPlist文件
* 4.在您喜欢的文本编辑器中打开此plist文件并复制其内容
* 5.将其内容粘贴到Xcode存档步骤的Custom export options plist content输入


![image](/img/9EC84551-CA4A-4782-A4B2-CEC0A88F31C9.png)


🎉 ！

您现在可以在Xcode 9.0.x位升序堆栈上导出您的iOS项目，就像在本地计算机上一样。

快乐编码！👻


引用自：[https://blog.bitrise.io/new-export-options-plist-in-xcode-9](https://blog.bitrise.io/new-export-options-plist-in-xcode-9)