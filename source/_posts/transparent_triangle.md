title: 仿科技头条导航下面透明三角
date: 2015-08-11 16:29:00
categories: 技术
tags: 
description:
---
![](http://img.blog.csdn.net/20150811163103620?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQv/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center)

<!--more-->

```objc
//
//  MaskView.m
//  TestDemo
//
//  Created by LHL on 15/8/11.
//  Copyright © 2015年 yongche. All rights reserved.
//

#import "MaskView.h"

@implementation MaskView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 16)];
        imageView.image = [UIImage imageNamed:@"channel_normal_bottom_bg"];
        [self addSubview:imageView];
        
        imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 53, 16)];
        imageView2.image = [UIImage imageNamed:@"channel_selected_bottom_bg"];
        [self addSubview:imageView2];
      
        [self contentOffset:CGPointZero];
      
        
        
    }
    return self;
}

- (void)contentOffset:(CGPoint)contentOffset{
    [imageView removeFromSuperview];
    imageView.image = [UIImage imageNamed:@"channel_normal_bottom_bg"];
    [self addSubview:imageView];

    
    CGRect frame = imageView2.frame;
    frame.origin.x = contentOffset.x;
    imageView2.frame = frame;
    
    // 覆盖图片部分 整成透明
    UIGraphicsBeginImageContext(imageView.frame.size);
    [imageView.image drawInRect:imageView.bounds];
    CGRect image2Frame = imageView2.frame;
    image2Frame.origin.x = image2Frame.origin.x+1;
    image2Frame.size.width = image2Frame.size.width - 2;
    CGContextClearRect (UIGraphicsGetCurrentContext(), image2Frame);
    imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
}

@end

```



源码：[https://github.com/lihongli528628/TestDemo.git](https://github.com/lihongli528628/TestDemo.git)




