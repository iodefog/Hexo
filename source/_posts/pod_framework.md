title: Cocoapods 引用自定义Framework + Swift
tags: framework, cocoapods
categories: iOS,技术

---

自定义Framew 一个模板

```base
Pod::Spec.new do |s|
  s.name         = "FMTest"
  s.version      = "0.0.1"
  s.summary      = "These will help people to find your library, and whilst ithhh"
  s.description  = <<-DESC
These will help people to find your library, and whilst itadfadfda
                   DESC
  s.homepage     = "http://git.d.sohu.com/honglili/videoframework"
  s.license      = "MIT"
  s.author             = { "lihongli" => "honglili@sohu-inc.com" }
  s.platform     = :ios, "7.0"

  s.source       = { :git => "http://git.d.sohu.com/honglili/videoframework.git", :tag => "#{s.version}" }

  # s.source_files  = "Class/*.{h,m}"
  # s.exclude_files = "Classes/Exclude"

  s.public_header_files = "FMTest/headers/*.{h,m}"


  # s.resource  = "icon.png"
  # s.resources = "Resources/*.png"
  s.resource = "FMTest.framework/SohuVideoSDK.bundle"

  # s.framework  = "SomeFramework"
   # s.frameworks = "Foundation", "UIKit"
 
   s.vendored_frameworks = 'FMTest.framework'

  # s.library   = "iconv"
  # s.libraries = "iconv", "xml2"

  # s.requires_arc = true

  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # s.dependency "Masonry"

end

```


-----

创建 Swift Pod库 

```

Pod::Spec.new do |s|

  s.name         = "SendSandBoxFileSwift"
  s.version      = "1.0"
  s.summary      = "Swift Use airDrop or Mail to transfer sandBox files, or view the file directly or play the video"

  s.description  = <<-DESC
  For Swift

  let fileListVC =  FileListTableViewController();
self.navigationController?.pushViewController(fileListVC, animated: true);
                   DESC

  s.homepage     = "https://github.com/iodefog/SendSandBoxFileSwift"
  s.license      = "MIT"
  s.author             = { "lihongli" => "honglili@sohu-inc.com" }
  s.platform     = :ios, "8.0"

  s.source       = { :git => "https://github.com/iodefog/SendSandBoxFileSwift.git", :tag => "#{s.version}" }

  s.source_files  = "Classes", "SendSandBoxFileSwift/**/*.swift"
  s.exclude_files = "Classes/Exclude"

  s.frameworks = "MessageUI", "UIKit", "Foundation"
  s.pod_target_xcconfig = { "SWIFT_VERSION" => "3.2" }

end

```

如果报错
```
$  pod lib lint --verbose 

Check dependencies
The “Swift Language Version” (SWIFT_VERSION) build setting must be set to a supported value for targets which use Swift. This setting can be set in the build settings editor.
The “Swift Language Version” (SWIFT_VERSION) build setting must be set to a supported value for targets which use Swift. This setting can be set in the build settings editor.

 -> SendSandBoxFileSwift (1.0)
    - ERROR | [iOS] xcodebuild: Returned an unsuccessful exit code.
```

需要加入

```
s.pod_target_xcconfig = { "SWIFT_VERSION" => "4.0" }
echo "4.0" > .swift-version
```

