title: ios 用其他app打开文件
date: 2016-01-14 11:31:00
categories: 技术
tags: 
description:
---
// 下面代码为打开弹框，效果图如下：


```objc
- (IBAction)buttonClicked:(id)sender {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [paths firstObject];
    NSString *cachePath = nil;
    NSFileManager *manager = [NSFileManager defaultManager] ;
    if (![manager fileExistsAtPath:documentPath]) {
        NSLog(@"没有文件");
    }else {
        NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:documentPath  ] objectEnumerator];
        NSString *fileName = nil;
        while ((fileName = [childFilesEnumerator nextObject]) != nil ){
            NSString* fileAbsolutePath = [documentPath stringByAppendingPathComponent:fileName];
            BOOL isDirectory = NO;
            NSLog(@"filePath %@", fileName);
            cachePath = [NSString stringWithFormat:@"%@/%@",documentPath, fileName];
            if ([manager fileExistsAtPath:fileAbsolutePath isDirectory:&isDirectory]){
                NSDictionary *dic =  [manager attributesOfItemAtPath:fileAbsolutePath error:nil] ;
                NSLog(@"%@", dic);
            }
            break;
        }
    }
    
    
    UIDocumentInteractionController *documentController = [UIDocumentInteractionController interactionControllerWithURL:[NSURL fileURLWithPath:cachePath]];
    documentController.delegate = self;
    [documentController presentOpenInMenuFromRect:CGRectZero inView:self.view animated:YES];
}


-(void)documentInteractionController:(UIDocumentInteractionController *)controller  willBeginSendingToApplication:(NSString *)application{
    
    
}


-(void)documentInteractionController:(UIDocumentInteractionController *)controller didEndSendingToApplication:(NSString *)application{
    
}


-(void)documentInteractionControllerDidDismissOpenInMenu:(UIDocumentInteractionController *)controller{
    
}

```
![](http://img.blog.csdn.net/20160114121914335)


如果需要自己的应用也支持别的应用调用：则需要配置info.plist 如下：
![]()![](http://img.blog.csdn.net/20160114122715580?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQv/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center)



效果图：
![](http://img.blog.csdn.net/20160114122208037)

