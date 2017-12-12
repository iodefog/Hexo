title: iOS 贝赛尔曲线(BezierPath)常用方法研究
<!-- date: 2017-12-12 15:42:00 -->
categories: object-c
tags: iOS, 贝塞尔曲线, BezierPath
description:

----

UIBezierPath这个类在UIKit中， 是Core Graphics框架关于path的一个封装，使用此类可以定义简单的形状，比如我们常用到，矩形，圆形，椭圆，弧，或者不规则的多边形

---

<!-- more -->

* [目录](#)
	[贝塞尔曲线可以做到哪些？](#贝塞尔曲线可以做到哪些？)
	[贝塞尔曲线是怎么画出来的？](#贝塞尔曲线是怎么画出来的？)
    [常用设置介绍说明](#常用设置介绍说明)
	[画图形](#画图形)
    [BezierPath动画](#BezierPath动画)
    [了解一下底层的CoreGraphics](#了解一下底层的CoreGraphics)
    [通过shapeLayer画线](#通过shapeLayer画线)




# 贝塞尔曲线可以做到哪些？

1.画图形
2.做动画


# 贝塞尔曲线是怎么画出来的？

首先，我们在平面内选3个不同线的点并且依次用线段连接。如下所示..

![image](img/56030-48977fcfcd8cd57e.png)

接着，我们在AB和BC线段上找出点D和点E，使得AD/AB = BE/BC。

![image](/img/56030-5d3e252f34e657c9.jpg)

再接着，连接DE，并在DE上找出一点F，使得DF/DE = AD/AB = BE/BC。

![image](/img/56030-5175f6c03d4990b2.jpg)

然后，根据我们高中所学的极限的知识，让选取的点D在第一条线段上从起点A，移动到终点B，找出所有点F，并将它们连起来。最后你会发现，你得到了一条非常光滑的曲线，这条就是传说中的，贝塞尔曲线。

这是二阶贝塞尔曲线。

![image](/img/56030-bb6b8c6a46f12135.gif)

下面是三阶四阶和五阶。

![image](/img/56030-56030-f3e69b487f4e37c8.gif)

![image](/img/56030-2d2fb8989e10f177.gif)

![image](/img/56030-390b7b874ddd5d3d.gif)


最后看一下一阶

![image](/img/56030-b65e3dd8196f4da5.gif)

所以贝塞尔曲线的厉害之处就在这里，从1-n阶的连续函数，他都可以计算得到一条光滑曲线。


# 常用设置介绍说明

1、[color set];设置线条颜色，也就是相当于画笔颜色

2、path.lineWidth = 5.0;这个很好理解了，就是划线的宽度

3、path.lineCapStyle这个线段起点是终点的样式，这个样式有三种：

* 1、kCGLineCapButt该属性值指定不绘制端点， 线条结尾处直接结束。这是默认值。
* 2、kCGLineCapRound 该属性值指定绘制圆形端点， 线条结尾处绘制一个直径为线条宽度的半圆。
* 3、kCGLineCapSquare 该属性值指定绘制方形端点。 线条结尾处绘制半个边长为线条宽度的正方形。需要说明的是，这种形状的端点与“butt”形状的端点十分相似，只是采用这种形式的端点的线条略长一点而已


4、path.lineJoinStyle这个属性是用来设置两条线连结点的样式，同样它也有三种样式供我们选择

* 1、kCGLineJoinMiter 斜接
* 2、kCGLineJoinRound 圆滑衔接
* 3、kCGLineJoinBevel 斜角连接

5、[path stroke];用 stroke 得到的是不被填充的 view ，[path fill]; 用 fill 得到的内部被填充的 view，这点在下面的代码还有绘制得到的图片中有，可以体会一下这两者的不同。



# 画图形

### 画线

![image](/img/WX20171212-152501.png)

```base
// 画线
- (void)createTest0{
    UIColor *color = [UIColor redColor];
    [color set]; //设置线条颜色
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(10, 100)];
    [path addLineToPoint:CGPointMake(200, 250)];
    
    [path addLineToPoint:CGPointMake(100, 350)];
    path.lineWidth = 4;
    path.lineCapStyle = kCGLineCapRound ;//kCGLineCapRound; //线条拐角
    path.lineJoinStyle = kCGLineCapRound;  //终点处理
    
    [path stroke];
//    [path fill];
}
```

### 五边形
![image](/img/WX20171212-152805.png)

```base
// 五边形
- (void)createTest1{
    UIColor *color = [UIColor redColor];
    [color set]; //设置线条颜色

    UIBezierPath *path = [UIBezierPath bezierPath];
    path.lineWidth = 5;
    
    path.lineJoinStyle = kCGLineJoinRound;
    path.lineCapStyle = kCGLineCapRound;
    
    [path moveToPoint:CGPointMake(200, 50)];
    
    [path addLineToPoint:CGPointMake(300, 100)];
    [path addLineToPoint:CGPointMake(260, 200)];
    [path addLineToPoint:CGPointMake(100, 200)];
    [path addLineToPoint:CGPointMake(100, 70)];
    
    [path closePath];
    
    [path stroke];
//    [path fill];
    
}
```

### 正方形或者矩形

![image](/img/WX20171212-152956.png)


```
// 正方形或者矩形
- (void)createTest2{
    UIColor *color = [UIColor redColor];
    [color set]; //设置线条颜色

    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(20, 20, 200, 200)];
    path.lineWidth = 5;
    path.lineJoinStyle = kCGLineJoinRound;
    path.lineCapStyle = kCGLineCapRound;
    
    [path stroke];
}
```


### 椭圆或者圆

![image](/img/WX20171212-153438.png)

```base
// 椭圆或者圆
- (void)createTest3{
    UIColor *color = [UIColor redColor];
    [color set]; //设置线条颜色

    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(20, 40, 300, 200)];
    path.lineWidth = 5;
    path.lineJoinStyle = kCGLineJoinRound;
    path.lineCapStyle = kCGLineCapRound;
    [path stroke];
}

```

### 矩形四角圆角

![image](/img/WX20171212-153537.png)

```base
// 矩形四角圆角
- (void)createTest4{
    UIColor *color = [UIColor redColor];
    [color set];
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(20, 20, 200, 200) cornerRadius:50];
    [path fill];
}
```

### 四个角里右上和左下圆角

![image](/img/WX20171212-153737.png)

```base
// 四个角里右上和左下圆角
- (void)createTest5{
    UIColor *color = [UIColor redColor];
    [color set];
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(20, 20, 200, 200) byRoundingCorners:UIRectCornerTopRight|UIRectCornerBottomLeft cornerRadii:CGSizeMake(50, 50)];
    
    [path fill];
}
```

### 顺时针或者逆时针画线

![image](/img/WX20171212-153917.png)

```base
// 顺时针或者逆时针画线
- (void)createTest6{
    UIColor *color = [UIColor redColor];
    [color set];

    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(200, 200) radius:50 startAngle:M_PI_2 endAngle:M_PI*2 clockwise:YES];
    path.lineWidth = 10;

    [path stroke];
    
}
```

### 绘制二次贝塞尔曲线

![image](/img/WX20171212-154002.png)

```base
// 绘制二次贝塞尔曲线
- (void)createTest7{
    UIColor *color = [UIColor redColor];
    [color set];

    UIBezierPath *path = [UIBezierPath bezierPath];
    
    path.lineWidth = 5;
    
    [path moveToPoint:CGPointMake(20, 200)];
    
    [path addQuadCurveToPoint:CGPointMake(20+40*1, 200) controlPoint:CGPointMake(40*1, 0)];
    
    [path addQuadCurveToPoint:CGPointMake(20+40*2, 200) controlPoint:CGPointMake(40*2, 0)];

    [path addQuadCurveToPoint:CGPointMake(20+40*3, 200) controlPoint:CGPointMake(40*3, 0)];

    [path addQuadCurveToPoint:CGPointMake(20+40*4, 200) controlPoint:CGPointMake(40*4, 0)];

//    [path addQuadCurveToPoint:CGPointMake(200, 200) controlPoint:CGPointMake(180*3/2., 180*1/5.)];
    
//    [path stroke];
    [path fill];
}

```

### 绘制三次贝塞尔曲线

![image](/img/WX20171212-154104.png)

```base
//绘制三次贝塞尔曲线
- (void)createTest8{
    UIColor *color = [UIColor redColor];
    [color set];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    path.lineWidth = 5;

    [path moveToPoint:CGPointMake(20, 200)];
    [path addCurveToPoint:CGPointMake(130, 200) controlPoint1:CGPointMake(75, 0) controlPoint2:CGPointMake(75, 400)];
    [path addCurveToPoint:CGPointMake(260, 200) controlPoint1:CGPointMake(195, 0) controlPoint2:CGPointMake(195, 400)];

    [path fill];
    
}

```


# BezierPath动画

![image](/img/bezierpathAnimation.gif)



```base

 /*
     这个属性用以指定时间函数，类似于运动的加速度
     kCAMediaTimingFunctionLinear//线性
     kCAMediaTimingFunctionEaseIn//淡入
     kCAMediaTimingFunctionEaseOut//淡出
     kCAMediaTimingFunctionEaseInEaseOut//淡入淡出
     kCAMediaTimingFunctionDefault//默认

    kCAFillModeForwards
    fillMode的作用就是决定当前对象过了非active时间段的行为. 比如动画开始之前,动画结束之后。如果是一个动画CAAnimation,则需要将其removedOnCompletion设置为NO,要不然fillMode不起作用.
     
     下面来讲各个fillMode的意义
     kCAFillModeRemoved 这个是默认值,也就是说当动画开始前和动画结束后,动画对layer都没有影响,动画结束后,layer会恢复到之前的状态
     kCAFillModeForwards 当动画结束后,layer会一直保持着动画最后的状态
     kCAFillModeBackwards 这个和kCAFillModeForwards是相对的,就是在动画开始前,你只要将动画加入了一个layer,layer便立即进入动画的初始状态并等待动画开始.你可以这样设定测试代码,将一个动画加入一个layer的时候延迟5秒执行.然后就会发现在动画没有开始的时候,只要动画被加入了layer,layer便处于动画初始状态
     kCAFillModeBoth 理解了上面两个,这个就很好理解了,这个其实就是上面两个的合成.动画加入后开始之前,layer便处于动画初始状态,动画结束后layer保持动画最后的状态.

     kCAAnimationPaced
     在关键帧动画中还有一个非常重要的参数,那便是calculationMode,计算模式.该属性决定了物体在每个子路径下是跳着走还是匀速走，跟timeFunctions属性有点类似
     其主要针对的是每一帧的内容为一个座标点的情况,也就是对anchorPoint 和 position 进行的动画.当在平面座标系中有多个离散的点的时候,可以是离散的,也可以直线相连后进行插值计算,也可以使用圆滑的曲线将他们相连后进行插值计算. calculationMode目前提供如下几种模式
     
     kCAAnimationLinear calculationMode的默认值,表示当关键帧为座标点的时候,关键帧之间直接直线相连进行插值计算;
     kCAAnimationDiscrete 离散的,就是不进行插值计算,所有关键帧直接逐个进行显示;
     kCAAnimationPaced 使得动画均匀进行,而不是按keyTimes设置的或者按关键帧平分时间,此时keyTimes和timingFunctions无效;
     kCAAnimationCubic 对关键帧为座标点的关键帧进行圆滑曲线相连后插值计算,对于曲线的形状还可以通过tensionValues,continuityValues,biasValues来进行调整自定义,这里的数学原理是Kochanek–Bartels spline,这里的主要目的是使得运行的轨迹变得圆滑;
     kCAAnimationCubicPaced 看这个名字就知道和kCAAnimationCubic有一定联系,其实就是在kCAAnimationCubic的基础上使得动画运行变得均匀,就是系统时间内运动的距离相同,此时keyTimes以及timingFunctions也是无效的.


     */


// 贝塞尔曲线动画
- (void)createTest12{
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(100, 200)];
    [path addCurveToPoint:CGPointMake(400, 200) controlPoint1:CGPointMake(200, 0) controlPoint2:CGPointMake(300, 400)];
    
    CAKeyframeAnimation *keyFA = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    keyFA.duration = 8;
    keyFA.repeatCount = 10;
    keyFA.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    keyFA.path = path.CGPath;
    keyFA.calculationMode = kCAAnimationPaced;
    //旋转的模式,auto就是沿着切线方向动，autoReverse就是转180度沿着切线动
    keyFA.rotationMode = kCAAnimationRotateAuto;
    //结束后是否移除动画
    keyFA.removedOnCompletion = NO;
    
    //添加动画
    [self.redView.layer addAnimation:keyFA forKey:@""];
}

- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    
    UIColor *color = [UIColor redColor];
    [color set];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(100, 200)];
    path.lineWidth = 3;
    path.lineJoinStyle = kCGLineJoinRound;
    path.lineCapStyle = kCGLineCapRound;
    [path addCurveToPoint:CGPointMake(400, 200) controlPoint1:CGPointMake(200, 0) controlPoint2:CGPointMake(300, 400)];
    [path stroke];

}

```

# 了解一下底层的CoreGraphics

简单易懂的介绍博客

[http://www.mamicode.com/info-detail-841887.html](http://www.mamicode.com/info-detail-841887.html)

下面介绍了怎样给BezierPath赋值CGPath，我看有点用，直接把代码拿来了。

```base

-(void)drawRect:(CGRect)rect  
{  
    // Create the path data  
    //创建路径时间  
    CGMutablePathRef cgPath = CGPathCreateMutable();  
    
    //cgPath的画图接口  
    //给一个cgPath里面添加了多个样式，圆和椭圆会发生关联  
      
    //两个椭圆互不影响  
    CGPathAddEllipseInRect(cgPath, NULL, CGRectMake(100, 100, 50, 100));  
      
    CGPathAddEllipseInRect(cgPath, NULL, CGRectMake(250, 250, 100, 50));  
      
    //矩形  
    CGPathAddRect(cgPath, NULL, CGRectMake(200, 500, 30, 100));        
//    圆形  
//    CGPathAddArc(cgPath, NULL, 120, 400, 100, 0, M_PI*2, YES);  
      
    //下面两句要搭配，先有起点  
    CGPathMoveToPoint(cgPath, NULL, 200, 300);  
    //加一段弧  
    CGPathAddArcToPoint(cgPath, NULL, 320, 250, DEGREES_TO_RADIANS(150), M_PI*2, 50);  
  
              
    //把CGPath赋给贝塞尔曲线  
    UIBezierPath* aPath = [UIBezierPath bezierPath];  
      
    aPath.CGPath = cgPath;  
      
    aPath.usesEvenOddFillRule = YES;  
      
   //并不在ARC的管理范围之内。所以需要手动释放对象，释放cgPath  
    CGPathRelease(cgPath);  
      
    //划线  
    [[UIColor redColor]setStroke];  
    [aPath setLineWidth:5];  
    [aPath stroke];  
}

```

# 通过shapeLayer画线

这样就不用去UIView的drawRect方法里面画图了,用法“给CAShapeLayer赋值 CGPath”。

```base
//ShapeLayer  
-(void)createTest10 
{  
    //贝塞尔画圆  
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(100, 100) radius:100 startAngle:0 endAngle:M_PI clockwise:NO];  
      
    //初始化shapeLayer  
    self.myShapeLayer = [CAShapeLayer layer];  
    _myShapeLayer.frame = _redView.bounds;  
  
    _myShapeLayer.strokeColor = [UIColor greenColor].CGColor;//边沿线色   
    _myShapeLayer.fillColor = [UIColor grayColor].CGColor;//填充色  
      
    _myShapeLayer.lineJoin = kCALineJoinMiter;//线拐点的类型  
    _myShapeLayer.lineCap = kCALineCapSquare;//线终点  
            
    //从贝塞尔曲线获得形状  
    _myShapeLayer.path = path.CGPath;  
      
    //线条宽度  
    _myShapeLayer.lineWidth = 10;  
      
    //起始和终止  
    _myShapeLayer.strokeStart = 0.0;  
    _myShapeLayer.strokeEnd = 1.0;  
            
    //将layer添加进图层  
    [self.redView.layer addSublayer:_myShapeLayer];          
}

```

下面是我调试时的demo：[https://github.com/iOdeFog/BezierPathDemo](https://github.com/iOdeFog/BezierPathDemo)


参考:
[http://cdn2.jianshu.io/p/c883fbf52681](http://cdn2.jianshu.io/p/c883fbf52681)
[http://www.jianshu.com/p/5dbdd1ee47aa](http://www.jianshu.com/p/5dbdd1ee47aa)
