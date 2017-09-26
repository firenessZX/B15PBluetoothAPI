//
//  ConstNSNotificationName.m
//  TestBlueDemo
//
//  Created by sucheng on 2017/6/12.
//  Copyright © 2017年 sucheng. All rights reserved.
//

#import "ConstNSNotificationName.h"


/** 收到手环摇一摇指令的通知 */
NSNotificationName const DidReceiveBraceletSnakeNotification       =  @"DidReceiveBraceletSnakeNotification";
/** 收到实时测量血压的通知 */
NSNotificationName const DidReceiveUserRealTimeTestBloodPressureNotification = @"DidReceiveUserRealTimeTestBloodPressureNotification";
/** 已经收到手环时间的通知 */
 NSNotificationName const DidReceiveBraceletTimeNotification        =  @"DidReceiveBraceletTimeNotification";
/** 收到步数通知 */
  NSNotificationName const DidReceiveUserStepNotification    =   @"DidReceiveUserStepNotification";
/** 已经收到运动数据的通知 */
 NSNotificationName const DidReceiveSportDataNotification   = @"DidReceiveSportDataNotification";
/** 已经收到心率的通知 */
 NSNotificationName const DidReceiveHeartRateNotification   = @"DidReceiveHeartRateNotification";
/** 已经收到全天心率和活动量的通知 */
 NSNotificationName const DidReceiveAllDayHeartRateActivityAmountNotification   = @"DidReceiveAllDayHeartRateActivityAmountNotification";
/** 已经收到久坐提醒响应值得通知 */
 NSNotificationName const DidReceiveLongSitResponseNotification    = @"DidReceiveLongSitResponseNotification";
/** 已经收到防丢功能的响应值通知 */
 NSNotificationName const DidReceiveAntiLostResponseNotification    = @"DidReceiveAntiLostResponseNotification";
/** 已经收到个性化定制的响应值通知 */
 NSNotificationName const DidReceivePersonalizedSettingsResponseNotification   = @"DidReceivePersonalizedSettingsResponseNotification";
/** 已经收到同步设备个人信息的响应值的通知 */
NSNotificationName const DidReceiveSyncPersonalInfomationResponseNotification   =@"DidReceiveSyncPersonalInfomationResponseNotification";
/** 已经收到设置手环时间的响应值的通知 */
 NSNotificationName const DidReceiveSetBraceletTimeResponseNotification    =@"DidReceiveSetBraceletTimeResponseNotification";
/** 已经收到抬手亮屏的响应值的通知 */
 NSNotificationName const DidReceiveRaiseHandLightScreenResponseNotification    =@"DidReceiveRaiseHandLightScreenResponseNotification";
/** 已经收到手环震动时间的响应值的通知 */
 NSNotificationName const DidReceiveBraceletShockResponseNotification   =@"DidReceiveBraceletShockResponseNotification";
/** 已经收到设置心率报警的响应值的通知 */
 NSNotificationName const DidReceiveHeartRateAlarmResponseNotification  =@"DidReceiveHeartRateAlarmResponseNotification";
/** 收到睡眠数据的通知 */
  NSNotificationName const DidReceiveUserSleepDataNotification      =   @"DidReceiveUserSleepDataNotification";
/** 版本号的通知 */
  NSNotificationName const DidReceiveVersionNotification            =   @"DidReceiveVersionNotification";
/** 收到电池电量的通知 */
  NSNotificationName const DidReceiveBatteryPowerNotification       =   @"DidReceiveBatteryPowerNotification";

//------------------------------------------------------------------------------------------

/** 设备连接成功 */
 NSNotificationName const DeviceConnectSuccess=@"DeviceConnectSuccess";
/** 设备连接失败 */
 NSNotificationName const DeviceConnectFail=@"DeviceConnectFail";
/** 上一次连接的外设的identifier */
NSNotificationName  const kLastPeripheralIdentifierConnectedKey= @"kLastPeripheralIdentifierConnectedKey";
/** 是否绑定 */
NSNotificationName  const isBindKey= @"isBindKey";


