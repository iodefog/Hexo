title: ios 读取大文件
date: 2015-08-07 18:28:00
categories: 技术
tags: 
description:
---

```objc
//读取文件内容操作- (void) loadFileContentsIntoTextView{
 
 
//通过流打开一个文件
 
NSInputStream *inputStream = [[NSInputStream alloc] initWithFileAtPath: filePath];
 
[inputStream open];
 

NSInteger maxLength = 128;
uint8_t readBuffer [maxLength];
//是否已经到结尾标识
BOOL endOfStreamReached = NO;
// NOTE: this tight loop will block until stream ends
while (! endOfStreamReached)
{
NSInteger bytesRead = [inputStream read: readBuffer maxLength:maxLength];
if (bytesRead == 0)
{//文件读取到最后
endOfStreamReached = YES;
}
else if (bytesRead == -1)
{//文件读取错误
endOfStreamReached = YES;
}
else
{
NSString *readBufferString =[[NSString alloc] initWithBytesNoCopy: readBuffer length: bytesRead encoding: NSUTF8StringEncoding freeWhenDone: NO];   
//将字符不断的加载到视图
[self appendTextToView: readBufferString];
[readBufferString release];
}
}
[inputStream close];
[inputStream release];
}
 

```

```objc


```
异步文件的读取 ，在网络方面，由于网络的不可靠性可能会造成NSFileManager的文件操作方法的阻塞，而以流的方式进行操作则可以实现异步的读取。NSStream是可以异步工作的。可以注册一个在流中有字节可读的时候回调的函数，如果没有可读的，就不要阻塞住，回调出去。

