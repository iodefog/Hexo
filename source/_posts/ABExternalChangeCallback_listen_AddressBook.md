title: ABExternalChangeCallback－－－监听AddressBook的变化
date: 2014-08-08 17:07:00
categories: 技术
tags: 
description:
---

1. 添加属性
@property (nonatomic) ABAddressBookRef addressBook;
@synthesize addressBook = _addressBook;

2. 添加ABExternalChangeCallback方法
void addressCallback(ABAddressBookRef addressBook, CFDictionaryRef info, void *context) {
   [_instance unregisterCallback];//or will more than once
    NSLog(@"addressCallback");
    [_instance readAndWriteAddressBooksInBackground];
    
}
注意：程序之外，通讯录被改变是会调用此函数，但只知道通讯录被改变，具体怎么的改变不知道，info始终为null，
而且通讯录里面改变了几条，就会调用几次该监听函数，因此，要在第一次收到改变的时候，就移除监听。

3. 注册监听

- (void)registerCallback {
    
    if (!_addressBook) {
        _addressBook = ABAddressBookCreate();
    }
    
    if (!_hasRegister) {
        ABAddressBookRegisterExternalChangeCallback(_addressBook, addressCallback, self);
        _hasRegister = YES ;
        NSLog(@"registerCallback");
    }

}
注意：要保证_addressBook没有被release，才会调用addressCallback。
而且要保证只调用了一次注册，要是注册多次的话，通讯录中一条信息的改变，也会多次调用监听函数。


4. 移除监听
- (void)unregisterCallback {
    NSLog(@"unRegisterCallback");
    if (_hasRegister) {
        ABAddressBookUnregisterExternalChangeCallback(_addressBook, addressCallback, self);
        _hasRegister = NO;
    }
}

