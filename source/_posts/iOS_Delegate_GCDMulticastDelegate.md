title: iOS多播Delegate类——GCDMulticastDelegate用法小结
date: 2014-05-14 14:45:00
categories: 技术
tags: 
description:
---
##[iOS多播Delegate类——GCDMulticastDelegate用法小结](http://www.cnblogs.com/gugupluto/p/3673185.html)
    iOS中通常的delegate模式只能有一个被委托的对象，这样当需要有多个被委托的对象时，实现起来就略为麻烦，在开源库XMPPFramework中提供了一个GCDMulticastDelegate类，使用它可以为一个对象添加多个被委托的对象，用起来也比较方便，用法简单小结如下：
    （1）定义一个协议：
　　@protocol MyDelegate
　　@optional
　　-(void)test;
　　@end
 
    （2）在需要使用delegate的类中定义一个GCDMulticastDelegate变量
  
　　@interface ViewController : UIViewController
　　{
  　　　　  GCDMulticastDelegate<MyDelegate> *multiDelegate;
　　}
 
    （3)定义多个实现了协议MyDelegate的类，如Object1和Object2；
    （4）在需要使用delegate的地方使用如下代码，将多个被委托的对象，添加到multiDelegate的delegate链中。
   - (void)viewDidLoad
    {
     multiDelegate = (GCDMulticastDelegate <MyDelegate>
 *)[[GCDMulticastDelegatealloc] init];
      Object1 *o1 = [[Object1 alloc]init];
       Object2 *o2 = [[Object2 alloc]init];
     [multiDelegate addDelegate:o1 delegateQueue:dispatch_get_main_queue()];
     [multiDelegate addDelegate:o2 delegateQueue:dispatch_get_main_queue()];
     [multiDelegate test1];
}
     多播的delegate与通常的delegate不同，multiDelegate并没有实现协议中的方法，而是将协议中的方法转发到自己delegate链中的对象。   对multiDelegate对象调用test1方法时，由于GCDMulticastDelegate没有实现test1方法，因此该类的forwardInvocation函数会被触发，在该函数中会遍历delegate链，对每一个delegate对象调用test1方法，从而实现了多个delegate。同时，在对multiDelegate调用协议方法时，采用的是异步的方式，协议方法会立刻返回，不会阻碍当前函数。
