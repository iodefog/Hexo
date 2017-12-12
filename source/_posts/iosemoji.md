title: IOS Emoji 编码打印
date: 2016-04-26 15:14:00
categories: 技术
tags: 
description:
---
最新在研究下IOS的emoji。主要目的是想[Android](http://lib.csdn.net/base/15 "undefined") ,wphone,symbian都同步支持ios 的emoji。因此设及到图库及表情定义符。在已有的emoji表情库里目前已知道记录的就很800多个，IOS
 5 中集成的有479个。而IOS6 又新增了300个左右。

IOS 5 内部显示EMOJI使用提UTF16 编码。

先来看一段代码：

<!--more-->

```objc
#import <Foundation/Foundation.h>  
  
#define MAKE_Q(x) @#x  
#define MAKE_EM(x,y) MAKE_Q(x##y)  
#define MAKE_EMOJI(x) MAKE_EM(\U000,x)  
#define EMOJI_METHOD(x,y) + (NSString *)x { return MAKE_EMOJI(y); } //method implementions at .m file  
#define EMOJI_HMETHOD(x) + (NSString *)x;   //method define at .h file  
#define EMOJI_CODE_TO_SYMBOL(x) ((((0x808080F0 | (x & 0x3F000) >> 4) | (x & 0xFC0) << 10) | (x & 0x1C0000) << 18) | (x & 0x3F) << 24); 
  
@interface Emoji : NSObject  
+ (NSString *)emojiWithCode:(int)code;  
+ (NSArray *)allEmoji;  
@end  
```


```objc
#import "Emoji.h"  
#import "EmojiEmoticons.h"  
#import "EmojiMapSymbols.h"  
#import "EmojiPictographs.h"  
#import "EmojiTransport.h"  
  
@implementation Emoji  
+ (NSString *)emojiWithCode:(int)code {  
    int sym = <span style="color:#ff0000;">EMOJI_CODE_TO_SYMBOL</span>(code);  
    return [[NSString alloc] initWithBytes:&sym length:sizeof(sym) encoding:NSUTF8StringEncoding];  
}  
+ (NSArray *)allEmoji {  
    NSMutableArray *array = [NSMutableArray new];  
    [array addObjectsFromArray:[EmojiEmoticons allEmoticons]];  
    [array addObjectsFromArray:[EmojiMapSymbols allMapSymbols]];  
    [array addObjectsFromArray:[EmojiPictographs allPictographs]];  
    [array addObjectsFromArray:[EmojiTransport allTransport]];  
      
    return array;  
}  
@end  
```

```objc
#import <Foundation/Foundation.h>  
#import "Emoji.h"  
  
@interface EmojiEmoticons : NSObject  
  
+ (NSArray *)allEmoticons;  
  
EMOJI_HMETHOD(grinningFace);  
```



```objc
#import "EmojiEmoticons.h"  
  
@implementation EmojiEmoticons  
  
+ (NSArray *)allEmoticons {  
    NSMutableArray *array = [NSMutableArray new];  
    for (int i=0x1F600; i<=0x1F64F; i++) {  
        if (i < 0x1F641 || i > 0x1F644) {  
            [array addObject:[Emoji emojiWithCode:i]];  
        }  
    }  
    return array;  
}  
  
EMOJI_METHOD(grinningFace,1F600); 
```
以上代码是我从网上DOWN的一位老外写的，这段代码其它是遍历将编码进行组合成数组。主要看的是


```objc
#define EMOJI_CODE_TO_SYMBOL(x) ((((0x808080F0 | (x & 0x3F000) >> 4) | (x & 0xFC0) << 10) | (x & 0x1C0000) << 18) | (x & 0x3F) << 24);
```
这个宏的作用。它实际上是将一个Uindoe码转为UTF8。其中灵活的运用了位运算，此算法我还没有推导出他的计算规律，估且放一边，后面我会讲到一些UTF8及大于0x10000的UNICODE码转UTF16等算法。这里先看看遍历出来后Emoji的效果图；

![](http://img.my.csdn.net/uploads/201303/13/1363154094_9936.jpg)

呵呵，IOS的控件已帮我们自动的将UTF8或UTF16码进行转为相应的图片了，对IOS来说，图片资源就不用再让UCD出了或网上COPY了。

对于android ，wphone,symbian目前都没有很好的支持UNICODE 中的emoji。因此在做应用时需要各自的对照库及图片库。要完全兼容于IOS 6。哪务必要知道IOS 6中的各个emoji及其它表情符的编码定义，网上搜了好些都没有完整的编码定义及表情。没有办法，只硬着头皮上，把IOS6的全部导出来。话说干就干。
不过干之前先来了解一下基本知识（编码转换）。
![](http://img.my.csdn.net/uploads/201303/13/1363154778_3494.jpg)![](http://img.my.csdn.net/uploads/201303/13/1363154796_4063.jpg)


![](http://punchdrunker.github.com/iOSEmoji/table_html/cars/cars_07_01.png)![](http://punchdrunker.github.com/iOSEmoji/table_html/cars/cars_07_02.png)![](http://punchdrunker.github.com/iOSEmoji/table_html/cars/cars_07_03.png)        UnicodeU+1F1F7 U+1F1FAU+1F1EC U+1F1E7U+1F1E9 U+1F1EA        UTF80xF0 0x9F 0x87 0xB7 0xF0 0x9F 0x87 0xBA0xF0 0x9F 0x87 0xAC 0xF0 0x9F 0x87 0xA70xF0 0x9F 0x87 0xA9 0xF0 0x9F 0x87 0xAA        UTF160xD83C 0xDDF7 0xD83C 0xDDFA0xD83C 0xDDEC 0xD83C 0xDDE70xD83C 0xDDE9 0xD83C 0xDDEA        SB UnicodeE512E510E50E
###UTF-16 编码程序

假设要将 U+64321 (16进位) 转成 UTF-16 编码. 因为它超过 U+FFFF, 所以他必须编译成32位(4个byte)的格式,如下所示:11
	V  = 0x64321
	Vx = V - 0x10000
	   = 0x54321
	   = 0101 0100 0011 0010 0001
	
	Vh = 01 0101 0000 // Vx 的高位部份的 10 bits
	Vl = 11 0010 0001 // Vx 的低位部份的 10 bits
	w1 = 0xD800 //結果的前16位元初始值
	w2 = 0xDC00 //結果的後16位元初始值
	
	w1 = w1 | Vh
	   = 1101 1000 0000 0000
	   |        01 0101 0000
	   = 1101 1001 0101 0000
	   = 0xD950
	
	w2 = w2 | Vl
	   = 1101 1100 0000 0000
	   |        11 0010 0001
	   = 1101 1111 0010 0001
	   = 0xDF21
	
所以这个字 U+64321 最后正确的 UTF-16 编码应该是:
	0xD950 0xDF21
	
而在小尾序中最后的编码应该是：
	0x50D9 0x21DF

按照这个算法，我们来推算一下U+1F604  利用推算来映射出位操作（位操作不是很熟的朋友可网上学习学习）。
0x1F604  =  0001 1111 0110 0000 0100 (二进制)
0x1F604 - 0x10000 = 0xF604 = 1111 0110 0000 0100

分别取0xF604 的高十位和低十位（不足的补0）

Vh =  00 0011 1101 = 0x3D  (高位)
Vl = 10 0000 0100 = 0x204 (低位)

然后取高位与前十六位初始元0xD800 进行或操作后为作UTF16的前部份
取低位与后十六位初始元0xDC00进行或操作后作为UTF16的后半部份。
0x3D | 0xD800 = 0xD83D
0x204 | 0xDC00 = 0xDE04
所以U+1F604 的UTF16 为0xD83D 0xDE04

假设要处理的UNICODE编码为X，来推一下位运算公式
第一步：X - 0x10000  得到结果为Y
第二步：取Y的高十位：Y >> 10   得到结果为Vh
第三步：取Y的低十位：Y  & 3FF(11 1111 1111) 这样就可以把十位前的全部清零了。 得到结果为Vl
第四步：将高位与前16位初始元0xD800 进行或操作 Vh | 0xD800  得到前半部  记为Uf
第五步：将低位与后16位初始元0xDC00进行或操作Vl |0xDC00 得到后半部份。Ue
第六步：将前后两部份合在一起。先左移十六位 (Uf << 16) 再或上Ue 即 (Uf << 16) | Ue

把这个写为宏的形式：
#define UNICODETOUTF16(x)  ((Uf << 16) | Ue) 将这个公式向前代替，最终得到
#define UNICODETOUTF16(x) (((((x - 0x10000) >>10) | 0xD800) << 16)  | (((x-0x10000)&3FF) | 0xDC00))         

同样使用UTF16转回为大于0x10000 的Unicode码；

 #define MULITTHREEBYTEUTF16TOUNICODE(x,y) (((((x ^ 0xD800) << 2) | ((y ^ 0xDC00) >> 8)) << 8) | ((y ^ 0xDC00) & 0xFF)) + 0x10000 
当然这里还有大尾，小尾的区分，我这里就不再说明了，具体学习参考：http://zh.wikipedia.org/wiki/UTF-16


IOS 的提取代码：需实现UITextViewDelegate委托


```objc
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text  
{  
    NSString *hexstr = @"";  
  
    for (int i=0;i< [text length];i++)  
    {  
        hexstr = [hexstr stringByAppendingFormat:@"%@",[NSString stringWithFormat:@"0x%1X ",[text characterAtIndex:i]]];  
    }  
    NSLog(@"UTF16 [%@]",hexstr);  
      
    hexstr = @"";  
      
    int slen = strlen([text UTF8String]);  
      
    for (int i = 0; i < slen; i++)   
    {  
        //fffffff0 去除前面六个F & 0xFF   
        hexstr = [hexstr stringByAppendingFormat:@"%@",[NSString stringWithFormat:@"0x%X ",[text UTF8String][i] & 0xFF ]];  
    }  
    NSLog(@"UTF8 [%@]",hexstr);  
      
    hexstr = @"";  
      
    if ([text length] >= 2) {  
          
        for (int i = 0; i < [text length] / 2 && ([text length] % 2 == 0) ; i++)   
        {  
            // three bytes  
            if (([text characterAtIndex:i*2] & 0xFF00) == 0 ) {  
                hexstr = [hexstr stringByAppendingFormat:@"Ox%1X 0x%1X",[text characterAtIndex:i*2],[text characterAtIndex:i*2+1]];  
            }  
            else  
            {// four bytes    
                hexstr = [hexstr stringByAppendingFormat:@"U+%1X ",MULITTHREEBYTEUTF16TOUNICODE([text characterAtIndex:i*2],[text characterAtIndex:i*2+1])];      
            }  
              
        }  
        NSLog(@"(unicode) [%@]",hexstr);  
    }  
    else  
    {  
        NSLog(@"(unicode) U+%1X",[text characterAtIndex:0]);  
    }  
      
    return YES;  
}  
```

上面代码搞好后在UITEXTVIEW中输入表情符，就会打印出相应的编码了。如果想进一步收集。只需要封装成自己想要的数据格式导出即可。

其中还有softbank的编码未搞懂，小日本的东西。


![](http://img.my.csdn.net/uploads/201303/13/1363165007_4049.jpg)
参考：
UNICODE标准，查找
http://www.unicode.org/
http://www.unicode.org/charts/

Emojin集合表（479）：
http://punchdrunker.github.com/iOSEmoji/table_html/vehicle.html

DEMO:
https://github.com/iodefog/EmojiDemo.git

![](http://punchdrunker.github.com/iOSEmoji/table_html/cars/cars_07_01.png)![](http://punchdrunker.github.com/iOSEmoji/table_html/cars/cars_07_02.png)![](http://punchdrunker.github.com/iOSEmoji/table_html/cars/cars_07_03.png)        UnicodeU+1F1F7 U+1F1FAU+1F1EC U+1F1E7U+1F1E9 U+1F1EA        UTF80xF0 0x9F 0x87 0xB7 0xF0 0x9F 0x87 0xBA0xF0 0x9F 0x87 0xAC 0xF0 0x9F 0x87 0xA70xF0 0x9F 0x87 0xA9 0xF0 0x9F 0x87 0xAA        UTF160xD83C 0xDDF7 0xD83C 0xDDFA0xD83C 0xDDEC 0xD83C 0xDDE70xD83C 0xDDE9 0xD83C 0xDDEA        SB UnicodeE512E510E50E