title: 整理和收集一些知识和技巧
date: 2014-05-16 09:59:00
categories: 技术
tags: 
description:
---
``//`UIWebview 如何自适应高度``-
 (``void``)webViewDidFinishLoad:(``UIWebView``*)webView
 { ``//webview
 自适应高度``    ``CGRect``frame
 = webView``.frame``;``    ``CGSize``fittingSize
 = [webView``
sizeThatFits``:CGSizeZero];``    ``frame``.size``=
 fittingSize;``    ``webView``.frame``=
 frame; ``    ``//tableView
 reloadData``}``
```//判断用户是否禁止该App使用设备麦克风
//从iOS 7开始，如果App需要用到设备的麦克风，会弹出一个对话框询问用户。这段代码可以检测到用户是否拒绝该App使用麦克风，从而弹出提示框，提示用户去设置那里开启。if ([[AVAudioSession sharedInstance] respondsToSelector:@selector(requestRecordPermission:)]) {
        [[AVAudioSession sharedInstance] performSelector:@selector(requestRecordPermission:) withObject:^(BOOL granted) {
            if (granted) {
                // Microphone enabled code
                NSLog(@"Microphone is enabled..");
            }
            else {
                // Microphone disabled code
                NSLog(@"Microphone is disabled..");
                
                // We're in a background thread here, so jump to main thread to do UI work.
                dispatch_async(dispatch_get_main_queue(), ^{
                    [[[UIAlertView alloc] initWithTitle:@"Microphone Access Denied"
                                                 message:@"This app requires access to your device's Microphone.\n\nPlease enable Microphone access for this app in Settings / Privacy / Microphone"
                                                delegate:nil
                                       cancelButtonTitle:@"Dismiss"
                                       otherButtonTitles:nil] show];
                });
            }
        }];
    }

#

#

#

#禁止输入表情符号
有效禁止用户各种方法输入表情符号、、

123456789101112131415161718192021222324252627282930313233343536373839`//``// 
 ViewController.m``// 
 test``//``// 
 Created by 郭宇 on 13-11-15.``// 
 Copyright (c) 2013年 郭 宇. All rights reserved.``//` `#import
 "ViewController.h"` `@implementation``
ViewController``{``    ``IBOutlet``
UITextView``
*textinput;``}` `-
 (``void``)viewDidLoad``{``    ``[``super``
viewDidLoad``];``    ``[textinput``
setDelegate``:``self``];``}` `-
 (``void``)textViewDidChange:(``UITextView``
*)textView``{``    ``NSRange``
textRange = [textView``
selectedRange``];``    ``[textView``
setText``:[``self``
disable_emoji``:[textView``
text``]]];``    ``[textView``
setSelectedRange``:textRange];``}` `-
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
modifiedString;``}` `@end`
