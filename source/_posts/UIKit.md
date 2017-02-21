title: UIKit粒子系统教程
date: 2014-11-19 17:37:00
categories: 技术
tags: 
description:
---
#免责申明（必读！）：本博客提供的所有教程的翻译原稿均来自于互联网，仅供学习交流之用，切勿进行商业传播。同时，转载时不要移除本申明。如产生任何纠纷，均与本博客所有人、发表该翻译稿之人无任何关系。谢谢合作！
**
**
**原文地址：**[**http://www.raywenderlich.com/6063/uikit-particle-systems-in-ios-5-tutorial**](http://www.raywenderlich.com/6063/uikit-particle-systems-in-ios-5-tutorial)****
**
**
本文由糖炒小虾、[Benna翻译](http://www.cnblogs.com/benna/) ，校对：sai、u0u0、iven、子龙山人
**
**
**iOS 5中的UIKit粒子系统教程**
![](http://pic002.cnblogs.com/images/2012/283130/2012011012161663.jpg)
 
Ray的话：这是第15篇、也是最后一篇《[iOS 5 盛宴](http://www.raywenderlich.com/5113/announcing-the-ios-5-feast)》中的iOS 5教程！这篇教程来自我们的新书《[iOS
 5 教程](http://www.raywenderlich.com/store/ios-5-by-tutorials)》中的一篇免费预览章节。这个礼拜三我们将迎来《iOS 5 盛宴》系列的最后一次发布——来自史诗般的《iOS 5 盛宴》奉送，最后一次#ios5feast的广播！:]
    这是篇教程由iOS教程小组成员[Marin Todorov](http://www.raywenderlich.com/about#marintodorov)所撰写，他是一位拥有超过12年经验的软件开发者，一位iOS的独立开发者，同时他也是[Touch
 Code Magazine](http://www.touch-code-magazine.com/)的创立者。
    你可能已经看过一些粒子系统，它们被应用于很多iOS应用程序和游戏中，诸如爆炸、火特效、下雨或者下雪等。然而，你所看到的这些特效类型可能大部分出现在游戏之中，因为UIKit不提供内置的功能来创建粒子系统----直到iOS 5的出现，这种情况将有所改变，本教程将采用UIKit来制作粒子系统！
    现在，利用iOS 5你能直接在UIkit中使用粒子系统，给你的应用程序带来很多令人兴奋的视觉享受。这里有一些非常适用于使用粒子系统的例子：
-   UIKit 游戏：是的，你可以通过普通的UIKit制作游戏（有些游戏类型运作得相当好，尤其是棋牌类游戏）。现在，你可以用爆炸、烟雾等其他更引人的东西制作更好的游戏！
-   美化UI效果：当你的用户在界面上移动一个物体时，它能留下一条烟雾痕迹，为什么不做呢？
-  令人目眩的屏幕转场效果：何不在你的应用程序显现下一个场景时，让之前的场景消失在一个火球中？ 

    希望能用UIKit粒子系统做些什么，也许你已经有一些很酷的想法啦。那么，让我们开始吧！
    在这个教程中，我们将开发一个叫“Draw with fire”的应用程序，让你（你猜中了）在屏幕上绘制火焰。
    你将和我一起完成粒子系统的创建与设置来实现屏幕上看到的效果，让你能将你的想法一步步实现。当这个应用完成，你就能用它绘制一个用火焰标记的漂亮的问号，就像这个：
 
![](http://pic002.cnblogs.com/images/2012/283130/2012011012165579.jpg)
 
**新的粒子 API**
 
    有两个类在你创建粒子系统时将会需要使用，它们在QuartzCore框架中，名叫CAEmitterLayer和CAEmitterCell。
    通常的想法是你创建一个CAEmitterLayer，并将一个或多个CAEmitterCell添加到里面。接着每个单元（cell）会按它配置的样式产生粒子。
    而且CAEmitterLayer继承自CALayer，你能轻易地在UIKit分层的任何地方加入它！
    我想这个新的UIKit粒子系统最酷的是一个单独的CAEmitterLayer可以支持多个CAEmitterCell。这支持你完成一些相当复杂而且很酷的效果。例如当你创建泉水时，你能拥有一个cell发射水滴，另一个cell在泉水上发射水蒸汽！
 
**Getting Started**
 
    打开Xcode，并从主菜单中选择File\New\New Project，选择iOS\Application\Single View Application模版，点击Next，键入程序名“DrawWithFire”，再键入DWF为前缀，选择iPhone for Device Family，确认勾选“Use automatic reference counting”(其他选择框别选)。接着点击Next，再点击Create保存项目。
     选择你的项目，再选择DrawWithFire的target。接着打开Build Phases选项卡，展开Link Binary  With  Libraies部分，再点击“+”按钮，双击QuartzCore.framework，将Quartz绘图功能添加到项目里面。
     我们将创建一个自定义UIView类来开始项目，这个类将有CAEmitterLayer作为它的层。事实上，完成这些非常简单，通过重写UIView类的+(Class)layerClass方法并返回一个CAEmitter类。相当酷哦！
     创建一个新文件，采用iOS\Cocoa Touch\Objective-C类模板，类名为DWFParticleView，继承于UIView。
     打开DWFParticleView.m并替换为如下代码：
[![复制代码](http://common.cnblogs.com/images/copycode.gif)]( "复制代码")	#import "DWFParticleView.h"
	#import <QuartzCore/QuartzCore.h>
	 
	@implementation DWFParticleView
	{
	    CAEmitterLayer* fireEmitter; //1}
	 
	-(void)awakeFromNib
	{
	    //set ref to the layer    fireEmitter = (CAEmitterLayer*)self.layer; //2}
	 
	+ (Class) layerClass //3{
	    //configure the UIView to have emitter layer    return [CAEmitterLayer class];
	}
	 
	@end
[![复制代码](http://common.cnblogs.com/images/copycode.gif)]( "复制代码") 
让我们重温下初始代码：
- 我们创建一个单一的私有实例变量来控制CAEmitterLayer。
-  在awakeFromNib中，我们设置fireEmitter为这个视图的self.layer。我们将它存储在我们创建的fireEmitter实例变量中，因为之后我们将在这上面设置许多参数。
-  +(Class)layerClass是UIView的类方法，它告诉UIKit使用哪个类作为这个视图的根CALayer。想要更多关于CALayer的信息，请查看[CALayer教程介绍](http://www.raywenderlich.com/2502/introduction-to-calayers-tutorial)。

 
接下来，让我们将视图控制器的根视图转到DWFParticleView。打开DWFViewController.xib并实现如下步骤：
 
![](http://pic002.cnblogs.com/images/2012/283130/2012011012173327.jpg)
1、  确认Utilities工具条是可见的（在这张图上突出的按钮都改被按下）。
2、  选择Interface Builder中的灰色区域——这是这个视图控制器的根视图。
3、  点击Identity Inspector选项卡。
4、  在Custom Class面板，在文本框中输入DWFParticleView。
 
现在，我们已经将UI全都设置好——干得好！让我们在图中添加一些粒子。
 
**A Particle Examined**
 
为了发射火焰、烟雾、瀑布或者其他什么，你将需要一份好的PNG文件来启动你的粒子。你可以在任何图像编辑程序中自己制作它。看看我为这个教程制作的图片(它被放大了并置于黑色背景中，这样你才能看清楚它的形状)：
 
![](http://pic002.cnblogs.com/images/2012/283130/2012011012181033.png)
我的粒子文件大小是32*32像素，这是份透明的PNG文件，我仅使用有点时髦的笔刷，随意地用白色绘制而成。对粒子来说，最好的就是使用白色，因为粒子发射器可以用我们想要的颜色对提供的图像着色。让粒子图像呈半透明也是个很好的想法，如此粒子系统就能将粒子通过它们自己混合在一起（你可以通过少量不同的图像文件理解它如何工作）。
 
这样，你就能创建自己的粒子或者就使用[我制作的这个](http://www.raywenderlich.com/downloads/Particles_fire.png)，但是要确定它添加到你的Xcode项目中并命名为Particles_fire.png。
 
**让我们开始产生粒子吧！**
是时候添加代码让我们的CAEmitterLayer做一些神奇的事情啦！
打开DWFParticleView.m 将如下代码添加到awakeFromNib:中
	//configure the emitter layerfireEmitter.emitterPosition = CGPointMake(50, 50);
	fireEmitter.emitterSize = CGSizeMake(10, 10);
 
上面的代码是用来设置emitter的坐标(view的坐标系下) 和生成粒子的大小的。
然后，在awakeFromNib后面添加一个CAEmitterCell到CAEmitterLayer上,让我们最终能在屏幕上看到粒子效果
[![复制代码](http://common.cnblogs.com/images/copycode.gif)]( "复制代码")	CAEmitterCell* fire = [CAEmitterCell emitterCell];
	fire.birthRate = 200;
	fire.lifetime = 3.0;
	fire.lifetimeRange = 0.5;
	fire.color = [[UIColor colorWithRed:0.8 green:0.4 blue:0.2 alpha:0.1] 
	  CGColor];
	fire.contents = (id)[[UIImage imageNamed:@"Particles_fire.png"] CGImage];
	[fire setName:@"fire"];
	 
	//add the cell to the layer and we're donefireEmitter.emitterCells = [NSArray arrayWithObject:fire];
[![复制代码](http://common.cnblogs.com/images/copycode.gif)]( "复制代码")
 我们生成了一个cell实例，并设置了一些属性。然后设置CAEmitterLayer中emitterCells的属性---一个包含cells的NSArray数组。现在emitterCell们已经设置好了，CAEmitterLayer准备好发射粒子了！
刚才设置了很多CAEmitterCell的属性，让我们一一过下
- **Birthrate(出生率)**：每秒发射的粒子数量，一个好的火焰或者瀑布你最少需要几百个粒子，所以我们设置为200
- **lifetime(生命时间)**:一个粒子几秒后消失，我们设置为3.0
- **liftetimeRange(生命时间变化范围)**：你可以用这个东西使粒子的lifetime产生少许变化。粒子系统会随机在这个区间中取一个lifetime出来(lifetime – lifetimeRange, lifetime + lifetimeRange) 在我们的程序中，粒子会存活2.5~3.5秒
- **Color(颜色)**：粒子内容的颜色，我们这里选择橙色
- **Contents(内容)**:用于cell的内容，一般是一个CGImage. 我们把它赋值给粒子图像。
- **Name(名称)**:你可以给你的cell取一个名字，用来在之后的时间里查找和修改它的属性。

运行程序，来测试一下我们的粒子效果！
 
![](http://pic002.cnblogs.com/images/2012/283130/2012011012183542.jpg)
好吧，它工作了，但是并不像我们想象的那么酷。你甚至可以毫不掩饰的承认，它看起来像一个橘黄色的斑点。
让我们做一些小改动使粒子变得更具有动感。把这些代码添加到setName: on the cell前面
	fire.velocity = 10;
	fire.velocityRange = 20;
	fire.emissionRange = M_PI_2;***   ***
- ** velocity(速度)**: 粒子每秒移动的像素数. 这里我们让cell发射的粒子向屏幕的右边沿移动这里我们设置如下的新属性在CAEimtterCell中：

- **velocityRange(速度范围)**: 速度变化范围，和lifetimeRange相似
- **emissionRange(发射角度)**:这是一个cell发射的角度范围(弧度制).M_PI_2(pi/2)是45度(也就是说生成范围会+-45度)

（编译并运行来）检查一下我们的成果
 
![](http://pic002.cnblogs.com/images/2012/283130/2012011012185734.jpg)
这次看起来好点，距离我们的目标不远了！如果你想把这些属性是如何影响粒子发生器理解的更透彻，那就去自由发挥吧，修改属性值看效果。
再添加两行，来结束cell的设置
	fire.scaleSpeed = 0.3;
	fire.spin = 0.5;***     ***
- **ScaleSpeed(变大速度)**：每秒修改粒子大小的百分比。我们设置0.3让粒子随着时间则推移变大 这里我们设置如下的新属性在CAEimtterCell中

- **Spin(旋转):**每个粒子的旋转速率。我们设置0.5来给粒子一个漂亮的旋转

再次运行：
 
![](http://pic002.cnblogs.com/images/2012/283130/2012011012191939.jpg)
     现在看起来有点像铁锈色的烟，这是为什么呢？CAEmitterCell有很多属性来调整，天空类型在这里受限制。在设置fireEmitter.emitterSize后面加这么一句话
	fireEmitter.renderMode = kCAEmitterLayerAdditive;

      这一行代码用于让我们铁锈色的烟变成沸腾的火球，运行来查看效果
![](http://pic002.cnblogs.com/images/2012/283130/2012011012194237.jpg)
    发生了什么？递增渲染模式(additive render mode)基本上是告诉系统不要用普通的方式——一个盖住一个的绘制粒子，而是换了一种更酷的方法：如果粒子相互重叠的话他们的颜色强度会增加！所以，你会在粒子发生器的区域里面看到大量的白色亮斑，但在区域外是火球，那里因为粒子不断消亡而数量减少，色彩渐变到原来的铁锈色。太棒了！
     你现在可能会觉得火焰非常不真实。的确，你可以通过修改cell的属性让火焰的效果更好。但是我们需要这么厚的效果，因为我们要去绘制它。当你在设备屏幕上拖动手指的时候，屏幕上会收到相对少的触摸点，所以我们用厚重的火球来补偿他。
 
**玩儿火吧！**
**
**
    现在，你终于可以玩火了（在现实生活中我们被告知永远不要玩火）:]
    下面来实现用手指在屏幕上画火焰，我们需要通过用户触摸点来修改粒子发生器的位置
    首先在DWFParticleView.h中声明一个方法:
	-(void)setEmitterPositionFromTouch: (UITouch*)t;

然后在DWFParticleView.m中实现它
	-(void)setEmitterPositionFromTouch: (UITouch*)t
	{
	    //change the emitter's position    fireEmitter.emitterPosition = [t locationInView:self];
	}
 
     这个方法获得一个触摸点并作为实参， 将触摸点信息转移到ParticleView的坐标系中，并修改粒子发生器的坐标
我们需要在view controller中控制它，所以我们下一步是在viewController中定义接口
[![复制代码](http://common.cnblogs.com/images/copycode.gif)]( "复制代码")	#import <UIKit/UIKit.h>
	#import "DWFParticleView.h"
	 
	@interface DWFViewController : UIViewController
	{
	    IBOutlet DWFParticleView* fireView;
	}
	@end
[![复制代码](http://common.cnblogs.com/images/copycode.gif)]( "复制代码")
之后打开DWFViewController.xib 然后按住control从File’s Owner向root view拖动，在弹出的选项卡中选择fireView正如你所见，我们import了我们的自定义view类，并且在DWFParticleView中定义了实例变量。
 
![](http://pic002.cnblogs.com/images/2012/283130/2012011012201749.jpg)
现在我们能通过view controller 访问emitter 层。打开DWFViewController.m 删掉所有自动生成的代码，添加如下代码
	- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	    [fireView setEmitterPositionFromTouch: [touches anyObject]];
	}

试着用更快或者更慢的速度拖动它，来看对粒子产生所造成的影响运行，触摸并向四周拖动，你会看到粒子发生器跟着移动并留下一串很酷的火焰
 
![](http://pic002.cnblogs.com/images/2012/283130/2012011012204296.jpg)
**动态修改Cell**
今天最后的话题是在emitter 层动态的改动cell们。现在，粒子发生器一直在产生粒子。没能给用户一种是他们画上去的感觉,让我们来将粒子发生的条件改为仅当手指触摸到屏幕的时候产生粒子.那么一开始就不要产生了，于是将DWFParticleView.m的awakeFromNib method方法中 粒子的birthrate设为0
	fire.birthRate = 0;

如果你现在运行的话，会发现屏幕空空如也，很好！下面添加一个方法来作为粒子发生（发射）器的开关。首先在DWFParticeView的头文件中定义如下方法
	-(void)setIsEmitting:(BOOL)isEmitting;
 
然后在DWFParticleView.m实现它
	-(void)setIsEmitting:(BOOL)isEmitting
	{
	    //turn on/off the emitting of particles    [fireEmitter setValue:[NSNumber numberWithInt:isEmitting?200:0] 
	      forKeyPath:@"emitterCells.fire.birthRate"];
	}

 这里使用setValue:forKeyPath:方法来改动一个cell, 是因为我们早先将cell的名字添加到了emitter中。我们使用”emitterCells.fire.birthRate”做keypath是因为birthRate是emitterCells数组中一个叫做叫fire的cells的属性。
最后我们需要在触摸开始的时候打开粒子发生器的开关，在抬起手指的时候关掉它。在DWFViewController
中添加如下代码
[![复制代码](http://common.cnblogs.com/images/copycode.gif)]( "复制代码")	 
	- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	    [fireView setEmitterPositionFromTouch: [touches anyObject]];
	    [fireView setIsEmitting:YES];
	}
	 
	- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	    [fireView setIsEmitting:NO];
	}
	 
	- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
	    [fireView setIsEmitting:NO];
	}
[![复制代码](http://common.cnblogs.com/images/copycode.gif)]( "复制代码")

完成并运行~观察效果咯~记住，你在玩儿火:-）
![](http://pic002.cnblogs.com/images/2012/283130/2012011012210839.jpg)
 
**Where To Go From Here?**
这里是样例[工程](http://www.raywenderlich.com/downloads/DrawWithFire.zip)的全部代码。
如果你喜欢这个教程，这里有更多你可以研究的东西。你可以
- 实验不同的粒子图片
- 去CAEmitterCell的官方文档中看看它全部的属性们
- 添加一个函数，将屏幕上的图片渲染保存到图片中
- 将绘制过程保存到视频文件中
- 在你的所有应用的文本框的后面添加燃烧的火焰作为背景。

 
