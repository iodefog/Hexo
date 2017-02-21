title: locationManager 定位地址不准，获取回调更准的方法
date: 2015-07-21 15:01:00
categories: 技术
tags: 
description:
---
原来的写法，这种写法获取第一次返回的结果，然后就会停止更新经纬度


```objc
- （void）operationLocations:(NSArray *)locations{
    [self.locationManager stopUpdatingLocation];
     ....
     ....
}

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations
   [self operationLocations:locations];
}


```



猜想：LocationManager  定位回调会多次回调，及多次纠偏。所以，如果是最后一次，则是最准确的。
了解到：

  // 延迟0.2s执行，如果有新任务，则取消原先的任务。最终只执行最后一次任务。
    [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(todoSomething:) object:sender];
    [self performSelector:@selector(todoSomething:) withObject:sender afterDelay:0.2f];


于是新写法如下：


```objc
- （void）operationLocations:(NSArray *)locations{
    [self.locationManager stopUpdatingLocation];
     ....
     ....
}

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations{
   
  [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(operationLocations:) object:locations];
    [self performSelector:@selector(operationLocations:) withObject:locations afterDelay:0.2f];

}


```



