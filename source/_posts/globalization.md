title: 国际化与本地化(i18n)支持函数库（多语言）
date: 2014-08-22 09:33:00
categories: 技术
tags: 
description:
---
http://www.cocoachina.com/bbs/read.php?tid=224074


- 关键字：I18N,本地化,国际化,多语言
- 代码类库：数据持久化(DataPersistence)
- GitHub链接：[https://github.com/kaishiqi/I18N](https://github.com/kaishiqi/I18N)-Gettext-Supported

[![](http://cache.adm.cnzz.net/material/df/1/13d5a300cf3ab7df234d2612d434f.jpg "捕鱼达人")](http://click.am1.adm.cnzz.net/click.php?m4c=2mNyDbwSya6SX2vfkkOADQsfFQVbGB4_Egg9S0ZOMwtCDjgIVkBUGE5OTk1QMjpaHlkCFxwSVAoPXEJXPQNlSB5vEC8QeAkSEHEsCwMAAg4OMBIoaw..)最近在研究项目多语言功能，发现了一套比较成熟的解决方案，就是GUN GETTEX。
而且还有完善的编辑器 Poedit，于是就剩下在项目中解析使用翻译文件了。
搜索发现 Boost 类库貌似有提供支持，可是又不想为此而使用这么庞大的一个类库。
所以自己四处搜索了一些资料，写了这么一个配合 Poedit 软件，解析使用 gettext 翻译文件(*.mo)，的解决方案功能类库。

<!--more-->


使用方法很简单：
***

第一步：
在代码中用关键字包装需要翻译的字符串。我做了一些扩展，支持的翻译种类功能有：

![](http://www.cocoachina.com/bbs/attachment/Fid_19/19_72216_cce545fa56053d4.png) 

- 普通文本：        就是普通的一句字符串，一句话或者一个单词。例如：
[复制代码]()1. __("Hello world!")




- 上下文文本：        有些时候一个词语存一词多意的情况，比如一个按钮上显示着 post，另一个标签上也显示着 post。他们的上下文环境不同意思也不一样。

但是如果你直接把2个post单词丢给翻译直接去翻译，他一定也会拿不定的，而且直接用post在用在程序翻译哈希表key的话也会被覆盖掉一个的。
所以这时候如果有个额外的上下文参数区分，那么就会很方便了。例如：
[复制代码]()1. _x("post", "A post."); // 当翻译看到 A post，那么自然就知道这个地方的 post 需要翻译成 “文章”，而翻译并不需要关系这是我们程序中用在标签位置的 post。
2. _x("post", "To post."); // 看到 To post，翻译就很确切的知道这里的 post 需要翻译成 “发布”。



- 单复数文本：        大家都知道很多语言是存在单复数格式的，比如说英语。那么数量不同，自然就需要用不同的格式进行显示。这个格式就会根据第三个变量参数的数量判断是需要使用单数格式还是复数格式显示了。
[复制代码]()1. _n("There is a comment.", "There are comments.", 1);
2. _n("There is a comment.", "There are comments.", 3);




- 单复数 + 上下文：        顾名思义就是既有单复数的情况也存在需要区分上下文环境的情况。不举例了，示例代码中都有。



除此之外，我写了一个额外的字符串格式化方法，类似于 printf 方法，只不过假如了为格式标记附带参数索引的功能。例如：
[复制代码]()1. i18nFormat("c:%c1 d:%d2 f:%.2f3 s:%s4 %:%", '@', 30, 3.1415, "str");
2. //c:@ d:30 f:3.14 s:str %:%)


这个format格式后面增加了参数的索引标记，参数是从1开始依次计算的。这个功能有什么用的？
比如，参数需要反复使用的情况：
[复制代码]()1. i18nFormat("%s1.a = %s1.b = %s1.c = %s1.d = %d2", "foo", 7);
2. //foo.a = foo.b = foo.c = foo.d = 18)


参数需要无序使用的情况：
[复制代码]()1. i18nFormat("[enable] %d1 < %d2; %d2 > %d3; %d3 > %d1", 1, 3, 2);
2. //1 < 3; 3 > 2; 2 > 1



为什么要提提供这个功能呢？因为英文存在一个叫“倒装句”的语法。比如：
[复制代码]()1. 英文原文：printf("There are birds singing in the tree.")
2. 翻译中文：printf("小鸟在树上唱歌。")

如果唱歌和树是变量的话，那么这句话的翻译格式应该为：
[复制代码]()1. 英文原文：printf("There are birds %s in the %s.", "singing", "tree")
2. 翻译中文：printf("小鸟在%s上%s。", "唱歌", "树")

如果只是单纯的变量按照顺序替换的话，中文翻译过来就会变成：
小鸟在[唱歌]上[树]。
这时候就是发挥参数匹配foramat的优势了：
[复制代码]()1. 英文原文：i18nFormatStr("There are birds %s1 in the %s2.", "singing", "tree")
2. 翻译中文：i18nFormatStr("小鸟在%s2上%s2。", "唱歌", "树")




***

第二步：
使用 [Poedit](http://poedit.net/) 软件捕捉代码使用各种关键字包住的字符串，然后生成翻译清单。

![](http://www.cocoachina.com/bbs/attachment/Fid_19/19_72216_78e1b2c8a707baa.png) 
Poedit是一款多平台的软件，有mac、win、liux版。可视化的编辑操作，管理维护起来十分很方便，而且很智能。
比如注释的代码就不会去捕捉，而且代码中的翻译文字如果想要修改，只需要点击一下更新按钮就可以自动识别出变动，完全不需要人工调整原字符哪里做了改动，翻译字典那边也要记得同样修改。
po文件是Poedit的编辑文件，而保存后将会编译生成二进制文件mo，即减少文件体积又可以达到一点加密的效果。


***

第三步：
用类库加载指定的 mo 文件即可。类库会自动解析文件并且生成一个翻译原文与翻译文对应的字符串哈希表提供给外部使用。使用者不需要关心实现细节，只需要写一句话即可实现：
[复制代码]()1. I18nUtils::getInstance()->addMO("res/zh_Hans.mo", [](int){return 0;}, 1);



![](http://www.cocoachina.com/bbs/attachment/Fid_19/19_72216_26dee3053893cab.png) 



一开始我在做cocos2d-x项目的时候编写的，后来把代码独立抽离出来，所以现在类库不依赖cocos2d-x，可以适用于任何C++的游戏或者软件项目。
当然cocos2d-x也是提供了支持接口的。所以该类库是 iOS、Android、MAC、Windows 和 Linux 多平台支持的C++解决方案。


最后，我在 github 链接中分别提供了 xcode 以及 vs2012 的用例，以及如何使用 Poedit 的说明。方便大家围观测用。


![](http://www.cocoachina.com/bbs/attachment/Fid_19/19_72216_cf246611612e583.png) 

![](http://www.cocoachina.com/bbs/attachment/Fid_19/19_72216_020b8800d5b6944.png)

![](http://www.cocoachina.com/bbs/attachment/Fid_19/19_72216_d8c5130de0e9f2a.png) 

![](http://www.cocoachina.com/bbs/attachment/Fid_19/19_72216_1add24671d336dd.png)     
附件: ![](http://www.cocoachina.com/bbs/images/wind2013/file/zip.gif) [I18N-Gettext-Supported-master.zip](http://www.cocoachina.com/bbs/job.php?action=download&aid=75903) (98
 K) 下载次数:12