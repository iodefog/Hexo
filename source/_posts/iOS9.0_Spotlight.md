title: iOS9.0 Spotlight 开发
date: 2016-08-11 17:40:00
categories: 技术
tags: 
description:
---
必须是iOS9.0之上的系统，需要导入CoreSpotlight.framework框架。
CSSearchableItemAttributeSet  
CSSearchableItem  
CSSearchableIndex  
先移除，再添加新的索引

	

```objc
/*移除所有sohu索引*/
-(void) removeFromIndexByDomain{
    if([[UIDevice currentDevice] deviceSystemMajorVersion] < 9){
        return;
    }
    NSArray* deleteIdentify = @[@"MyIdentify"];
    [[CSSearchableIndex defaultSearchableIndex ]deleteSearchableItemsWithDomainIdentifiers:deleteIdentify completionHandler:^(NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@ %@",NSStringFromSelector(_cmd),error);
        }
    }];
}

/*将数据写入系统spotLight索引*/
-(void) saveSpotLightItemToIndex:(SpotLightItem*)spotLightItem thumbnailData:(NSData*)thumbnailData{
    if([[UIDevice currentDevice] deviceSystemMajorVersion] < 9){
        return;
    }
    /*从索引中移除*/
    NSArray* deleteIdentify = @[spotLightItem.indentify];
    [[CSSearchableIndex defaultSearchableIndex ]deleteSearchableItemsWithIdentifiers:deleteIdentify completionHandler:^(NSError * _Nullable error) {
        if (error) {
            DDLogWarn(@"deleteSearchableItemsWithIdentifiers: %@",error);
        }
    }];
    CSSearchableItemAttributeSet* oneSet = [[CSSearchableItemAttributeSet alloc]initWithItemContentType:(NSString*)kUTTypeAudiovisualContent];
    CSSearchableItem * item = [[CSSearchableItem alloc]initWithUniqueIdentifier:spotLightItem.indentify domainIdentifier:SOHUSpotLightDomain attributeSet:oneSet];
    oneSet.ratingDescription = @"搜狐视频";
    oneSet.performers = @[@"金秀贤",@"成龙"];
    oneSet.information = @"搜狐视频0";
    oneSet.playCount = @(100);
    oneSet.rating   = @(4);
    oneSet.comment = @"comment";
    oneSet.director = @"director";
    oneSet.producer = @"producer";
    oneSet.copyright = @"copyright";
  /*添加到系统索引中*/
    [[CSSearchableIndex defaultSearchableIndex] indexSearchableItems:@[item] completionHandler:^(NSError * __nullable error) {
        //log
    }];


```



