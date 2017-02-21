title: 深入浅出ObjC之消息
date: 2015-08-26 18:27:00
categories: 技术
tags: 
description:
---
在入门级别的ObjC 教程中，我们常对从C++或Java 或其他面向对象语言转过来的程序员说，ObjC 中的方法调用（ObjC中的术语为消息）跟其他语言中的方法调用差不多，只是形式有些不同而已。
譬如Ｃ++ 中的：
Bird * aBird = new Bird();
aBird->fly();
在ObjC 中则如下：
Bird * aBird = [[Bird alloc] init];
[aBird fly];

乍看起来，好像只是书写形式不同而已，实则差异大矣。Ｃ++中的方法调用可能是动态的，也可能是静态的；而ObjC中的消息都为动态的。下文将详细介绍为什么是动态的，以及编译器在这背后做了些什么事情。

要说清楚消息这个话题，我们必须先来了解三个概念Class, SEL, IMP，它们在objc/objc.h 中定义：
typedef struct objc_class *Class;
typedef struct objc_object {
    Class isa;
} *id;
 
typedef struct objc_selector   *SEL;   
typedef id (*IMP)(id, SEL, ...);
 
**Class 的含义**
Class 被定义为一个指向 objc_class的结构体指针，这个结构体表示每一个类的类结构。而 objc_class 在objc/objc_class.h中定义如下:
struct objc_class {
    struct objc_class **super_class;  /***父类*/
    const char *name;                         **/***类名字*/
    long version; **                                 /***版本信息*/
    long info;                                        **/***类信息*/
    long instance_size;                      **/***实例大小*/
    struct objc_ivar_list *ivars;   **       /***实例参数链表*/
    struct objc_method_list **methodLists; ** /***方法链表*/
    struct objc_cache *cache;                    **/***方法缓存*/
    struct objc_protocol_list *protocols;   **/***协议链表*/
};
 
由此可见，Class 是指向类结构体的指针，该类结构体含有一个指向其父类类结构的指针，该类方法的链表，该类方法的缓存以及其他必要信息。
NSObject 的class 方法就返回这样一个指向其类结构的指针。每一个类实例对象的第一个实例变量是一个指向该对象的类结构的指针，叫做isa。通过该指针，对象可以访问它对应的类以及相应的父类。如图一所示：
![](http://www.cppblog.com/images/cppblog_com/kesalin/objc_class_hier.gif)

 
如图一所示，圆形所代表的实例对象的第一个实例变量为 isa，它指向该类的类结构 The object’s class。而该类结构有一个指向其父类类结构的指针superclass， 以及自身消息名称(selector)/实现地址(address)的方法链表。
 
**方法的含义：**
注意这里所说的方法链表里面存储的是Method 类型的。图一中selector 就是指 Method的 SEL,  address就是指Method的 IMP。
 
一个方法 Method，其包含一个方法选标 SEL – 表示该方法的名称，一个types – 表示该方法参数的类型，一个 IMP  - 指向该方法的具体实现的函数指针。Method 在头文件 objc_class.h中定义如下：
typedef struct objc_method *Method;


typedef struct objc_ method {
    SEL method_name;
    char *method_types;
    IMP method_imp;
};


**SEL 的含义：**
在前面我们看到方法选标 SEL 的定义为：
typedef struct objc_selector   *SEL;   
它是一个指向 objc_selector 指针，表示方法的名字/签名。如下所示，打印出 selector。
-(NSInteger)maxIn:(NSInteger)a theOther:(NSInteger)b
{
    return (a > b) ? a : b;
}
 
NSLog(@"SEL=%s", @selector(maxIn:theOther:));
 
**输出：SEL=maxIn:theOther:**
 
不同的类可以拥有相同的 selector，这个没有问题，因为不同类的实例对象performSelector相同的 selector 时，会在各自的消息选标(selector)/实现地址(address) 方法链表中根据 selector 去查找具体的方法实现IMP, 然后用这个方法实现去执行具体的实现代码。这是一个动态绑定的过程，在编译的时候，我们不知道最终会执行哪一些代码，只有在执行的时候，通过selector去查询，我们才能确定具体的执行代码。


**IMP 的含义：**
在前面我们也看到 IMP 的定义为：
typedef id (*IMP)(id, SEL, ...);
根据前面id 的定义，我们知道 id是一个指向 objc_object 结构体的指针，该结构体只有一个成员isa，所以任何继承自 NSObject 的类对象都可以用id 来指代，因为 NSObject 的第一个成员实例就是isa。
至此，我们就很清楚地知道 IMP  的含义：IMP 是一个函数指针，这个被指向的函数包含一个接收消息的对象id(self  指针), 调用方法的选标 SEL (方法名)，以及不定个数的方法参数，并返回一个id。也就是说 IMP 是消息最终调用的执行代码，是方法真正的实现代码 。我们可以像在Ｃ语言里面一样使用这个函数指针。
NSObject 类中的methodForSelector：方法就是这样一个获取指向方法实现IMP 的指针，methodForSelector：返回的指针和赋值的变量类型必须完全一致，包括方法的参数类型和返回值类型。
下面的例子展示了怎么使用指针来调用setFilled:的方法实现：
void (*setter)(id, SEL, BOOL);
int i;
 
setter = (void(*)(id, SEL, BOOL))[target methodForSelector:@selector(setFilled:)];
 
for (i = 0; i < 1000; i++)
    setter(targetList[i], @selector(setFilled:), YES);
 
 
使用methodForSelector：来避免动态绑定将减少大部分消息的开销，但是这只有在指定的消息被重复发送很多次时才有意义，例如上面的for循环。
注意，methodForSelector：是Cocoa运行时系统的提供的功能，而不是Objective-C语言本身的功能。
 
**消息调用过程：**
至此我们对ObjC 中的消息应该有个大致思路了：示例
Bird * aBird = [[Bird alloc] init];
[aBird fly];
中对 fly 的调用，编译器通过插入一些代码，将之转换为对方法具体实现IMP的调用，这个 IMP是通过在 Bird 的类结构中的方法链表中查找名称为fly 的 选标SEL 对应的具体方法实现找到的。
上面的思路还有一些没有提及的话题，比如说编译器插入了什么代码，如果在方法链表中没有找到对应的 IMP又会如何，这些话题在下面展开。
 
**消息函数 obj_msgSend：**
编译器会将消息转换为对消息函数 objc_msgSend的调用，该函数有两个主要的参数：消息接收者id 和消息对应的方法选标 SEL, 同时接收消息中的任意参数：
id objc_msgSend(id theReceiver, SELtheSelector, ...)
如上面的消息 [aBird fly]会被转换为如下形式的函数调用：
objc_msgSend(aBird, @selector(fly));
 
该消息函数做了动态绑定所需要的一切工作：
1，它首先找到 SEL 对应的方法实现 IMP。因为不同的类对同一方法可能会有不同的实现，所以找到的方法实现依赖于消息接收者的类型。
2， 然后将消息接收者对象(指向消息接收者对象的指针)以及方法中指定的参数传递给方法实现 IMP。
3， 最后，将方法实现的返回值作为该函数的返回值返回。
编译器会自动插入调用该消息函数objc_msgSend的代码，我们无须在代码中显示调用该消息函数。当objc_msgSend找到方法对应的实现时，它将直接调用该方法实现，并将消息中所有的参数都传递给方法实现，同时，它还将传递两个隐藏的参数：消息的接收者以及方法名称 SEL。这些参数帮助方法实现获得了消息表达式的信息。它们被认为是”隐藏“的是因为它们并没有在定义方法的源代码中声明，而是在代码编译时是插入方法的实现中的。
尽管这些参数没有被显示声明，但在源代码中仍然可以引用它们（就象可以引用消息接收者对象的实例变量一样）。在方法中可以通过self来引用消息接收者对象，通过选标_cmd来引用方法本身。在下面的例子中，_cmd 指的是strange方法，self指的收到strange消息的对象。
- strange
{
    id target = getTheReceiver();
    SEL method = getTheMethod();
 
    if (target == self || mothod == _cmd)
        return nil;
 
    return [target performSelector:method];
}
 
在这两个参数中，self更有用一些。实际上，它是在方法实现中访问消息接收者对象的实例变量的途径。
 
**查找 IMP 的过程：**
前面说了，objc_msgSend 会根据方法选标 SEL 在类结构的方法列表中查找方法实现IMP。这里头有一些文章，我们在前面的类结构中也看到有一个叫objc_cache *cache 的成员，这个缓存为提高效率而存在的。每个类都有一个独立的缓存，同时包括继承的方法和在该类中定义的方法。。
 下面来剖析一段苹果官方的源码：

static Method look_up_method(Class cls, SEL sel, BOOL withCache, BOOL withResolver)
{
    Method meth = NULL;

    if (withCache) {
        meth = _cache_getMethod(cls, sel, &_objc_msgForward_internal);
        if (meth == (Method)1) {
            // Cache contains forward:: . Stop searching.
            return NULL;
        }
    }

    if (!meth) meth = _class_getMethod(cls, sel);

    if (!meth  &&  withResolver) meth = _class_resolveMethod(cls, sel);

    return meth;
}

通过分析上面的代码，可以看到，查找时：
 
1，首先去该类的方法 cache 中查找，如果找到了就返回它；
2，如果没有找到，就去该类的方法列表中查找。如果在该类的方法列表中找到了，则将 IMP 返回，并将它加入cache中缓存起来。根据最近使用原则，这个方法再次调用的可能性很大，缓存起来可以节省下次调用再次查找的开销。3，3，如果在该类的方法列表中没找到对应的 IMP，在通过该类结构中的 super_class指针在其父类结构的方法列表中去查找，直到在某个父类的方法列表中找到对应的IMP，返回它，并加入cache中；
4，如果在自身以及所有父类的方法列表中都没有找到对应的 IMP，则看是不是可以进行动态方法决议（后面有专文讲述这个话题）；
5，如果动态方法决议没能解决问题，进入下面要讲的消息转发流程。
 
 
便利函数：
我们可以通过NSObject的一些方法获取运行时信息或动态执行一些消息：
 class   返回对象的类；
 isKindOfClass 和 isMemberOfClass检查对象是否在指定的类继承体系中；
 respondsToSelector 检查对象能否相应指定的消息；
 conformsToProtocol 检查对象是否实现了指定协议类的方法；
 methodForSelector  返回指定方法实现的地址。
 performSelector:withObject 执行SEL 所指代的方法。
* *** **
**消息转发：**
通常，给一个对象发送它不能处理的消息会得到出错提示，然而，Objective-C运行时系统在抛出错误之前，会给消息接收对象发送一条特别的消息forwardInvocation 来通知该对象，该消息的唯一参数是个NSInvocation类型的对象——该对象封装了原始的消息和消息的参数。
我们可以实现forwardInvocation:方法来对不能处理的消息做一些默认的处理，也可以将消息转发给其他对象来处理，而不抛出错误。

关于消息转发的作用，可以考虑如下情景：假设，我们需要设计一个能够响应negotiate消息的对象，并且能够包括其它类型的对象对消息的响应。 通过在negotiate方法的实现中将negotiate消息转发给其它的对象来很容易的达到这一目的。


更进一步，假设我们希望我们的对象和另外一个类的对象对negotiate的消息的响应完全一致。一种可能的方式就是让我们的类继承其它类的方法实现。 然后，有时候这种方式不可行，因为我们的类和其它类可能需要在不同的继承体系中响应negotiate消息。
虽然我们的类无法继承其它类的negotiate方法，但我们仍然可以提供一个方法实现，这个方法实现只是简单的将negotiate消息转发给其他类的对象，就好像从其它类那儿“借”来的现一样。如下所示：
- negotiate
{
    if ([someOtherObject respondsToSelector:@selector(negotiate)])
        return [someOtherObject negotiate];
 
    return self;
}
这种方式显得有欠灵活，特别是有很多消息都希望传递给其它对象时，我们就必须为每一种消息提供方法实现。此外，这种方式不能处理未知的消息。当我们写下代码时，所有我们需要转发的消息的集合都必须确定。然而，实际上，这个集合会随着运行时事件的发生，新方法或者新类的定义而变化。
forwardInvocation:消息给这个问题提供了一个更特别的，动态的解决方案：当一个对象由于没有相应的方法实现而无法响应某消息时，运行时系统将通过forwardInvocation:消息通知该对象。每个对象都从NSObject类中继承了forwardInvocation:方法。然而，NSObject中的方法实现只是简单地调用了doesNotRecognizeSelector:。通过实现我们自己的forwardInvocation:方法，我们可以在该方法实现中将消息转发给其它对象。
要转发消息给其它对象，forwardInvocation:方法所必须做的有：
1，决定将消息转发给谁，并且
2，将消息和原来的参数一块转发出去。
消息可以通过invokeWithTarget:方法来转发：
 
- (void) forwardInvocation:(NSInvocation *)anInvocation
{
    if ([someOtherObject respondsToSelector:[anInvocation selector]])
        [anInvocation invokeWithTarget:someOtherObject];
 
    else
        [super forwardInvocation:anInvocation];
}
 
 
转发消息后的返回值将返回给原来的消息发送者。您可以将返回任何类型的返回值，包括: id，结构体，浮点数等。forwardInvocation:方法就像一个不能识别的消息的分发中心，将这些消息转发给不同接收对象。或者它也可以象一个运输站将所有的消息都发送给同一个接收对象。它可以将一个消息翻译成另外一个消息，或者简单的"吃掉“某些消息，因此没有响应也没有错误。forwardInvocation:方法也可以对不同的消息提供同样的响应，这一切都取决于方法的具体实现。该方法所提供是将不同的对象链接到消息链的能力。

**注意：** forwardInvocation:方法只有在消息接收对象中无法正常响应消息时才会被调用。 所以，如果我们希望一个对象将negotiate消息转发给其它对象，则这个对象不能有negotiate方法，也不能在动态方法决议中为之提供实现。否则，forwardInvocation:将不可能会被调用。

转自：罗朝辉 ([http://ww.cppblog.com/kesalin](http://ww.cppblog.com/kesalin))

参考资料：
Objective-CRuntime Reference:
[http://developer.apple.com/library/mac/#documentation/Cocoa/Reference/ObjCRuntimeRef/Reference/reference.html](http://developer.apple.com/library/mac/#documentation/Cocoa/Reference/ObjCRuntimeRef/Reference/reference.html)
Objective-C Runtime Programming Guide:
[http://developer.apple.com/library/mac/#documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Introduction/Introduction.html](http://developer.apple.com/library/mac/#documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Introduction/Introduction.html)