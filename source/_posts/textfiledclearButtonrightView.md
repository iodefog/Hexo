title: TextFiled 修改clearButton 图片按钮， 非rightView
date: 2016-10-28 12:20:00
categories: 技术
tags: 
description:
---

TextFiled 修改clearButton 图片按钮， 非rightView

<!--more-->


```objc
UIButton *clearButton = [_textField valueForKey:@"_clearButton"];
    if (clearButton && [clearButton isKindOfClass:[UIButton class]]) {

        if ([DKNightVersionManager currentThemeVersion] == DKThemeVersionNormal) {
            [clearButton setImage:[UIImage imageNamed:@"Search-Topba-Close"] forState:UIControlStateNormal];
            [clearButton setImage:[UIImage imageNamed:@"Search-Topba-Close-Night"] forState:UIControlStateHighlighted];
        }else {
            [clearButton setImage:[UIImage imageNamed:@"Search-Topba-Close-Night"] forState:UIControlStateNormal];
            [clearButton setImage:[UIImage imageNamed:@"Search-Topba-Close-Highted-Night"] forState:UIControlStateHighlighted];
        }
    }

```



