title: iOS 检测手机是否安装SIM卡
date: 2015-06-16 10:52:00
categories: 技术
tags: 
description:
---
[CTSIMSupportGetSIMStatus() isEqualToString:kCTSIMSupportSIMStatusNotInserted]
可以判断是否插入了sim卡。
需要CoreTelephony.framework。



```objc
/**
 *  检测是否有SIM卡
 * [CTSIMSupportGetSIMStatus() isEqualToString:kCTSIMSupportSIMStatusNotInserted]
 */
extern NSString* const kCTSMSMessageReceivedNotification;
extern NSString* const kCTSMSMessageReplaceReceivedNotification;
extern NSString* const kCTSIMSupportSIMStatusNotInserted;   // 为插入SIM卡
extern NSString* const kCTSIMSupportSIMStatusReady;         // 已插入SIM卡

id CTTelephonyCenterGetDefault(void);
void CTTelephonyCenterAddObserver(id,id,CFNotificationCallback,NSString*,void*,int);
void CTTelephonyCenterRemoveObserver(id,id,NSString*,void*);
int CTSMSMessageGetUnreadCount(void);

int CTSMSMessageGetRecordIdentifier(void * msg);
NSString * CTSIMSupportGetSIMStatus();
NSString * CTSIMSupportCopyMobileSubscriberIdentity();

id  CTSMSMessageCreate(void* unknow/*always 0*/,NSString* number,NSString* text);
void * CTSMSMessageCreateReply(void* unknow/*always 0*/,void * forwardTo,NSString* text);

void* CTSMSMessageSend(id server,id msg);

NSString *CTSMSMessageCopyAddress(void *, void *);
NSString *CTSMSMessageCopyText(void *, void *);
```


注意：苹果会认为这是一个私有方法


