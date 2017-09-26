//
//  ConstNSNotificationName.h
//  TestBlueDemo
//
//  Created by sucheng on 2017/6/12.
//  Copyright © 2017年 sucheng. All rights reserved.
//

#import <UIKit/UIKit.h>

//-----------------------------通知名定义-----------------------------------------
/** 收到手环摇一摇指令的通知 */
UIKIT_EXTERN NSNotificationName const DidReceiveBraceletSnakeNotification;
/** 收到实时测量血压的通知 */
UIKIT_EXTERN NSNotificationName const DidReceiveUserRealTimeTestBloodPressureNotification;
/** 已经收到手环时间的通知 */
UIKIT_EXTERN NSNotificationName const DidReceiveBraceletTimeNotification;
/** 收到步数通知 */
UIKIT_EXTERN NSNotificationName const DidReceiveUserStepNotification;
/** 已经收到运动数据的通知 */
UIKIT_EXTERN NSNotificationName const DidReceiveSportDataNotification;
/** 已经收到心率的通知 */
UIKIT_EXTERN NSNotificationName const DidReceiveHeartRateNotification;
/** 已经收到全天心率和活动量的通知 */
UIKIT_EXTERN NSNotificationName const DidReceiveAllDayHeartRateActivityAmountNotification;
/** 已经收到久坐提醒响应值得通知 */
UIKIT_EXTERN NSNotificationName const DidReceiveLongSitResponseNotification;
/** 已经收到防丢功能的响应值通知 */
UIKIT_EXTERN NSNotificationName const DidReceiveAntiLostResponseNotification;
/** 已经收到个性化定制的响应值通知 */
UIKIT_EXTERN NSNotificationName const DidReceivePersonalizedSettingsResponseNotification;
/** 已经收到同步设备个人信息的响应值的通知 */
UIKIT_EXTERN NSNotificationName const DidReceiveSyncPersonalInfomationResponseNotification;
/** 已经收到设置手环时间的响应值的通知 */
UIKIT_EXTERN NSNotificationName const DidReceiveSetBraceletTimeResponseNotification;
/** 已经收到抬手亮屏的响应值的通知 */
UIKIT_EXTERN NSNotificationName const DidReceiveRaiseHandLightScreenResponseNotification;
/** 已经收到手环震动时间的响应值的通知 */
UIKIT_EXTERN NSNotificationName const DidReceiveBraceletShockResponseNotification;
/** 已经收到设置心率报警的响应值的通知 */
UIKIT_EXTERN NSNotificationName const DidReceiveHeartRateAlarmResponseNotification;
/** 收到睡眠数据的通知 */
UIKIT_EXTERN NSNotificationName const DidReceiveUserSleepDataNotification;
/** 版本号的通知 */
UIKIT_EXTERN NSNotificationName const DidReceiveVersionNotification;
/** 收到电池电量的通知 */
UIKIT_EXTERN NSNotificationName const DidReceiveBatteryPowerNotification;

//-----------------------------------------------------------------------------------------

/** 设备连接成功 */
UIKIT_EXTERN NSNotificationName const DeviceConnectSuccess;
/** 设备连接失败 */
UIKIT_EXTERN NSNotificationName const DeviceConnectFail;

/** 上一次连接的外设的identifier */
UIKIT_EXTERN NSNotificationName const  kLastPeripheralIdentifierConnectedKey;
/** 是否绑定 */
UIKIT_EXTERN NSNotificationName const  isBindKey;

