title: 将事件添加到系统日历中，并且添加到提醒事项中
date: 2014-05-13 10:18:00
categories: 技术
tags: 
description:
---
具体代码如下（代码来着网路）：

/*
1.0版本示例
初始建立将事件添加到系统日历中，并且添加到提醒事项中
 */
/*代码示例
 NSDate*startData=[NSDate dateWithTimeIntervalSinceNow:10];
 NSDate*endDate=[NSDate dateWithTimeIntervalSinceNow:20];
 //设置事件之前多长时候开始提醒
 float alarmFloat=-5;
 NSString*eventTitle=@"提醒事件标题";
 NSString*locationStr=@"提醒副标题";
 //isReminder是否写入提醒事项
 [ZCActionOnCalendar saveEventStartDate:startData endDate:endDate alarm:alarmFloat eventTitle:eventTitle location:locationStr isReminder:YES];
 2014.4.29
 //注意在参数第十八行需要设置不同的参数，然后进行判断是事件提醒还是日历事件
 //EKEntityMaskEvent提醒事项参数（该参数只能真机使用）  EKEntityTypeEvent日历时间提醒参数

 */
#import <Foundation/Foundation.h>

@interface ZCActionOnCalendar : NSObject
+ (void)saveEventStartDate:(NSDate*)startData endDate:(NSDate*)endDate alarm:(float)alarm eventTitle:(NSString*)eventTitle location:(NSString*)location isReminder:(BOOL)isReminder;
@end



#import "ZCActionOnCalendar.h"
#import <EventKit/EventKit.h>
@implementation ZCActionOnCalendar
+ (void)saveEventStartDate:(NSDate*)startData endDate:(NSDate*)endDate alarm:(float)alarm eventTitle:(NSString*)eventTitle location:(NSString*)location isReminder:(BOOL)isReminder{
    //事件市场
    EKEventStore *eventStore = [[EKEventStore alloc] init];
    //6.0及以上通过下⾯面⽅方式写⼊入事件
    if ([eventStore respondsToSelector:@selector(requestAccessToEntityType:completion:)]) {
        //等待用户是否同意授权日历
        //EKEntityMaskEvent提醒事项参数（该参数只能真机使用）  EKEntityTypeEvent日历时间提醒参数
        [eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if (error)
                {
                }else if (!granted)
                {
                    //被⽤用户拒绝,不允许访问⽇日历
                    
                }else{
                    //事件保存到⽇日历
                    //创建事件
                    EKEvent *event = [EKEvent eventWithEventStore:eventStore];
                    event.title = eventTitle;
                    event.location = location;
                    //设定事件开始时间
                    //[NSDate dateWithTimeIntervalSinceNow:10];
                    event.startDate=startData;
                    
                    //设定事件结束时间
                    //[NSDate dateWithTimeIntervalSinceNow:20];
                    event.endDate=endDate;
                    //添加提醒可以添加多个，设定事件多久以前开始提醒
                    // event.allDay = YES;
                    //在事件前多少秒开始事件提醒-5.0f
                    [event addAlarm:[EKAlarm alarmWithRelativeOffset:alarm]];
                    
                    [event setCalendar:[eventStore defaultCalendarForNewEvents]];
                    NSError *err;
                    [eventStore saveEvent:event span:EKSpanThisEvent error:&err];
                    NSLog(@"保存成功");
                    
                    
                    
                    
                    
                    //是否写入提醒事项，提醒事项为iOS原生自带的，但是模拟器没有的
                    if (isReminder) {
                        EKCalendar * iDefaultCalendar = [eventStore defaultCalendarForNewReminders];
                        
                        EKReminder *reminder=[EKReminder reminderWithEventStore:eventStore];
                        reminder.calendar=[eventStore defaultCalendarForNewReminders];
                        
                        reminder.title=eventTitle;
                        reminder.calendar = iDefaultCalendar;
                        EKAlarm *alarm=[EKAlarm alarmWithAbsoluteDate:[NSDate dateWithTimeIntervalSinceNow:-10]];
                        [reminder addAlarm:alarm];
                        NSError *error=nil;
                        
                        
                        [eventStore saveReminder:reminder commit:YES error:&error];
                        if (error) {
                            
                            NSLog(@"error=%@",error);
                            
                        }
                        
                    }
                }
                
            });
        }];
        
    }else{
        //4.0和5.0通过下述⽅方式添加无需判断用户是否同意访问日历
        //事件保存到⽇日历
        //创建事件
        EKEvent *event = [EKEvent eventWithEventStore:eventStore];
        event.title = eventTitle;
        event.location = location;
        //设定事件开始时间
        //[NSDate dateWithTimeIntervalSinceNow:10];
        event.startDate=startData;
        
        //设定事件结束时间
        //[NSDate dateWithTimeIntervalSinceNow:20];
        event.endDate=endDate;
        //添加提醒可以添加多个，设定事件多久以前开始提醒
        // event.allDay = YES;
        //在事件前多少秒开始事件提醒-5.0f
        [event addAlarm:[EKAlarm alarmWithRelativeOffset:alarm]];
        
        [event setCalendar:[eventStore defaultCalendarForNewEvents]];
        NSError *err;
        [eventStore saveEvent:event span:EKSpanThisEvent error:&err];
        NSLog(@"保存成功");
        
        //是否写入提醒事项，提醒事项为iOS原生自带的，但是模拟器没有的
        if (isReminder) {
            EKCalendar * iDefaultCalendar = [eventStore defaultCalendarForNewReminders];
            EKReminder *reminder=[EKReminder reminderWithEventStore:eventStore];
            reminder.calendar=[eventStore defaultCalendarForNewReminders];
            reminder.title=eventTitle;
            reminder.calendar = iDefaultCalendar;
            EKAlarm *alarm=[EKAlarm alarmWithAbsoluteDate:[NSDate dateWithTimeIntervalSinceNow:-10]];
            [reminder addAlarm:alarm];
            NSError *error=nil; 
            [eventStore saveReminder:reminder commit:YES error:&error];
            if (error) {
                NSLog(@"error=%@",error);
            }
        }
    }
}

需要的类库：UIEventKit.framework

