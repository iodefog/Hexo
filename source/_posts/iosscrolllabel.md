title: iOS 滚动label（LED，跑马灯等）  快速实现源码
date: 2015-07-29 17:31:00
categories: 技术
tags: 
description:
---
ios  滚动label  快速实现源码。这里使用的两个label，挪动frame实现。简单使用，这里仅抛砖引玉而已



![](http://img.blog.csdn.net/20150729173309798?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQv/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center)

<!--more-->


```objc
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSString *str = @"I love you，IOS-文字滚动的Label!";
    
    self.scrollLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,100,self.view.frame.size.width, 44)];
    self.scrollLabel.text = str;
    [self.view addSubview:self.scrollLabel];

    
    self.secondLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.scrollLabel.frame.origin.x+self.scrollLabel.frame.size.width, self.scrollLabel.frame.origin.y, self.scrollLabel.frame.size.width, self.scrollLabel.frame.size.height)];
    self.secondLabel.font = self.scrollLabel.font;
    self.secondLabel.text = self.scrollLabel.text;
    [self.view addSubview:self.secondLabel];
    
    [self addAnimation];
//    [[NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(addAnimation) userInfo:nil repeats:YES] fire];
}

- (void)addAnimation{
    CGRect scrollFrame = self.scrollLabel.frame;
    CGRect secondFrame = self.secondLabel.frame;
    
    [UIView animateWithDuration:4 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.scrollLabel.frame = CGRectMake(-self.scrollLabel.frame.size.width, self.scrollLabel.frame.origin.y, self.scrollLabel.frame.size.width, self.scrollLabel.frame.size.height);
        self.secondLabel.frame = CGRectMake(0, self.secondLabel.frame.origin.y, self.secondLabel.frame.size.width, self.secondLabel.frame.size.height);
    } completion:^(BOOL finished) {
        self.scrollLabel.frame = scrollFrame;
        self.secondLabel.frame = secondFrame;
        [self addAnimation];
    }];
}
```

