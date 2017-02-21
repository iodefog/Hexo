title: ReactiveCocoa入门教程——第一部分
date: 2015-08-17 16:02:00
categories: 技术
tags: 
description:
---

转载自：[http://benbeng.leanote.com/post/ReactiveCocoaTutorial-part1](http://benbeng.leanote.com/post/ReactiveCocoaTutorial-part1)本文翻译自RayWenderlich  [ReactiveCocoa
 Tutorial – The Definitive Introduction: Part 1/2](http://www.raywenderlich.com/62699/reactivecocoa-tutorial-pt1)

作为一个iOS开发者，你写的每一行代码几乎都是在响应某个事件，例如按钮的点击，收到网络消息，属性的变化（通过KVO）或者用户位置的变化（通过CoreLocation）。但是这些事件都用不同的方式来处理，比如action、delegate、KVO、callback等。[ReactiveCocoa](https://github.com/ReactiveCocoa/ReactiveCocoa)为事件定义了一个标准接口，从而可以使用一些基本工具来更容易的连接、过滤和组合。


如果你对上面说的还比较疑惑，那还是继续往下看吧。
 
ReactiveCocoa结合了几种编程风格：
函数式编程（[Functional
 Programming](http://en.wikipedia.org/wiki/Functional_programming)）：使用高阶函数，例如函数用其他函数作为参数。
响应式编程（[Reactive
 Programming](http://en.wikipedia.org/wiki/Reactive_programming)）：关注于数据流和变化传播。
 
所以，你可能听说过ReactiveCocoa被描述为函数响应式编程（FRP）框架。
 
这就是这篇教程要讲的内容。编程范式是个不错的主题，但是本篇教程的其余部分将会通过一个例子来实践。 
##Reactive Playground
通过这篇教程，一个简单的范例应用Reactive Playground ，你将会了解到响应式编程。下载[初始工程](http://cdn2.raywenderlich.com/wp-content/uploads/2014/01/ReactivePlayground-Starter.zip)，然后编译运行一下确保你已经把一切都设置正确了。
 
Reactive Playground是一个非常简单的应用，它为用户展示了一个登录页。在用户名框输入user，在密码框输入password，然后你就能看到有一只可爱小猫咪的欢迎页了。
![](http://cdn4.raywenderlich.com/wp-content/uploads/2014/01/ReactivePlaygroundStarter.jpg)
呀，真是可爱啊。


现在可以花一些时间来看一下初始工程的代码。很简单，用不了多少时间。


打开RWViewController.m看一下。你多快能找到控制登录按钮是否可用的条件？判断显示/隐藏登录失败label的条件是什么？在这个相对简单的例子里，可能只用一两分钟就能回答这些问题。但是对于更复杂的例子，这些所花的时间可能就比较多了。
 
使用ReactiveCocoa，可以使应用的基本逻辑变得相当简洁。是时候开始啦。
##添加ReactiveCocoa框架
添加ReactiveCocoa框架最简单的方法就是用[CocoaPods](http://cocoapods.org/)。如果你从没用过CocoaPods，那还是先去看看[CocoaPods简介](http://www.raywenderlich.com/?p=12139)这篇教程吧。请至少看完教程中初始化的步骤，这样你才能安装框架。
 
> 注意：如果不想用CocoaPods，你仍然可以使用ReactiveCocoa，具体查看Github文档中[引入ReactiveCocoa](https://github.com/ReactiveCocoa/ReactiveCocoa#importing-reactivecocoa)的步骤描述。
> 译注：我就是不喜欢用CocoaPods的那波人。所以我首先使用了Github上提供的方法，但是在第二步执行bootstrap时提示缺少xctool，我就果断放弃了，还是乖乖用CocoaPods吧。


具体怎么使用CocoaPods安装就不详细讲解了。 
##开动
就像在介绍中提到的，RAC为应用中发生的不同事件流提供了一个标准接口。在ReactiveCocoa术语中这个叫做信号（signal），由RACSignal类表示。
 
打开应用的初始view controller，RWViewController.m ，引入ReactiveCocoa的头文件。
	1. #import <ReactiveCocoa/ReactiveCocoa.h> 
	
	


不要替换已有的代码，将下面的代码添加到viewDidLoad方法的最后：
	1. [self.usernameTextField.rac_textSignal subscribeNext:^(id x){
	2.   NSLog(@"%@", x);
	3. }];
	
	
 
编译运行，在用户名输入框中输几个字。注意console的输出应该和下面的类似。
	1. 2013-12-24 14:48:50.359 RWReactivePlayground[9193:a0b] i
	2. 2013-12-24 14:48:50.436 RWReactivePlayground[9193:a0b] is
	3. 2013-12-24 14:48:50.541 RWReactivePlayground[9193:a0b] is 
	4. 2013-12-24 14:48:50.695 RWReactivePlayground[9193:a0b] is t
	5. 2013-12-24 14:48:50.831 RWReactivePlayground[9193:a0b] is th
	6. 2013-12-24 14:48:50.878 RWReactivePlayground[9193:a0b] is thi
	7. 2013-12-24 14:48:50.901 RWReactivePlayground[9193:a0b] is this
	8. 2013-12-24 14:48:51.009 RWReactivePlayground[9193:a0b] is this 
	9. 2013-12-24 14:48:51.142 RWReactivePlayground[9193:a0b] is this m
	10. 2013-12-24 14:48:51.236 RWReactivePlayground[9193:a0b] is this ma
	11. 2013-12-24 14:48:51.335 RWReactivePlayground[9193:a0b] is this mag
	12. 2013-12-24 14:48:51.439 RWReactivePlayground[9193:a0b] is this magi
	13. 2013-12-24 14:48:51.535 RWReactivePlayground[9193:a0b] is this magic
	14. 2013-12-24 14:48:51.774 RWReactivePlayground[9193:a0b] is this magic?
	
	


可以看到每次改变文本框中的文字，block中的代码都会执行。没有target-action，没有delegate，只有signal和block。令人激动不是吗？
 
ReactiveCocoa signal（RACSignal）发送事件流给它的subscriber。目前总共有三种类型的事件：next、error、completed。一个signal在因error终止或者完成前，可以发送任意数量的next事件。在本教程的第一部分，我们将会关注next事件。在第二部分，将会学习error和completed事件。
 
RACSignal有很多方法可以来订阅不同的事件类型。每个方法都需要至少一个block，当事件发生时就会执行block中的逻辑。在上面的例子中可以看到每次next事件发生时，subscribeNext:方法提供的block都会执行。
 
ReactiveCocoa框架使用category来为很多基本UIKit控件添加signal。这样你就能给控件添加订阅了，text field的rac_textSignal就是这么来的。
 
原理就说这么多，是时候开始让ReactiveCocoa干活了。
 
ReactiveCocoa有很多操作来控制事件流。假设你只关心超过3个字符长度的用户名，那么你可以使用filter操作来实现这个目的。把之前加在viewDidLoad中的代码更新成下面的：
	1. [[self.usernameTextField.rac_textSignal
	2. filter:^BOOL(id value){
	3.    NSString*text = value;
	4.    return text.length > 3;
	5. }]
	6. subscribeNext:^(id x){
	7.    NSLog(@"%@", x);
	8.   }];
	
	
 
编译运行，在text field只能怪输入几个字，你会发现只有当输入超过3个字符时才会有log。
	1. 2013-12-26 08:17:51.335 RWReactivePlayground[9654:a0b] is t
	2. 2013-12-26 08:17:51.478 RWReactivePlayground[9654:a0b] is th
	3. 2013-12-26 08:17:51.526 RWReactivePlayground[9654:a0b] is thi
	4. 2013-12-26 08:17:51.548 RWReactivePlayground[9654:a0b] is this
	5. 2013-12-26 08:17:51.676 RWReactivePlayground[9654:a0b] is this 
	6. 2013-12-26 08:17:51.798 RWReactivePlayground[9654:a0b] is this m
	7. 2013-12-26 08:17:51.926 RWReactivePlayground[9654:a0b] is this ma
	8. 2013-12-26 08:17:51.987 RWReactivePlayground[9654:a0b] is this mag
	9. 2013-12-26 08:17:52.141 RWReactivePlayground[9654:a0b] is this magi
	10. 2013-12-26 08:17:52.229 RWReactivePlayground[9654:a0b] is this magic
	11. 2013-12-26 08:17:52.486 RWReactivePlayground[9654:a0b] is this magic?
	
	
 
刚才所创建的只是一个很简单的管道。这就是响应式编程的本质，根据数据流来表达应用的功能。
 
用图形来表达就是下面这样的：
![](http://cdn4.raywenderlich.com/wp-content/uploads/2014/01/FilterPipeline.png)
从上面的图中可以看到，rac_textSignal是起始事件。然后数据通过一个filter，如果这个事件包含一个长度超过3的字符串，那么该事件就可以通过。管道的最后一步就是subscribeNext:，block在这里打印出事件的值。
 
filter操作的输出也是RACSignal，这点先放到一边。你可以像下面那样调整一下代码来展示每一步的操作。
	1. RACSignal *usernameSourceSignal =
	2.     self.usernameTextField.rac_textSignal;
	3.  
	4. RACSignal *filteredUsername =[usernameSourceSignal
	5.   filter:^BOOL(id value){
	6.     NSString*text = value;
	7.     return text.length > 3;
	8.   }];
	9.  
	10. [filteredUsername subscribeNext:^(id x){
	11.   NSLog(@"%@", x);
	12. }];
	
	
 
RACSignal的每个操作都会返回一个RACsignal，这在术语上叫做连贯接口（[fluent
 interface](http://en.wikipedia.org/wiki/Fluent_interface)）。这个功能可以让你直接构建管道，而不用每一步都使用本地变量。
 
> 注意：ReactiveCocoa大量使用block。如果你是block新手，你可能想看看Apple官方的[block编程指南](https://developer.apple.com/library/ios/documentation/cocoa/Conceptual/Blocks/Articles/00_Introduction.html)。如果你熟悉block，但是觉得block的语法有些奇怪和难记，你可能会想看看这个有趣又实用的网页[f*****gblocksyntax.com](http://fuckingblocksyntax.com/)。
##类型转换
如果你之前把代码分成了多个步骤，现在再把它改回来吧。。。。。。。。
	1. [[self.usernameTextField.rac_textSignal
	2.   filter:^BOOL(id value){
	3.     NSString*text = value; // implicit cast
	4.     return text.length > 3;
	5.   }]
	6.   subscribeNext:^(id x){
	7.     NSLog(@"%@", x);
	8.   }];
	
	
 
在上面的代码中，注释部分标记了将id隐式转换为NSString，这看起来不是很好看。幸运的是，传入block的值肯定是个NSString，所以你可以直接修改参数类型，把代码更新成下面的这样的：
	1. [[self.usernameTextField.rac_textSignal
	2.   filter:^BOOL(NSString*text){
	3.     return text.length > 3;
	4.   }]
	5.   subscribeNext:^(id x){
	6.     NSLog(@"%@", x);
	7.   }];
	
	


编译运行，确保没什么问题。
##什么是事件呢？
到目前为止，本篇教程已经描述了不同的事件类型，但是还没有说明这些事件的结构。有意思的是（？），事件可以包括任何事情。
 
下面来展示一下，在管道中添加另一个操作。把添加在viewDidLoad中的代码更新成下面的：
	1. [[[self.usernameTextField.rac_textSignal
	2.   map:^id(NSString*text){
	3.     return @(text.length);
	4.   }]
	5.   filter:^BOOL(NSNumber*length){
	6.     return[length integerValue] > 3;
	7.   }]
	8.   subscribeNext:^(id x){
	9.     NSLog(@"%@", x);
	10.   }];
	
	
 
编译运行，你会发现log输出变成了文本的长度而不是内容。
	1. 2013-12-26 12:06:54.566 RWReactivePlayground[10079:a0b] 4
	2. 2013-12-26 12:06:54.725 RWReactivePlayground[10079:a0b] 5
	3. 2013-12-26 12:06:54.853 RWReactivePlayground[10079:a0b] 6
	4. 2013-12-26 12:06:55.061 RWReactivePlayground[10079:a0b] 7
	5. 2013-12-26 12:06:55.197 RWReactivePlayground[10079:a0b] 8
	6. 2013-12-26 12:06:55.300 RWReactivePlayground[10079:a0b] 9
	7. 2013-12-26 12:06:55.462 RWReactivePlayground[10079:a0b] 10
	8. 2013-12-26 12:06:55.558 RWReactivePlayground[10079:a0b] 11
	9. 2013-12-26 12:06:55.646 RWReactivePlayground[10079:a0b] 12
	
	
 
新加的map操作通过block改变了事件的数据。map从上一个next事件接收数据，通过执行block把返回值传给下一个next事件。在上面的代码中，map以NSString为输入，取字符串的长度，返回一个NSNumber。
 
来看下面的图片：
![](http://cdn2.raywenderlich.com/wp-content/uploads/2014/01/FilterAndMapPipeline.png)


能看到map操作之后的步骤收到的都是NSNumber实例。你可以使用map操作来把接收的数据转换成想要的类型，只要它是个对象。
 
> 注意：在上面的例子中text.length返回一个NSUInteger，是一个基本类型。为了将它作为事件的内容，NSUInteger必须被封装。幸运的是[Objective-C
>  literal syntax](https://www.mikeash.com/pyblog/friday-qa-2012-06-22-objective-c-literals.html)提供了一种简单的方法来封装——@ (text.length)。
 
现在差不多是时候用所学的内容来更新一下ReactivePlayground应用了。你可以把之前的添加代码都删除了。。。。。。
##创建有效状态信号
首先要做的就是创建一些信号，来表示用户名和密码输入框中的输入内容是否有效。把下面的代码添加到RWViewController.m中viewDidLoad的最后面：
	1. RACSignal *validUsernameSignal =
	2.  [self.usernameTextField.rac_textSignal
	3.  map:^id(NSString *text) {
	4.  return @([self isValidUsername:text]);
	5.  }]; 
	6. RACSignal *validPasswordSignal =
	7.  [self.passwordTextField.rac_textSignal 
	8.  map:^id(NSString *text) { 
	9.  return @([self isValidPassword:text]);
	10.  }];
	
	


可以看到，上面的代码对每个输入框的rac_textSignal应用了一个map转换。输出是一个用NSNumber封装的布尔值。


下一步是转换这些信号，从而能为输入框设置不同的背景颜色。基本上就是，你订阅这些信号，然后用接收到的值来更新输入框的背景颜色。下面有一种方法：
	1. [[validPasswordSignal
	2.   map:^id(NSNumber *passwordValid){
	3.     return[passwordValid boolValue] ? [UIColor clearColor]:[UIColor yellowColor];
	4.   }]
	5.   subscribeNext:^(UIColor *color){
	6.     self.passwordTextField.backgroundColor = color;
	7.   }];
	
	
（不要使用这段代码，下面有一种更好的写法！）



从概念上来说，就是把之前信号的输出应用到输入框的backgroundColor属性上。但是上面的用法不是很好。


幸运的是，ReactiveCocoa提供了一个宏来更好的完成上面的事情。把下面的代码直接加到viewDidLoad中两个信号的代码后面：
	1. RAC(self.passwordTextField, backgroundColor) =
	2.   [validPasswordSignal
	3.     map:^id(NSNumber *passwordValid){
	4.       return[passwordValid boolValue] ? [UIColor clearColor]:[UIColor yellowColor];
	5.     }];
	6.  
	7. RAC(self.usernameTextField, backgroundColor) =
	8.   [validUsernameSignal
	9.     map:^id(NSNumber *passwordValid){
	10.      return[passwordValid boolValue] ? [UIColor clearColor]:[UIColor yellowColor];
	11.    }];
	
	


RAC宏允许直接把信号的输出应用到对象的属性上。RAC宏有两个参数，第一个是需要设置属性值的对象，第二个是属性名。每次信号产生一个next事件，传递过来的值都会应用到该属性上。


你不觉得这种方法很好吗？


在编译运行之前，找到updateUIState方法，把头两行删掉。
	1. self.usernameTextField.backgroundColor = 
	2.     self.usernameIsValid ? [UIColor clearColor] : [UIColor yellowColor]; 
	3. self.passwordTextField.backgroundColor = 
	4.     self.passwordIsValid ? [UIColor clearColor] : [UIColor yellowColor];
	
	
这样就把不相关的代码删掉了。


编译运行，可以发现当输入内容无效时，输入框看起来高亮了，有效时又透明了。


现在的逻辑用图形来表示就是下面这样的。能看到有两条简单的管道，两个文本信号，经过一个map转为表示是否有效的布尔值，再经过一个map转为UIColor，而这个UIColor已经和输入框的背景颜色绑定了。
![](http://cdn5.raywenderlich.com/wp-content/uploads/2014/01/TextFieldValidPipeline.png)


你是否好奇为什么要创建两个分开的validPasswordSignal和validUsernameSignal呢，而不是每个输入框一个单独的管道呢？（？）稍安勿躁，答案就在下面。
> 原文：Are you wondering why you created separate validPasswordSignal and validUsernameSignal signals, as opposed to a single fluent pipeline for each text field? Patience dear reader, the method
>  behind this madness will become clear shortly!
##聚合信号
目前在应用中，登录按钮只有当用户名和密码输入框的输入都有效时才工作。现在要把这里改成响应式的。


现在的代码中已经有可以产生用户名和密码输入框是否有效的信号了——validUsernameSignal和validPasswordSignal了。现在需要做的就是聚合这两个信号来决定登录按钮是否可用。



把下面的代码添加到viewDidLoad的末尾：
	1. RACSignal *signUpActiveSignal =
	2.   [RACSignal combineLatest:@[validUsernameSignal, validPasswordSignal]
	3.                     reduce:^id(NSNumber*usernameValid, NSNumber *passwordValid){
	4.                       return @([usernameValid boolValue]&&[passwordValid boolValue]);
	5.                     }];
	
	


上面的代码使用combineLatest:reduce:方法把validUsernameSignal和validPasswordSignal产生的最新的值聚合在一起，并生成一个新的信号。每次这两个源信号的任何一个产生新值时，reduce
 block都会执行，block的返回值会发给下一个信号。


> 注意：RACsignal的这个方法可以聚合任意数量的信号，reduce block的参数和每个源信号相关。ReactiveCocoa有一个工具类[RACBlockTrampoline](https://github.com/ReactiveCocoa/ReactiveCocoa/blob/master/ReactiveCocoaFramework/ReactiveCocoa/RACBlockTrampoline.m?source=c)，它在内部处理reduce
>  block的可变参数。实际上在ReactiveCocoa的实现中有很多隐藏的技巧，值得你去看看。


现在已经有了合适的信号，把下面的代码添加到viewDidLoad的末尾。这会把信号和按钮的enabled属性绑定。
	1. [signUpActiveSignal subscribeNext:^(NSNumber*signupActive){
	2.    self.signInButton.enabled =[signupActive boolValue];
	3.  }];
	
	


在运行之前，把以前的旧实现删掉。把下面这两个属性删掉。
	1. @property (nonatomic) BOOL passwordIsValid;
	2. @property (nonatomic) BOOL usernameIsValid;
	
	


把viewDidLoad中的这些也删掉：
	1. // handle text changes for both text fields
	2. [self.usernameTextField addTarget:self
	3.                            action:@selector(usernameTextFieldChanged)
	4.                  forControlEvents:UIControlEventEditingChanged];
	5. [self.passwordTextField addTarget:self
	6.                            action:@selector(passwordTextFieldChanged)
	7.                 forControlEvents:UIControlEventEditingChanged];
	
	


同样把updateUIState、usernameTextFieldChanged和passwordTextFieldChanged方法删掉。
最后确保把viewDidLoad中updateUIState的调用删掉。


编译运行，看看登录按钮。当用户名和密码输入有效时，按钮就是可用的，和以前一样。


现在应用的逻辑就是下面这样的：
![](http://cdn3.raywenderlich.com/wp-content/uploads/2014/01/CombinePipeline.png)


上图展示了一些重要的概念，你可以使用ReactiveCocoa来完成一些重量级的任务。
- 分割——信号可以有很多subscriber，也就是作为很多后续步骤的源。注意上图中那个用来表示用户名和密码有效性的布尔信号，它被分割成多个，用于不同的地方﻿。
- 聚合——多个信号可以聚合成一个新的信号，在上面的例子中，两个布尔信号聚合成了一个。实际上你可以聚合并产生任何类型的信号。



这些改动的结果就是，代码中没有用来表示两个输入框有效状态的私有属性了。这就是用响应式编程的一个关键区别，你不需要使用实例变量来追踪瞬时状态。
##响应式的登录
应用目前使用上面图中展示的响应式管道来管理输入框和按钮的状态。但是按钮按下的处理用的还是action，所以下一步就是把剩下的逻辑都替换成响应式的。


在storyboard中，登录按钮的Touch Up Inside事件和RWViewController.m中的signInButtonTouched方法是绑定的。下面会用响应的方法替换，所以首先要做的就是断开当前的storyboard
 action。


打开Main.storyboard，找到登录按钮，按住ctrl键单击，打开outlet/action连接框，然后点击x来断开连接。如果你找不到的话，下图中红色箭头指示的就是删除按钮。
![](http://cdn5.raywenderlich.com/wp-content/uploads/2014/01/DisconnectAction.jpg)


你已经知道了ReactiveCocoa框架是如何给基本UIKit控件添加属性和方法的了。目前你已经使用了rac_textSignal，它会在文本发生变化时产生信号。为了处理按钮的事件，现在需要用到ReactiveCocoa为UIKit添加的另一个方法，rac_signalForControlEvents。


现在回到RWViewController.m，把下面的代码添加到viewDidLoad的末尾：
	1. [[self.signInButton
	2.    rac_signalForControlEvents:UIControlEventTouchUpInside]
	3.    subscribeNext:^(id x) {
	4.      NSLog(@"button clicked");
	5.    }];
	
	
 
上面的代码从按钮的UIControlEventTouchUpInside事件创建了一个信号，然后添加了一个订阅，在每次事件发生时都会输出log。


编译运行，确保的确有log输出。按钮只在用户名和密码框输入有效时可用，所以在点击按钮前需要在两个文本框中输入一些内容。


可以看到Xcode控制台的输出和下面的类似：
	1. 2013-12-28 08:05:10.816 RWReactivePlayground[18203:a0b] button clicked
	2. 2013-12-28 08:05:11.675 RWReactivePlayground[18203:a0b] button clicked
	3. 2013-12-28 08:05:12.605 RWReactivePlayground[18203:a0b] button clicked
	4. 2013-12-28 08:05:12.766 RWReactivePlayground[18203:a0b] button clicked
	5. 2013-12-28 08:05:12.917 RWReactivePlayground[18203:a0b] button clicked
	
	


现在按钮有了点击事件的信号，下一步就是把它和登录流程连接起来。那么问题就来了，打开RWDummySignInService.h，看一下接口：
	1. typedef void (^RWSignInResponse)(BOOL);
	2.  
	3. @interface RWDummySignInService : NSObject
	4.  
	5. - (void)signInWithUsername:(NSString *)username
	6.                   password:(NSString *)password
	7.                   complete:(RWSignInResponse)completeBlock;
	8.                   
	9. @end
	
	


这个service有3个参数，用户名、密码和一个完成回调block。这个block会在登录成功或失败时执行。你可以在按钮点击事件的subscribeNext: blcok里直接调用这个方法，但是为什么你要这么做？（？）


> 注意：本教程为了简便使用了一个假的service，所以它不依赖任何外部API。但你现在的确遇到了一个问题，如何使用这些不是用信号表示的API呢？
##创建信号
幸运的是，把已有的异步API用信号的方式来表示相当简单。首先把RWViewController.m中的signInButtonTouched:删掉。你会用响应式的的方法来替换这段逻辑。


还是在RWViewController.m中，添加下面的方法：
	1. - (RACSignal *)signInSignal {
	2. return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber){
	3.    [self.signInService 
	4.      signInWithUsername:self.usernameTextField.text
	5.                password:self.passwordTextField.text
	6.                complete:^(BOOL success){
	7.                     [subscriber sendNext:@(success)];
	8.                     [subscriber sendCompleted];
	9.      }];
	10.    return nil;
	11. }];
	12. }
	
	


上面的方法创建了一个信号，使用用户名和密码登录。现在分解来看一下。


上面的代码使用RACSignal的createSignal:方法来创建信号。方法的入参是一个block，这个block描述了这个信号。当这个信号有subscriber时，block里的代码就会执行。


block的入参是一个subscriber实例，它遵循RACSubscriber协议，协议里有一些方法来产生事件，你可以发送任意数量的next事件，或者用error\complete事件来终止。本例中，信号发送了一个next事件来表示登录是否成功，随后是一个complete事件。


这个block的返回值是一个RACDisposable对象，它允许你在一个订阅被取消时执行一些清理工作。当前的信号不需要执行清理操作，所以返回nil就可以了。


可以看到，把一个异步API用信号封装是多简单！


现在就来使用这个新的信号。把之前添加在viewDidLoad中的代码更新成下面这样的：
	1. [[[self.signInButton
	2.    rac_signalForControlEvents:UIControlEventTouchUpInside]
	3.    map:^id(id x){
	4.      return[self signInSignal];
	5.    }]
	6.    subscribeNext:^(id x){
	7.      NSLog(@"Sign in result: %@", x);
	8.    }];
	
	


上面的代码使用map方法，把按钮点击信号转换成了登录信号。subscriber输出log。


编译运行，点击登录按钮，查看Xcode的控制台，等等，输出的这是个什么鬼？
	1. 2014-01-08 21:00:25.919 RWReactivePlayground[33818:a0b] Sign in result:
	2.                                    <RACDynamicSignal: 0xa068a00> name: +createSignal:
	
	




没错，你已经给subscribeNext:的block传入了一个信号，但传入的不是登录结果的信号。


下图展示了到底发生了什么：
![](http://cdn4.raywenderlich.com/wp-content/uploads/2014/01/SignalOfSignals.png)
当点击按钮时，rac_signalForControlEvents发送了一个next事件（事件的data是UIButton）。map操作创建并返回了登录信号，这意味着后续步骤都会收到一个RACSignal。这就是你在subscribeNext:这步看到的。


上面问题的解决方法，有时候叫做信号中的信号，换句话说就是一个外部信号里面还有一个内部信号。你可以在外部信号的subscribeNext:block里订阅内部信号。不过这样嵌套太混乱啦，还好ReactiveCocoa已经解决了这个问题。
##信号中的信号
解决的方法很简单，只需要把map操作改成flattenMap就可以了：
	1. [[[self.signInButton
	2.    rac_signalForControlEvents:UIControlEventTouchUpInside]
	3.    flattenMap:^id(id x){
	4.      return[self signInSignal];
	5.    }]
	6.    subscribeNext:^(id x){
	7.      NSLog(@"Sign in result: %@", x);
	8.    }];
	
	


这个操作把按钮点击事件转换为登录信号，同时还从内部信号发送事件到外部信号。


编译运行，注意控制台，现在应该输出登录是否成功了。
	1. 2013-12-28 18:20:08.156 RWReactivePlayground[22993:a0b] Sign in result: 0
	2. 2013-12-28 18:25:50.927 RWReactivePlayground[22993:a0b] Sign in result: 1
	
	


还不错。


现在已经完成了大部分的内容，最后就是在subscribeNext步骤里添加登录成功后跳转的逻辑。把代码更新成下面的：
	1. [[[self.signInButton
	2. rac_signalForControlEvents:UIControlEventTouchUpInside]
	3. flattenMap:^id(id x){
	4.    return[self signInSignal];
	5. }]
	6. subscribeNext:^(NSNumber*signedIn){
	7.    BOOL success =[signedIn boolValue];
	8.    self.signInFailureText.hidden = success;
	9.    if(success){
	10.      [self performSegueWithIdentifier:@"signInSuccess" sender:self];
	11.    }
	12.   }];
	
	


subscribeNext: block从登录信号中取得结果，相应地更新signInFailureText是否可见。如果登录成功执行导航跳转。


编译运行，应该就能再看到可爱的小猫啦！喵~
![](http://cdn4.raywenderlich.com/wp-content/uploads/2014/01/ReactivePlaygroundStarter.jpg)


你注意到这个应用现在有一些用户体验上的小问题了吗？当登录service正在校验用户名和密码时，登录按钮应该是不可点击的。这会防止用户多次执行登录操作。还有，如果登录失败了，用户再次尝试登录时，应该隐藏错误信息。


这个逻辑应该怎么添加呢？改变按钮的可用状态并不是转换（map）、过滤（filter）或者其他已经学过的概念。其实这个就叫做“副作用”，换句话说就是在一个next事件发生时执行的逻辑，而该逻辑并不改变事件本身。
##添加附加操作（Adding side-effects）
把代码更新成下面的：
	1. [[[[self.signInButton
	2.    rac_signalForControlEvents:UIControlEventTouchUpInside]
	3.    doNext:^(id x){
	4.      self.signInButton.enabled =NO;
	5.      self.signInFailureText.hidden =YES;
	6.    }]
	7.    flattenMap:^id(id x){
	8.      return[self signInSignal];
	9.    }]
	10.    subscribeNext:^(NSNumber*signedIn){
	11.      self.signInButton.enabled =YES;
	12.      BOOL success =[signedIn boolValue];
	13.      self.signInFailureText.hidden = success;
	14.      if(success){
	15.        [self performSegueWithIdentifier:@"signInSuccess" sender:self];
	16.      }
	17.    }];
	
	


你可以看到doNext:是直接跟在按钮点击事件的后面。而且doNext: block并没有返回值。因为它是附加操作，并不改变事件本身。


上面的doNext: block把按钮置为不可点击，隐藏登录失败提示。然后在subscribeNext:block里重新把按钮置为可点击，并根据登录结果来决定是否显示失败提示。


之前的管道图就更新成下面这样的：
![](http://cdn3.raywenderlich.com/wp-content/uploads/2014/01/SideEffects.png)


编译运行，确保登录按钮的可点击状态和预期的一样。


现在所有的工作都已经完成了，这个应用已经是响应式的啦。


如果你中途哪里出了问题，可以下载[最终的工程](http://cdn1.raywenderlich.com/wp-content/uploads/2014/01/ReactivePlayground-Final.zip)（依赖库都有），或者在[Github](https://github.com/ColinEberhardt/RWReactivePlayground)上找到这份代码，教程中的每一次编译运行都有对应的commit。


> 注意：在异步操作执行的过程中禁用按钮是一个常见的问题，ReactiveCocoa也能很好的解决。RACCommand就包含这个概念，它有一个enabled信号，能让你把按钮的enabled属性和信号绑定起来。你也许想试试这个类。
##总结
希望本教程为你今后在自己的应用中使用ReactiveCocoa打下了一个好的基础。你可能需要一些练习来熟悉这些概念，但就像是语言或者编程，一旦你夯实基础，用起来也就很简单了。ReactiveCocoa的核心就是信号，而它不过就是事件流。还能再更简单点吗？


在使用ReactiveCocoa后，我发现了一个有趣的事情，那就是你可以用很多种不同的方法来解决同一个问题。你可以用教程中的例子试试，调整一下信号，改改信号的分割和聚合。


ReactiveCocoa的主旨是让你的代码更简洁易懂，这值得多想想。我个人认为，如果逻辑可以用清晰的管道、流式语法来表示，那就很好理解这个应用到底干了什么了。


在本系列教程的[第二部分](http://benbeng.leanote.com/post/ReactiveCocoaTutorial-part2)，你将会学到诸如错误处理、在不同线程中执行代码等高级用法。


（第一部分完）


