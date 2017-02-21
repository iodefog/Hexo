title: iOS 模拟出一个半透明的ViewController  presentViewController 实现
date: 2015-05-26 16:00:00
categories: 技术
tags: 
description:
---

最近项目有需求, 需要模态初一个半透明的视图, 好多人都碰到这个问题吧, 在目标视图中设置背景颜色然后发现模态动作结束后变成了黑色或者不是半透明的颜色。
所以今天来告诉大家解决方案
	- (IBAction)Avtion1:(id)sender {
	
	    TestViewController * testVC = [TestViewController new];
	
	    self.definesPresentationContext = YES; //self is presenting view controller
	    testVC.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.4];
	    testVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
	
	    [self presentViewController:testVC animated:YES completion:nil];
	}
- 注意：如果present 一个NavController，不能完全使用上面代码。

	
- (IBAction)pushSecond:(id)sender{
    SecondViewController * testVC = [SecondViewControllernew];
    
    self.definesPresentationContext = YES; //self is presenting view controller
    testVC.view.backgroundColor = [UIColorcolorWithRed:0green:0blue:0alpha:.5];
//    testVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    UINavigationController *nav = [[UINavigationControlleralloc] initWithRootViewController:testVC];
    nav.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    nav.view.backgroundColor = [UIColorclearColor];
    [selfpresentViewController:nav animated:YEScompletion:nil];
}


- definesPresentationContext

	/*
	  Determines which parent view controller's view should be presented over for presentations of type
	  UIModalPresentationCurrentContext.  If no ancestor view controller has this flag set, then the presenter
	  will be the root view controller.
	*/
- backgroundColor

	设置你的背景颜色
- modalPresentationStyle

	/*
	  Defines the transition style that will be used for this view controller when it is presented modally. Set
	  this property on the view controller to be presented, not the presenter.  Defaults to
	  UIModalTransitionStyleCoverVertical.
	*/

Demo 如下 ：
[https://github.com/lihongli528628/PreDemo](https://github.com/lihongli528628/PreDemo)

