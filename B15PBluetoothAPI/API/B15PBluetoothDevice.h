//
//  B15SBluetoothDevice.h
//  TestBlueDemo
//
//  Created by sucheng on 2017/6/10.
//  Copyright © 2017年 sucheng. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <CoreBluetooth/CoreBluetooth.h>

#import "StatusTpye.h"

@interface B15PBluetoothDevice : NSObject

//** 外设 */
@property(nonatomic,strong,readonly)CBPeripheral * peripheral;

//** 写入特征 */
@property(nonatomic,strong,readonly)CBCharacteristic * writeCharacter;

/**
 单利方法，此方法返回一个唯一实例，通过此单利进行发送指令到设备
 */
+(instancetype)sharedInstance;

/**
 中英文切换指令 switch language

 @param languageConfig 0:中文(Chinese)  1：英文(English)   2：读取状态(statusRead)
 */
-(void)switchLanguageWithConfig:(NSUInteger)languageConfig;

/**
 手环查找手机指令 bracelet Search iPhone command
 */
-(void)braceletSearchiPhone;


/**
 摇一摇拍照，shake Bracelet and the iPhone will receive a value the B15PDataSouceDelegate will carry this value , and You can achieve camera

 @param swit YES:turn on    NO: turn off
 */
-(void)shakeBraceletTakePictureWithSwitch:(BOOL)swit;

/**
 测量血压 （ measure blood pressure）

 @param confi 0:关闭血压测量 turn off the blood pressure measurement     1：打开血压测量    turn on the blood pressure measurement
 */
-(void)bloodPressureMeasureWithConfig:(NSUInteger)confi;


/**
 个性化定制设置 （personalized Settings）

 @param swit 0 ：关闭 （turn off）  1：打开 (turn on)
 @param maxBloodPressure 最大血压值
 @param minBloodPressure 最小血压值
 */
-(void)personalizedSettingsWithSwitch:(BOOL)swit withMaxBloodPressure:(NSUInteger)maxBloodPressure withMinBloodPressure:(NSUInteger)minBloodPressure;


/**
 获取电池状态和电池电量  （read the bracelet battery status and power ）
 */
-(void)getBatteryPower;


/**
 手环无线固件升级 (Bracelet Wireless Firmware Upgrade)

 @param code 1 ---- APP 向手环发送固件升级命令 (Send a firmware upgrade command to the bracelet) 2 ---- APP 向手环发送查询版本号命令 (Send the query version number command to the bracelet)
 */
- (void)BraceletWirelessFirmwareUpgradeWithCode:(NSUInteger)code;


/**
 *  同步设备个人信息 ( sync device personal information )
 *
 *  @param height   身高
 *  @param weight   体重
 *  @param age      年龄
 *  @param sex      性别
 *  @param goldStep 目标步数
 */

- (void)synchronizeDevicePersonalInformationWithHeight:(NSUInteger)height withWeight:(NSUInteger)weight withAge:(NSUInteger)age withSex:(NSUInteger)sex withGoldStep:(NSUInteger)goldStep;

/**
 读取生产编号 (get the bracelet puoduction number)
 */
- (void)readTheProductionNumber;

/**
 设置手环时间 (set the bracelet time)

 @param year 年
 @param month 月
 @param day 日
 @param hour 时
 @param minute 分
 @param second 秒
 @param type 格式 0 or 1 , 0 is 12—hours system time ,1 is 24—hours system time
 */
- (void)setTheBraceletTimeWithYear:(NSUInteger)year withMonth:(NSUInteger)month withDay:(NSUInteger)day withHour:(NSUInteger)hour withMinute:(NSUInteger)minute withSecond:(NSUInteger)second withType:(NSUInteger)type;


/**
 读取手环时间  (get the bracelet time)
 */
- (void)readTheBraceletTime;

/**
 读取记步数 （Read the number of steps）
 0----当天的计步数 current day of the steps
 1----前1天的计步总数 yesterday of the steps
 2----前2天的计步总数 The day before yesterday of the steps
 3----打开实时发送计步 turn on the realtime send  steps
 4----关闭实时发送计步 turn off the realtiem send steps
 @param day 天数（days）
 */
- (void)readTheNumberofStepsWithDay:(NSUInteger)day;


/**
 读取运动数据 （Read motion data）
 */
- (void)readMotionData;

/**
 抬手亮屏 (Raise your hand on the screen)

 @param swit 开关 turn off or turn on
 */
- (void)raiseHandLightScreenWithSwitch:(BOOL)swit;

/**
  设置手环闹钟,闹钟时间根据手环上的小时制来设定，例如：手环是24小时制显示，那么如果要设置下午14点30分的闹钟，小时的就是14,分钟就是30.You can only set up to three alarms，Alarm clock time according to the hour ring on the ring to set, for example: bracelet is 24-hour display, then if you want to set the alarm clock 14:30 pm, the hour is 14, minutes is 30

 @param firstAlarmHour      第一个闹钟的小时    the hour of first alarm
 @param firstAlarmMinute    第一个闹钟的分钟    the minute of first alarm
 @param firstAlarmSwitch    第一个闹钟的开关    the switch of first alarm
 @param secondAlarmHour     第二个闹钟的小时    the hour of second alarm
 @param secondAlarmMinute   第二个闹钟的分钟    the minute of second alarm
 @param secondAlarmSwitch   第二个闹钟的开关    the switch of second alarm
 @param thirdAlarmHour      第三个闹钟的小时    the hour of third alarm
 @param thirdAlarmMinute    第三个闹钟的分钟    the minute of third alarm
 @param thirdAlarmSwitch    第三个闹钟的开关    the switch of third alarm
 @param type 0 ：清除手环闹钟震动设置 1：手环震动模式  6:手环回复当前闹钟设置状态
 */
- (void)setFirstAlarmTimeWithHour:(NSUInteger)firstAlarmHour
                          withFirstAlarmMinute:(NSUInteger)firstAlarmMinute
                          withFirstAlarmSwitch:(BOOL)firstAlarmSwitch
                 withSecondAlarmHour:(NSUInteger)secondAlarmHour
               withSecondAlarmMinute:(NSUInteger)secondAlarmMinute
               withSecondAlarmSwitch:(BOOL)secondAlarmSwitch
                  withThirdAlarmHour:(NSUInteger)thirdAlarmHour
                withThirdAlarmMinute:(NSUInteger)thirdAlarmMinute
                withThirdAlarmSwitch:(BOOL)thirdAlarmSwitch
                            withType:(NSUInteger)type;


/**
 设置心率报警区间 （Set Heart rate alarm interval）

 @param maxHeart 心率上限 （Heart rate limit）
 @param minHeart 心率下限 （Lower heart rate）
 @param con      参数     param
 con:   0 关闭心率报警功能 （Turn off the heart rate alarm function）
 con:   1 打开心率报警功能 （Open the heart rate alarm function）
 con:   2 设置心率报警功能 （Set the heart rate alarm function）
 con:   3 读取心率报警功能 （Read heart rate alarm function）
 */
- (void)setHeartRateAlarmIntervalWithMaxHeart:(NSUInteger)maxHeart withMinHeart:(NSUInteger)minHeart withConfig:(NSUInteger)con;


/**
 蓝牙配对 （BluetoothPairing）

 @param isPairing 是否配对
 */
- (void)BluetoothPairing:(BOOL)isPairing;


/**
 读取当前心率 （Read the current heart rate）

 @param swit 0: 心率关闭 （Heart rate is off） 1: 心率打开（Heart rate is open）
 @param conf 
               0: 心率灯不亮,但是LDO是打开的 （The heartbeat does not light, but the LDO is open）
               1 心率灯亮度最低 （Heart rate lamp brightness is the lowest）
               2 心率灯亮度中等 （Heart rate lamp brightness medium）
               7 心率灯亮度最高 （Heart rate lamp brightness the highest）
 */
- (void)ReadTheCurrentHeartRateWithSwitch:(BOOL)swit withConfig:(NSUInteger)conf;


/**
 读取全天的心率，活动量 （Read all day heart rate, activity）

 @param day 0--请上传 当天的 全天心率,活动量 （Please upload the day of the day the heart rate, the amount of activity）
            1--请上传前1天的 全天心率,活动量 （Please upload the day before the day of heart rate, the amount of activity）
            2--请上传前2天的 全天心率,活动 （Please upload the first 2 days of all-day heart rate, activity）
 */
- (void)ReadAllDayHeartRateOrActivityVolumeWithDay:(NSUInteger)day;

/**
 下载/上传心率定标值（Download / upload heart rate calibration value）

 @param type  213 下载定标值 ,214 上传定标值
 @param heart 心率值
 */
- (void)DownloadOrUploadHeartRateCalibrationValueWithType:(NSUInteger)type WithHeart:(NSUInteger)heart;


/**
 获取睡眠数据 （get sleep data ）

 @param day 天 0 today , 1 yesterday ,2 The day before yesterday
 */
-(void)readSleepDataWithDay:(NSUInteger)day;



/**
 设置久坐提醒时间

 @param startHour 开始时间 
 @param startMinute 开始时间
 @param endHour 结束时间
 @param endMinute 结束时间
 @param threshould 阈值 30min ~ 240min
 @param type 状态 0 turn off 1 turn on 2 read message
 */
- (void)setLongSitRemindTimeWithStartHour:(NSUInteger)startHour
                            withStartMinute:(NSUInteger)startMinute
                              withEndHour:(NSUInteger)endHour
                              withEndMinute:(NSUInteger)endMinute
                            withThreshold:(NSUInteger)threshould
                                   withType:(NSUInteger)type;


/**
 ANCS推送开关

 @param type 1 设置ANCS功能 2 读取ANCS功能
 @param call 来电
 @param message 消息
 @param wechat 微信
 @param QQ QQ
 @param sina 新浪
 @param faceBook fackbook
 @param twitter twitter
 @param flickr Flickr
 @param linkedin Linkedin
 @param whatsapp Whatsapp
 */
-(void)ANCSNotificationANCSWithType:(NSUInteger)type
                           withCall:(BOOL)call
                        withMessage:(BOOL)message
                         withWechat:(BOOL)wechat
                             withQQ:(BOOL)QQ
                           withSina:(BOOL)sina
                       withFacebook:(BOOL)faceBook
                        withTwitter:(BOOL)twitter
                         withFlickr:(BOOL)flickr
                       withLinkedIn:(BOOL)linkedin
                       withWhatsapp:(BOOL)whatsapp;

/**
 设置防丢功能

 @param swit yes or no
 */
-(void)setAntilostWithSwitch:(BOOL)swit;


/**
 设置心率开关

 @param config 1 or 2
 @param swit yes or no
 */
-(void)setHeartRateWithConfig:(NSUInteger)config withSwitch:(BOOL)swit;


@end
