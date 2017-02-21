title: iOS 7/8--uitextfield动态限制输入的字数
date: 2015-04-01 13:09:00
categories: 技术
tags: 
description:
---
1、定义一个事件:


```objc
-(IBAction)limitLength:(UITextField *)sender
{
    bool isChinese;//判断当前输入法是否是中文
    if([[[UITextInputMode currentInputMode] primaryLanguage] isEqualToString: @"en-US"]) {
        isChinese = false;
    }
    else
    {
        isChinese = true;
    }
     
    if(sender == self.txtName) {
        // 8位
        NSString *str = [[self.txtName text] stringByReplacingOccurrencesOfString:@"?"withString:@""];
        if(isChinese) { //中文输入法下
                UITextRange *selectedRange = [self.txtName markedTextRange];
                //获取高亮部分
                UITextPosition *position = [self.txtName positionFromPosition:selectedRange.start offset:0];
                // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
                if(!position) {
                    NSLog(@"汉字");
                    if( str.length>=9) {
                        NSString *strNew = [NSString stringWithString:str];
                        [self.txtName setText:[strNew substringToIndex:8]];
                    }
                }
                else
                {
                    NSLog(@"输入的英文还没有转化为汉字的状态");
                 
                }
        }else{
            NSLog(@"str=%@; 本次长度=%d",str,[str length]);
            if([str length]>=9) {
                NSString *strNew = [NSString stringWithString:str];
                [self.txtName setText:[strNew substringToIndex:8]];
            }
        }
    }
}

```

2、对UITextField控件添加监听事件：


```objc
//UIControlEventEditingChanged

```

```objc
[self.txtName addTarget:self action:@selector(limitLength:) forControlEvents:UIControlEventEditingChanged];

```





