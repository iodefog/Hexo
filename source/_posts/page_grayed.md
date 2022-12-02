title: 页面置灰


-------------------

# 背景

一般在清明节、全国哀悼日、大地震的日子，以及一些影响力很大的伟人逝世或纪念日的时候，很多网站和App都会让自己的网站的全部网页变成灰色（黑白色），以表示我们对逝者的悼念。

那么今天就说说，通过几行简单的代码，来实现这个功能。


# 实现方案

## 一、Web端置灰
第一种：修改CSS文件
我们可以在网页的CSS文件中添加以下的CSS代码，来实现网页黑白色，也就是网站变灰

CSS代码

``` html
html {
    filter: progid:DXImageTransform.Microsoft.BasicImage(grayscale=1);
    -webkit-filter: grayscale(100%);
}
```

第二种：在网页的<head>标签内加入以下代码
如果你不想改动CSS文件，你可以通过在网页头部中的<head>标签内部加入内联CSS代码的形式实现网站网页变灰

```
<style type="text/css">
html {
filter: progid:DXImageTransform.Microsoft.BasicImage(grayscale=1);
-webkit-filter: grayscale(100%);}
</style>
```

第三种：修改<html>标签加入内联样式
如里上面的两种方式都不喜欢，可以通过修改<html>标签，以加入内联样式的方法，达到网页变灰的效果

``` 
<html style="filter: progid:DXImageTransform.Microsoft.BasicImage(grayscale=1);
-webkit-filter: grayscale(100%);">
```

第四种：作者本人用的CSS代码

``` html
body *{
-webkit-filter: grayscale(100%); /* webkit */
-moz-filter: grayscale(100%); /*firefox*/
-ms-filter: grayscale(100%); /*ie9*/
-o-filter: grayscale(100%); /*opera*/
filter: grayscale(100%);
filter:progid:DXImageTransform.Microsoft.BasicImage(grayscale=1); 
filter:gray; /*ie9- */
}
```
PS：以上几种方法，都是通过CSS的滤镜来控制页面的显示而已，唯一不同的就CSS代码调用的方式。各位，喜欢哪种就自己挖去吧！

参考：[https://www.feiniaomy.com/post/243.html](https://www.feiniaomy.com/post/243.html)

## 二、iOS端置灰

### 方法一：分别将图片和文字置灰

一般情况下，App页面的颜色深度是24bit，也就是RGB各8bit；如果算上Alpha通道的话就是32bit，RGBA(或者ARGB)各8bit。灰度图像的颜色深度是8bit，这8bit表示的颜色不是彩色，而是256种不同亮度的黑色或白色。
说到灰度图像，在YUV颜色空间上—其中Y代表亮度，调整Y值就可以得到不同的灰度图像。

理论上，颜色空间RGB和YUV是等价的，同一种颜色用RGB或YUV都可以表示。从RGB数值对应到亮度Y，一般采用公式Y **= 0.299R+0.587G+0.114B**，得到的结果再填充到RGB上就得到了对应的灰度RGB颜色。

```
Y = 0.299R+0.587G+0.114B
Gray = RGB(Y,Y,Y)
```

以上是方法一App页面置灰的原理基础。

UIImage转成灰度图
核心是创建一个灰度空间，然后将图像绘制到这个空间上

```
－(UIImage*)getGrayImage:(UIImage*)sourceImage 
{ 
   int width = sourceImage.size.width; 
   int height = sourceImage.size.height; 

   // 创建灰度空间
   CGColorSpaceRef colorSpace =CGColorSpaceCreateDeviceGray(); 
   // 创建绘制上下文
   CGContextRef context =CGBitmapContextCreate(nil,width,height,8,0,colorSpace,kCGImageAlphaNone); 
   CGColorSpaceRelease(colorSpace); 

   if(context== NULL){ 
       return nil; 
   }

   // 绘制原始图像到新的上下文（灰度）
   CGContextDrawImage(context,CGRectMake(0,0, width, height), sourceImage.CGImage); 
   // 获取灰度图像
   CGImageRef grayImageRef =CGBitmapContextCreateImage(context);
   // CGImage -> UIImage
   UIImage*grayImage=[UIImage imageWithCGImage:grayImageRef];
   //回收资源
   CGContextRelease(context);
   CGImageRelease(grayImageRef);

   return grayImage; 
}
```

UIColor转成灰度颜色

比较简单了，使用公式就可以了**Y = 0.299R+0.587G+0.114B
**

```
UIColor *color = xxxx;
CGFloat r,g,b,a;
[color getRed:&r green:&g> blue:&b alpha:&a];
CGFloat y = 0.299*r+0.587*g+0.114*b;
UIColor *gray = [UIColor colorWithRed:y green:y blue:y alpha:a]
```

以上方案开始执行，结果：卡，一个字，卡。毕竟涉及到大量的主线程图片重新生成，cpu/内存抖动，特别是列表上，性能消耗太厉害了。观察实际图片使用情况：本地资源大量重复使用，远端大图列表中复用。两大性能消耗点，因此明显都可以通过缓存解决。

### 方法二：给App整体添加灰色滤镜

这个方法可以是App整体置灰，包括WebView页面。
原理就是把App页面当成一副图像，使用另一副偏灰图像和这个图像进行叠加运算，从而得到新的图像。
iOS 提供了Core Image 滤镜，这些滤镜可以设置在UIView.layer上。
我们要做的就是选取合适的滤镜，并将滤镜放置到App的最顶层

```
// 最顶层视图，承载滤镜，自身不接收、不拦截任何触摸事件
@interface UIViewOverLay : UIView
@end

@implementation UIViewOverLay
-(UIView*)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    return nil;
}
@end

UIWindow *window = App的Window;
UIViewOverLay *overlay = [[UIViewOverLay alloc]initWithFrame:self.window.bounds];
overlay.translatesAutoresizingMaskIntoConstraints = false;
overlay.backgroundColor = [UIColor lightGrayColor];
overlay.layer.compositingFilter = @"saturationBlendMode";
[window addSubview:overlay];
```

最后通过各种方法，要保证overlay在最顶层.COPY
上面使用的是UIView承载滤镜，其实看代码就知道了也可以直接使用CALayer来承载滤镜（需要注意的是在UIWindow上直接添加CALayer时，在某些特殊的场景可能会造成绘制异常）

### 方法三: 给App整体添加灰色滤镜（私有API）
灵感来自UIVisualEffectView这个公开的API。既然这个类能够实现App任意页面的毛玻璃效果–一个基于高斯模糊的滤镜，那么必然可以仿照这个类实现其他滤镜效果。于是找到了CAFilter这个私有API，示意代码如下

```
    //获取RGBA颜色数值
    CGFloat r,g,b,a;
    [[UIColor lightGrayColor] getRed:&r green:&g blue:&b alpha:&a];
    //创建滤镜
    id cls = NSClassFromString(@"CAFilter");
    id filter = [cls filterWithName:@"colorMonochrome"];
    //设置滤镜参数
    [filter setValue:@[@(r),@(g),@(b),@(a)] forKey:@"inputColor"];
    [filter setValue:@(0) forKey:@"inputBias"];
    [filter setValue:@(1) forKey:@"inputAmount"];
    //设置给window
    window.layer.filters = [NSArray arrayWithObject:filter];
```

几个关键点：

- compositingFilter作用与layer背景，而blendmode本身作用于图层与其下方的内容。因此实际方案是在vc或者window上放置一个overlay view，只设置background去完成遮罩置灰。

- 别忘了userInteractionEnabled去完成overlay view的事件穿透。

- 调整backgroundColor与compositingFilter完成灰度计算逻辑，可以多试试寻找最佳效果。

- 这个方案会导致整体离屏渲染，注意性能。


参考：

1. [https://lrdcq.com/me/read.php/105.htm](https://lrdcq.com/me/read.php/105.htm)
2. [https://blog.z6z8.cn/2021/12/14/ios-app页面置灰实现](https://blog.z6z8.cn/2021/12/14/ios-app%E9%A1%B5%E9%9D%A2%E7%BD%AE%E7%81%B0%E5%AE%9E%E7%8E%B0/)

## 三、Android端置灰

### 方案1.Android页面绘制流程一般分为measure、layout、draw，页面置灰在draw方法中实现。

draw方法参数有canvas、paint，canvas是界面的画布，paint是绘制界面的画笔。可以通过更改paint的属性更改界面背景颜色，通过设置颜色过滤器更改画笔的色调、饱和度和亮度。置灰效果饱和度为0，画笔的设置代码：

```
Paint  paint = new  Paint();
ColorMatrix cm = new  ColorMatrix();
cm.setStaturation(0);
paint.setColorFilter(new ColorMatrixColorFilter(cm));
```

### 方案2.考虑性能使用HardwareLayer(GPU内部的Buffer)对绘制的图形进行缓存。设置方法setLayerType()强制View创建自己对应的层，并将自己绘制到层上。

### 方案3.给Activity的顶层View设置置灰，实现全局置灰效果。获取界面的根View：

```
//java
View view  = activity. getWindow(). getDecorView();
 Paint paint = new  Paint();
ColorMatrix cm = new  ColorMatrix();
cm.setStaturation(0);
paint.setColorFilter(new ColorMatrixColorFilter(cm));
view. setLayerType(View.LAYER_TYPE_HARDWARE, paint);
```

```
//kotlin
val view: View = window.decorView
val paint = Paint()
val cm = ColorMatrix()
cm.setSaturation(0f)
paint.colorFilter = ColorMatrixColorFilter(cm)
view.setLayerType(View.LAYER_TYPE_HARDWARE, paint)
```

参考：[https://www.jianshu.com/p/340951afeb78](https://www.jianshu.com/p/340951afeb78)