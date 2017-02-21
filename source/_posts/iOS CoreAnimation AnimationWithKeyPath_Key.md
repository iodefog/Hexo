title: iOS CoreAnimation AnimationWithKeyPath 来改变动画 的Key
date: 2017-02-15 14:49:00
categories: 技术
tags: [iOS, CoreAnimation, AnimationWithKeyPath, 来改变动画, Key]
description:
---
可以通过改变animationWithKeyPath来改变动画：

transform.scale = 比例转换
transform.scale.x = 宽的比例转换
transform.scale.y = 高的比例转换
transform.rotation.z = 平面图的旋转
opacity = 透明度
margin
zPosition
backgroundColor 背景颜色
cornerRadius 圆角
borderWidth
bounds
contents
contentsRect
cornerRadius
frame
hidden
mask
masksToBounds
opacity
position
shadowColor
shadowOffset
shadowOpacity
shadowRadius



[objc] [view
 plain](http://blog.csdn.net/lihongli528628/article/details/47127739# "view plain") [copy](http://blog.csdn.net/lihongli528628/article/details/47127739# "copy")1. // Create animation for location change  
2.        CABasicAnimation *locationAnimation = [CABasicAnimation animationWithKeyPath:@"locations"];  
3.        locationAnimation.fromValue = gradientMask.locations;  
4.        locationAnimation.toValue = adjustedLocations;  
5.        locationAnimation.duration = 0.25;  
6.          
7.        // Create animation for color change  
8.        CABasicAnimation *colorAnimation = [CABasicAnimation animationWithKeyPath:@"colors"];  
9.        colorAnimation.fromValue = gradientMask.colors;  
10.        colorAnimation.toValue = adjustedColo  




