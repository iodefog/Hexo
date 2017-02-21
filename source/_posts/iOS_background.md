title: iOS后台运行浅析
date: 2015-04-27 20:17:00
categories: 技术
tags: 
description:
---
在之前的文章《[App
 States and Multitasking IOS应用程序状态和多任务](http://www.tekuba.net/program/281/)》
说到IOS程序有前台后台之分。在IOS程序进入后台之后，程序就会不执行代码，如果非要有什么必须执行的过程，可以申请大约600s的时间，如果在这段时间内程序还没有完成则会被系统杀死。出现:has active assertions beyond permitted time. 
更多IOS后台内容参考:<[IOS7
 Background Fetch后台应用程序刷新](http://www.tekuba.net/program/320/)> <[IOS
 7四种后台机制](http://www.tekuba.net/other/319/)>


进入后台后，NSTimer等就不会起作用。
网络上有不少地方提到在进入后台的方法：
- (void)applicationDidEnterBackground:(UIApplication *)application
添加如下代码就可以保持定时器在后台正常工作:

```objc
UIApplication*   app = [UIApplication sharedApplication];  
   __block    UIBackgroundTaskIdentifier bgTask;  
   bgTask = [app beginBackgroundTaskWithExpirationHandler:^{  
       dispatch_async(dispatch_get_main_queue(), ^{  
           if (bgTask != UIBackgroundTaskInvalid)  
           {  
               bgTask = UIBackgroundTaskInvalid;  
           }  
       });  
   }];  
   dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{  
       dispatch_async(dispatch_get_main_queue(), ^{  
           if (bgTask != UIBackgroundTaskInvalid)  
           {  
               bgTask = UIBackgroundTaskInvalid;  
           }  
       });  
   });  
```



在测试的过程中，使用以上方法程序后台运行大约600s之后被系统kill。
实际上上面这段代码执行的效果就是申请额外的运行时间，在后台运行超时后就会被杀死。
不知道第一个写出用这种方式的同学有没有自己试过。
在测试时发现，考察进入后台的状态不要用模拟器，也不要在调试状态。
最好打上写文件的日志，真机不带调试的测，那样才是真正的进入到后台的状态。
关于IOS程序后台长时间运行的问题，这两天的了解结果是：除了IOS支持的audio音频，location位置定位，voip等少数几个功能，其他都很难办到。
其中，使用audio音频，location位置定位等后台服务的时候需要配置plist文件增加**Required background modes**键，并添加**App registers for location updates**，**App plays audio or streams audio/video using AirPlay**两个键值。

App registers for location updates主要是针对定位服务类CLLocationManager，
有新位置会调用-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations方法，在该方法内部，可以做记录位置数据等工作，这些都可以在后台完成。

App plays audio or streams audio/video using AirPlay 
主要是针对音频播放录制类AVAudioPlayer,AVAudioRecorder等,在使用之前首先获取会话

```objc
AVAudioSession *session = [AVAudioSession sharedInstance];
[session setActive:YES error:nil];
[session setCategory:AVAudioSessionCategoryPlayback error:nil];
```



