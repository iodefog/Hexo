title: 禁止输入各种表情符号
date: 2015-06-15 11:44:00
categories: 技术
tags: 
description:
---
``
    [_nameFieldaddTarget:selfaction:@selector(limitLength:)forControlEvents:UIControlEventEditingChanged];

// 限制字数，区别中英文
- (void)limitLength:(UITextField *)sender
{
    bool isChinese;//判断当前输入法是否是中文
    if ([[[UITextInputModecurrentInputMode] primaryLanguage]isEqualToString: @"en-US"]) {
        isChinese = false;
    }
    else
    {
        isChinese = true;
    }
    
    if(sender ==_nameField) {
        // 8位
        NSString *str = [[_nameFieldtext] stringByReplacingOccurrencesOfString:@"?"withString:@""];
        str = [selfdisable_emoji:str];
        if (isChinese) {//中文输入法下
            UITextRange *selectedRange = [_nameFieldmarkedTextRange];
            //获取高亮部分
            UITextPosition *position = [_nameFieldpositionFromPosition:selectedRange.startoffset:0];
            // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
            if (!position) {
                DLog(@"汉字");
                if ( str.length>=kMaxCount) {
                    NSString *strNew = [NSStringstringWithString:str];
                    [_nameFieldsetText:[strNew substringToIndex:kMaxCount]];
                } else {
                    [_nameFieldsetText:str];
                }
            }
            else {
                DLog(@"输入的英文还没有转化为汉字的状态");
                
            }
        }else{
            DLog(@"str=%@;本次长度=%d",str,[strlength]);
            if ([strlength]>=kMaxCount) {
                NSString *strNew = [NSStringstringWithString:str];
                [_nameFieldsetText:[strNew substringToIndex:kMaxCount]];
            }
        }
    }
}

`
``
``
``-
 (``void``)textViewDidChange:(``UITextView``
*)textView``{``    ``NSRange``
textRange = [textView``
selectedRange``];``    ``[textView``
setText``:[``self``
disable_emoji``:[textView``
text``]]];``    ``[textView``
setSelectedRange``:textRange];``}` 
// 详情禁止输入表情符号`-
 (``NSString``
*)disable_emoji:(``NSString``
*)text``{``    ``NSRegularExpression``
*regex = [``NSRegularExpression``
regularExpressionWithPattern``:``@"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]"``
options``:``NSRegularExpressionCaseInsensitive``
error``:nil``];``    ``NSString``
*modifiedString = [regex``
stringByReplacingMatchesInString``:text``                                                              
``options``:``0``                                                                
``range``:NSMakeRange(``0``,
 [text``
length``])``                                                         
``withTemplate``:``@""``];``    ``return``
modifiedString;``}`