title: IAP最佳实践
date: 2014-08-20 17:30:00
categories: 技术
tags: 
description:
---
转自：http://www.cocoachina.com/applenews/devnews/2014/0818/9407.html

IAP最佳实践
该文档是苹果8月5号发布的新Technical Note--[In-App Purchase Best Practices](https://developer.apple.com/library/ios/technotes/tn2387/_index.html#//apple_ref/doc/uid/DTS40014795)，最要描述了iOS 和 OS X 应用程序中的IAP的最佳实践。
 
以下是推荐给开发者的IAP最佳实践列表。
 
在应用启动时添加一个交易队列观察者
应用程序调用StoreKit把观察者链接到payment queue。
1. [[SKPaymentQueue defaultQueue] addTransactionObserver:your_observer]; 

<!--more-->


在恢复或者运行你的app应用时，如果支付队列的内容发生了变化，StoreKit则会自动通知你（注册的）观察者 在应用启动时添加观察者确保它在所有app启动时都会存在，这将允许你的应用能接收到所有的payment queue提醒。
 
考虑应用程序这样一个情况，在向队列（如表1）添加支付请求前，应用的 DetailViewController 类创建了一个观察者。这个观察者的存在时间和 DetailViewController 实例一样长。如果出现中断情况，比如网络失败，那么app将不能完成购买流程，而相关的交易仍在支付队列中。当app正常恢复后，它将没有观察者存在，因为在应用被发送至后台时，上述观察者就已经被解除了。因此，你的应用将不会收到队列中的交易通知。
 
列表 1.不遵循实现交易观察者最佳实践：当用户尝试购买产品时,应用为 payment queue 添加观察者：
1. @implementation DetailViewController 
2.                   .... 
3.   
4. // Called when a customer attempts to purchase a product 
5. - (IBAction)purchase:(id)sender 
6. { 
7.     // Register an observer to the payment queue 
8.     [[SKPaymentQueue defaultQueue] addTransactionObserver:self]; 
9.   
10.     // Create a payment request 
11.     SKMutablePayment *payment = [SKMutablePayment paymentWithProduct:self.product]; 
12.   
13.     // Submit the payment request to the payment queue 
14.     [[SKPaymentQueue defaultQueue] addPayment:payment]; 
15. } 
16.              .... 
17. @end 

列表 2.遵循注册交易观察者的最佳实践
1. @implementation AppDelegate 
2.   
3. - (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions 
4. { 
5.     // Attach an observer to the payment queue 
6.     [[SKPaymentQueue defaultQueue] addTransactionObserver:self]; 
7.     **return** YES; 
8. } 
9.   
10. // Called when the application is about to terminate 
11. - (**void**)applicationWillTerminate:(UIApplication *)application 
12. { 
13.      // Remove the observer 
14.     [[SKPaymentQueue defaultQueue] removeTransactionObserver:self]; 
15. } 
16.   
17.             .... 
18. @end 

StoreKit 在app调用时从payment queue移除观察者： 
 
同样，如果没有从 payment queue 移除观察者，StoreKit 将会试图通知上述观察者，从而导致应用崩溃，好像观察者已经不复存在了。
 
在展示应用内商店UI之前向App Store询问产品信息
在决定在用户界面中展示可购买商品之前，你的应用必须首先向App Store发送一个产品请求。发送产品请求可让你确定产品是否可在App Store中出售，从而阻止展示不能购买的产品。可查看[Retrieving Product Information](https://developer.apple.com/library/ios/documentation/NetworkingInternet/Conceptual/StoreKitGuide/Chapters/ShowUI.html#//apple_ref/doc/uid/TP40008267-CH3-SW9)学习如何创建一个产品请求。App Store使用 SKResponse 对象响应产品请求，使用其 products 属性来更新你的UI，以确保你的用户只能看到App Store中可供销售的产品。
 
列表 3.不遵循IAP产品展示最佳实践：在展示可销售产品后， APP向App Store询问相关产品信息。
1. // App first displays a product for sale, then queries the App Store about it when a customer attempts to purchase it 
2. - (IBAction)purchase:(id)sender 
3. { 
4.     // Create a set for your product identifier 
5.     NSSet *productSet = [NSSet setWithObject:@"your_product_identifier"]; 
6.     // Create a product request object and initialize it with the above set 
7.     SKProductsRequest *request = [[SKProductsRequest alloc] initWithProductIdentifiers:productSet]; 
8.   
9.     request.delegate = self; 
10.     // Send the request to the App Store 
11.     [request start]; 
12. } 
13.   
14.   
15.   
16. // Get the App Store's response 
17. - (**void**)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response 
18. { 
19.    // No purchase will take place if there are no products available for sale. 
20.   // As a result, StoreKit won't prompt your customer to authenticate their purchase. 
21.    **if** ([response.products count] > 0) 
22.    { 
23.         SKProduct *product = (SKProduct *)[response.products objectAtIndex:0]; 
24.   
25.         // The product is available, let's submit a payment request to the queue 
26.         SKMutablePayment *payment = [SKMutablePayment paymentWithProduct:product]; 
27.         [[SKPaymentQueue defaultQueue] addPayment:payment]; 
28.     } 
29. } 

列表 4.  遵循IAP产品展示最佳实践
1. -(**void**)fetchProductInformationForIds:(NSArray *)productIds 
2. { 
3.     // Create a set for your product identifier 
4.     NSSet *mySet = [NSSet setWithObject:your_product_identifier]; 
5.   
6.     // Create a product request object and initialize it with the above set 
7.     SKProductsRequest *request = [[SKProductsRequest alloc] initWithProductIdentifiers:mySet]; 
8.   
9.     request.delegate = self; 
10.   
11.     // Send the request to the App Store 
12.     [request start]; 
13. } 
14.   
15.   
16. //Get the App Store's response 
17. - (**void**)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response 
18. { 
19.     **if** ([response.products count] > 0) 
20.     { 
21.         // Use availableProducts to populate your UI 
22.         NSArray *availableProducts = response.products; 
23.     } 
24. } 

为restoring products提供一个UI
如果你的应用出售 non-consumable、auto-renewable subscription 或者 non-renewing subscription产品，那你必须提供一个允许恢复它们的UI。可以查看[Differences Between Product Types](https://developer.apple.com/library/ios/documentation/NetworkingInternet/Conceptual/StoreKitGuide/Chapters/Products.html#//apple_ref/doc/uid/TP40008267-CH2-SW5) 和[Restoring Purchased Products](https://developer.apple.com/library/ios/documentation/NetworkingInternet/Conceptual/StoreKitGuide/Chapters/Restoring.html#//apple_ref/doc/uid/TP40008267-CH8-SW9)获得更多信息。
 
处理交易
调用 StoreKit 为 payment queue 添加支付请求：
1. [[SKPaymentQueue defaultQueue] addPayment:your_payment]; 

队列创建交易对象来处理这个请求。当交易状态改变时，StoreKit通过调用 paymentQueue: updatedTransactions: 来通知你的观察者。
 
[In-App Purchase Programming Guide>
 Delivering Products> Table 4-1 Transaction statuses and corresponding actions](https://developer.apple.com/library/ios/documentation/NetworkingInternet/Conceptual/StoreKitGuide/Chapters/DeliverProduct.html#//apple_ref/doc/uid/TP40008267-CH5-SW4)列出了每个交易可能存在的4种交易状态。要确保观察者的 paymentQueue: updatedTransactions: 可以在任何时间响应这些状态。如果IAP产品是由苹果托管的，那么需在在观察者上实现 paymentQueue:updatedDownloads: 方法。
 
提供付费内容
当收到一个状态是 SKPaymentTransactionStatePurchased 或者 SKPaymentTransactionStateRestored 的交易时，应用程序将会向用户交付内容或者解锁app的功能。这些状态表明已经接收到可售产品的付款。用户也希望应用能提供付费内容。
 
如果你的购买产品包括App Store托管内容，要确保调用 SKPaymentQueue's startDownloads: 下载内容。可查看[Unlocking App Functionality](https://developer.apple.com/library/ios/documentation/NetworkingInternet/Conceptual/StoreKitGuide/Chapters/DeliverProduct.html#//apple_ref/doc/uid/TP40008267-CH5-SW20)和[Delivering Associated Content](https://developer.apple.com/library/ios/documentation/NetworkingInternet/Conceptual/StoreKitGuide/Chapters/DeliverProduct.html#//apple_ref/doc/uid/TP40008267-CH5-SW9)获得更多信息。
 
完成交付
交易将会保存在支付队列中直到它们被移除。每次启动应用或者从后台恢复时，StoreKit将会调用观察者的 paymentQueue: updatedTransactions: 直到它们被移除。大意是你的用户可能反复请求验证它们的购买，或者被阻止购买你的产品。
 
调用 finishTransaction: 从队列中移除交易。完成的交易是不可恢复的，因此你务必提供内容，下载所有苹果托管的产品内容，或者在完成交易前完成你的购买流程。查看[Finishing the Transaction](https://developer.apple.com/library/ios/documentation/NetworkingInternet/Conceptual/StoreKitGuide/Chapters/DeliverProduct.html#//apple_ref/doc/uid/TP40008267-CH5-SW10)获得更多信息。
 
测试IAP的实现
要确保在把应用提交审核之前彻底测试IAP的实现。可在 [Suggested Testing Steps](https://developer.apple.com/library/ios/documentation/NetworkingInternet/Conceptual/StoreKitGuide/Chapters/DeliverProduct.html#//apple_ref/doc/uid/TP40008267-CH5-SW12) 查看多测试场景，在 [Frequently Asked Questions](https://developer.apple.com/library/ios/technotes/tn2259/_index.html#//apple_ref/doc/uid/DTS40009578-CH1-FREQUENTLY_ASKED_QUESTIONS) 查看各种疑难解答。
 
参考：
[In-App Purchase Programming Guide](https://developer.apple.com/library/ios/documentation/NetworkingInternet/Conceptual/StoreKitGuide/Introduction.html)
 
[Adding In-App Purchase to your iOS and OS X Applications](https://developer.apple.com/library/ios/technotes/tn2259/_index.html#//apple_ref/doc/uid/DTS40009578-CH1-FREQUENTLY_ASKED_QUESTIONS)
 
[WWDC 2012: Selling Products with Store Kit](https://developer.apple.com/videos/wwdc/2012/?id=302)
 
[WWDC 2012: Managing Subscriptions with In-App Purchase](https://developer.apple.com/videos/wwdc/2012/?id=308)
 
[WWDC 2013: Using Store Kit for In-App Purchases](https://developer.apple.com/videos/wwdc/2013/?id=305)
 
[WWDC 2014: Optimizing In-App Purchases](https://developer.apple.com/videos/wwdc/2014/#303)
