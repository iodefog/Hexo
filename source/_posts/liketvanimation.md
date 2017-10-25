title: 仿电视关机动画
date: 2014-12-10 18:11:00
categories: 技术
tags: 
description:
---
+(void)animateOut:(UIView *)theView bView:(UIView*)bview
{
  [UIViewanimateWithDuration:0.5animations:^{
    theView.transform =CGAffineTransformMakeScale(1,0.005);
  } completion:^(BOOL finished){
    //黑屏2s
    myView *view = [[myViewalloc]initWithFrame:[UIScreenmainScreen].bounds];
    view.center = bview.center;
<!--more-->
  
     [bview addSubview:view];
    
     [UIViewanimateWithDuration:0.31animations:^{
       theView.transform =CGAffineTransformMakeScale(0,0);
       view.transform =CGAffineTransformMakeScale(1,0.0000001);
        [UIViewanimateWithDuration:10animations:^{
        }];
             //退出
      dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [theView removeFromSuperview];
        exit(0);
      });
    }];
  }];
}
