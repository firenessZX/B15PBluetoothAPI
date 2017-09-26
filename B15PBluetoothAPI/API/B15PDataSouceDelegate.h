//
//  B15SPeripheralDelegate.h
//  TestBlueDemo
//
//  Created by sucheng on 2017/6/10.
//  Copyright © 2017年 sucheng. All rights reserved.
//

#import <Foundation/Foundation.h>


@class B15PSleepModel;
@class  HealthDataModel;
@class  WholePointTestModel;

/**
 此协议主要用于将外设发送过来的数据进行处理后传递到控制器
 */
@protocol B15PDataSouceDelegate <NSObject>

@optional

/**
 收到步数的方法

 @param userStep 步数
 */
-(void)didReceiveUserStep:(NSUInteger)userStep;
/**
 收到外设同步过来的睡眠数据

 @param sleepModel 睡眠模型，请查看模型属性
 */
-(void)didReceiveUserSleepData:(B15PSleepModel*)sleepModel;
/**
 收到外设同步的实时血压测量数据

 @param maxValue 血压最大值
 @param minValue 血压最小值
 */
-(void)didReceiveBloodPressureRealTimeTestDataWithMaxValue:(NSUInteger)maxValue withMinValue:(NSUInteger)minValue;

/**
 摇一摇拍照 */
-(void)iPhonedidReceiveShakeInstruction;

/**
 接收到电源模式、电池电量，状态，电量等级的方法

 @param powerMode 电源模式 0 :正常状态(normal status） 1：充电状态（charging）2：低压状态（Low pressure state）3：充满状态（Full of state）
 @param batteryPower 电池电量
 @param status 状态       0：清醒（wide awake）1：睡眠（Sleep）
 @param powerLevel 电量等级 (power Level) 0-4
 */
-(void)didReceivePowerMode:(NSUInteger)powerMode withBatteryPower:(NSUInteger)batteryPower withStatus:(NSUInteger)status withPowerLevel:(NSUInteger)powerLevel;

/**
 收到手环同步过来的时间

 @param year 年
 @param month 月
 @param day 日
 @param hour 时
 @param minute 分
 @param second 秒
 */
-(void)didReceiveBraceletTimeWithYear:(NSUInteger)year withMonth:(NSUInteger)month withDay:(NSUInteger)day withHour:(NSUInteger)hour withMinute:(NSUInteger)minute withSecond:(NSUInteger)second;

/**
 收到运动数据

 @param walkStep 步行数
 @param runStep 跑步数
 @param sportsCategory 运动类别 0:停 1:走 2:跑   0 is stop , 1 is walk , 2 is runing
 @param attitude 姿态 0:坐 1:站   0 is sit down, 1 is stand up
 */
-(void)didReceiveSportsDataWithWalkStep:(NSUInteger)walkStep withRunStep:(NSUInteger)runStep withSportsCategory:(NSUInteger)sportsCategory withAttitude:(NSUInteger)attitude;


/**
 收到心率数据

 @param heartRateValue 心率值
 @param heartRateCondition 心率状况 0 正常 Heart rate is normal   1 心率不齐 Heartbeat
 */
- (void)didReceiveHeartRateValue:(NSUInteger)heartRateValue withheartRateCondition:(NSUInteger)heartRateCondition;

/**
 读取全天心率、活动量

 @param currentData 当前数据条数
 @param totalData 总数据条数
 @param day 日
 @param hour 小时
 @param minute 分钟
 @param sportStep 运动的步数
 @param heartRateValue 心率
 @param highPressure 高压
 @param lowPressure 低压
 */
- (void)didReceiveAllDayHeartRateValueActivityAmountWithCurrentData:(NSUInteger)currentData withTotalData:(NSUInteger)totalData withDay:(NSUInteger)day withHour:(NSUInteger)hour withMinute:(NSUInteger)minute withSportStep:(NSUInteger)sportStep withHeartRateValue:(NSUInteger)heartRateValue withHighPressure:(NSUInteger)highPressure withLowPressure:(NSUInteger)lowPressure;


/**
 久坐提醒响应方法，when you call a method to set up the long sit ,you can pass this delegate method to judge the settings is successul or Failure YES is successful,NO is failure

 @param response 响应值
 */
- (void)LongSitResponse:(BOOL)response;

/**
 防丢功能响应方法 when you call a method to set up the anti-lost ,you can pass this delegate method to judge the settings is successul or Failure YES is successful,NO is failure

 @param response 响应值
 */
- (void)antiLostResponse:(BOOL)response;

/**
 个性化定制模式设定 when you call a method to set up the personalized Settings ,you can pass this delegate method to judge the settings is successul or Failure YES is successful,NO is failure

 @param response 响应值
 */
- (void)personalizedSettingsResponse:(BOOL)response;

/**
 同步设备个人信息 when you call a method to sync information to the device ,you can pass this delegate method to judge the settings is successul or Failure YES is successful,NO is failure

 @param response 响应值
 */
- (void)syncPersonalInformationResponse:(BOOL)response;


/**
 设置手环时间后的响应值方法，when you call a method to set up the bracelet time ,you can pass this delegate method to judge the settings is successful or Failure,YES is successful,NO is failure


 @param response 响应值
 */
- (void)setBraceletTimeResponse:(BOOL)response;


/**
 抬手亮屏的响应值方法 when you call a method to set up Raise your hand on the screen ,you can pass this delegate method to judge the settings is successful or Failure,YES is successful,NO is failure

 @param response 响应值
 */
-(void)raiseHandLightScreenResponse:(BOOL)response;


/**
 已经收到手环震动时间的响应值方法，when you call a method to set up Hand ring vibration time ,you can pass this delegate method to judge the settings is successful or Failure,YES is successful,NO is failure

 @param response 响应值
 */
- (void)braceletShockResponse:(BOOL)response;

/**
 设置心率的报警区间的响应值方法 when you call a method to set up alarm interval of the heart rate ,you can pass this delegate method to judge the settings is successful or Failure,YES is successful,NO is failure

 @param response 响应值
 */
- (void)heartRateAlarmIntervalResponse:(BOOL)response;


@end
