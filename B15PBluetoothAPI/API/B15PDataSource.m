//
//  B15SDataSource.m
//  TestBlueDemo
//
//  Created by sucheng on 2017/6/12.
//  Copyright © 2017年 sucheng. All rights reserved.
//

#import "B15PDataSource.h"

#import "ConstNSNotificationName.h"
#import "B15PSleepModel.h"

@interface B15PDataSource ()

/**  */
@property(nonatomic,strong)B15PSleepModel * Model;

@end

@implementation B15PDataSource

+(instancetype)sharedInstance
{
    static  B15PDataSource *dataSource=nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        dataSource=[[super allocWithZone:NULL]init];
        
    });
    
    return dataSource;
}

+(id)allocWithZone:(struct _NSZone *)zone
{
    
    return [B15PDataSource sharedInstance];
    
}

-(id) copyWithZone:(struct _NSZone *)zone
{
    return [B15PDataSource sharedInstance];
}

-(void)observePerpheralDataChange
{
    //摇一摇拍照通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(DidReceiveSnake:) name:DidReceiveBraceletSnakeNotification object:nil];
    //血压通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(DidReceiveUserRealTimeTestBloodPressure:) name:DidReceiveUserRealTimeTestBloodPressureNotification object:nil];
    //手环同步过来的时间通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(didReceiveBraceletTime:) name:DidReceiveBraceletTimeNotification object:nil];
    //同步的步数通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(didReceiveUserStep:) name:DidReceiveUserStepNotification object:nil];
    //收到运动数据的通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(didReceiveSportsData:) name:DidReceiveSportDataNotification object:nil];
    
    //收到心率的通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(didReceiveHeartRateValue:) name:DidReceiveHeartRateNotification object:nil];
    
    //全天心率和活动量的通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(didReceiveAllDayHeartRateActivityAmount:) name:DidReceiveAllDayHeartRateActivityAmountNotification object:nil];
    
    //收到设置久坐提醒的响应值通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(didReceiveLongSitResponseValue:) name:DidReceiveLongSitResponseNotification object:nil];
    
    //收到防丢功能响应值的通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(didReceiveAntiLostResponseValue:) name:DidReceiveAntiLostResponseNotification object:nil];
    
    //个性化定制功能响应值的通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(didReceivePersonalizeSettingResponseValue:) name:DidReceivePersonalizedSettingsResponseNotification object:nil];
    
    //同步个人信息的响应值的通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(didReceiveSyncPersonalInfomationResponseValue:) name:DidReceiveSyncPersonalInfomationResponseNotification object:nil];
    
    //设置手环时间的响应值的通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(didReceiveSetBraceletTimeResponseValue:) name:DidReceiveSetBraceletTimeResponseNotification object:nil];
    //抬手亮屏的响应值的通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(didReceiveRaiseHandLightScreenResponseValue:) name:DidReceiveRaiseHandLightScreenResponseNotification object:nil];
    
    //设置手环震动时间的响应值的通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(didReceiveSetBraceletShockTimeResponseValue:) name:DidReceiveBraceletShockResponseNotification object:nil];
    
    //心率报警区间的响应值的通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(didReceiveHeartRateAlarmResponseValue:) name:DidReceiveHeartRateAlarmResponseNotification object:nil];
    
    //接收睡眠数据的通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(DidReceiveUserSleepData:) name:DidReceiveUserSleepDataNotification object:nil];
    //收到电池电量的通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(DidReceiveBatteryPower:) name:DidReceiveBatteryPowerNotification object:nil];
    
    NSLog(@"%s",__func__);

}

#pragma mark --- 处理步数和卡路里 ---

-(void)didReceiveUserStep:(NSNotification*)notification
{
    
    if (_delegate && [_delegate respondsToSelector:@selector(didReceiveUserStep:)])
    {
        [_delegate didReceiveUserStep:[[notification.userInfo objectForKey:@"step"] integerValue]];
    }
    NSLog(@"%s",__func__);

}

static NSUInteger string = 0 ;

-(B15PSleepModel *)Model
{

    if (_Model==nil)
    {
        _Model=[[B15PSleepModel alloc]init];
    }
    
    return _Model;
}

#pragma mark --- 处理睡眠数据 ---
-(void)DidReceiveUserSleepData:(NSNotification*)notification
{
    
    NSData *data=[notification.userInfo objectForKey:@"data"];
    if ([[self IntoWithData:data withLocation:8 WithLength:2] isEqualToString:@"a1"])
    {
        
        string = [[self JumpWithData:data withLocation:2 WithLength:2] intValue];
        self.Model.enterSleep_Month = [self JumpWithData:data withLocation:10 WithLength:2].integerValue;
        self.Model.enterSleep_Day = [self JumpWithData:data withLocation:12 WithLength:2].integerValue;
        self.Model.enterSleep_Hour = [self JumpWithData:data withLocation:14 WithLength:2].integerValue;
        self.Model.enterSleep_Minute = [self JumpWithData:data withLocation:16 WithLength:2].integerValue;
        self.Model.awake_Month  = [self JumpWithData:data withLocation:18 WithLength:2].integerValue;
        self.Model.awake_Day = [self JumpWithData:data withLocation:20 WithLength:2].integerValue;
        self.Model.awake_Hour = [self JumpWithData:data withLocation:22 WithLength:2].integerValue;
        self.Model.awake_Minute = [self JumpWithData:data withLocation:24 WithLength:2].integerValue;
        self.Model.deepSleep = [self JumpWithData:data withLocation:26 WithLength:2].integerValue*5;
        self.Model.shallowSleep = [self JumpWithData:data withLocation:28 WithLength:2].integerValue*5;
        self.Model.sleepQuality = [self JumpWithData:data withLocation:30 WithLength:2].integerValue;
        self.Model.lineChart = [self IntoWithData:data withLocation:32 WithLength:8].integerValue;
        
    }
    else
    {
        
        if (string-1 == [[self JumpWithData:data withLocation:2 WithLength:2] intValue])
        {
            self.Model.lineChart = [[NSString stringWithFormat:@"%d",self.Model.lineChart] stringByAppendingString:[self IntoWithData:data withLocation:8 WithLength:32]].integerValue;
        }
        if (string-2 == [[self JumpWithData:data withLocation:2 WithLength:2] intValue])
        {
            self.Model.enterSleep_Time = [self JumpWithData:data withLocation:30 WithLength:2].integerValue;
        }
        if (string-3 == [[self JumpWithData:data withLocation:2 WithLength:2] intValue])
        {
            self.Model.lineChart = [[NSString stringWithFormat:@"%d",self.Model.lineChart] stringByAppendingString:[self IntoWithData:data withLocation:8 WithLength:22]].integerValue;
            
            self.Model.awakeTimes = [self JumpWithData:data withLocation:22 WithLength:2].integerValue;
        }
        
    }
    
    if ([self JumpWithData:data withLocation:2 WithLength:2].integerValue==0)
    {
        
        if (_delegate && [_delegate respondsToSelector:@selector(didReceiveUserSleepData:)])
        {
            [_delegate didReceiveUserSleepData:self.Model];
        }
        
    }
    
    NSLog(@"%s",__func__);

}

#pragma mark --- 处理血压的实时测量数据 ---

-(void)DidReceiveUserRealTimeTestBloodPressure:(NSNotification*)notification
{

    if (_delegate && [_delegate respondsToSelector:@selector(didReceiveBloodPressureRealTimeTestDataWithMaxValue:withMinValue:)])
    {
        
        [_delegate didReceiveBloodPressureRealTimeTestDataWithMaxValue:[[notification.userInfo objectForKey:@"maxBloodPressure"] integerValue] withMinValue:[[notification.userInfo objectForKey:@"minBloodPressure"] integerValue]];
        
    }
    NSLog(@"%s",__func__);

}





#pragma mark --- 电池电量数据 ---
-(void)DidReceiveBatteryPower:(NSNotification*)notification
{

    if (_delegate && [_delegate respondsToSelector:@selector(didReceivePowerMode:withBatteryPower:withStatus:withPowerLevel:)])
    {
    
        [_delegate didReceivePowerMode:[[notification.userInfo objectForKey:@"powerMode"]integerValue] withBatteryPower:[[notification.userInfo objectForKey:@"batteryPower"]integerValue] withStatus:[[notification.userInfo objectForKey:@"status"]integerValue] withPowerLevel:[[notification.userInfo objectForKey:@"powerLevel"]integerValue]];
        
    }
    NSLog(@"%s",__func__);

}

#pragma mark --- 摇一摇 ---
-(void)DidReceiveSnake:(NSNotification *)notification
{

    if (_delegate && [_delegate respondsToSelector:@selector(iPhonedidReceiveShakeInstruction)])
    {
    
        [_delegate iPhonedidReceiveShakeInstruction];
        
    }
    NSLog(@"%s",__func__);

}
#pragma mark --- 处理手环同步过来的时间 ---
-(void)didReceiveBraceletTime:(NSNotification *)notification
{

    if (_delegate && [_delegate respondsToSelector:@selector(didReceiveBraceletTimeWithYear:withMonth:withDay:withHour:withMinute:withSecond:)])
    {
    
        [_delegate didReceiveBraceletTimeWithYear:[[notification.userInfo objectForKey:@"year"] integerValue] withMonth:[[notification.userInfo objectForKey:@"month"] integerValue] withDay:[[notification.userInfo objectForKey:@"day"] integerValue] withHour:[[notification.userInfo objectForKey:@"hour"] integerValue] withMinute:[[notification.userInfo objectForKey:@"minute"] integerValue] withSecond:[[notification.userInfo objectForKey:@"second"] integerValue]];
        
    }
    NSLog(@"%s",__func__);

}


#pragma mark --- 处理运动数据 ---
-(void)didReceiveSportsData:(NSNotification *)notification
{

    if (_delegate && [_delegate respondsToSelector:@selector(didReceiveSportsDataWithWalkStep:withRunStep:withSportsCategory:withAttitude:)])
    {
    
        [_delegate didReceiveSportsDataWithWalkStep:[[notification.userInfo objectForKey:@"walkStep"]integerValue] withRunStep:[[notification.userInfo objectForKey:@"runStep"]integerValue] withSportsCategory:[[notification.userInfo objectForKey:@"sportsCategory"]integerValue] withAttitude:[[notification.userInfo objectForKey:@"attitude"]integerValue]];
        
    }
    NSLog(@"%s",__func__);

}

#pragma mark --- 处理心率数据 ---
- (void)didReceiveHeartRateValue:(NSNotification *)notification
{

    if (_delegate && [_delegate respondsToSelector:@selector(didReceiveHeartRateValue:withheartRateCondition:)])
    {
    
        [_delegate didReceiveHeartRateValue:[[notification.userInfo objectForKey:@"heartRateValue"]integerValue] withheartRateCondition:[[notification.userInfo objectForKey:@"heartRateCondition"] integerValue]];
    }
    NSLog(@"%s",__func__);

}

#pragma mark --- 处理全天心率和活动量数据 ---
- (void)didReceiveAllDayHeartRateActivityAmount:(NSNotification *) notification
{

    NSDictionary *dict=notification.userInfo;
    if (_delegate && [_delegate respondsToSelector:@selector(didReceiveAllDayHeartRateValueActivityAmountWithCurrentData:withTotalData:withDay:withHour:withMinute:withSportStep:withHeartRateValue:withHighPressure:withLowPressure:)]) {
        
        [_delegate didReceiveAllDayHeartRateValueActivityAmountWithCurrentData:[[dict objectForKey:@"currentData"]integerValue] withTotalData:[[dict objectForKey:@"totalData"]integerValue] withDay:[[dict objectForKey:@"day"]integerValue] withHour:[[dict objectForKey:@"hour"]integerValue] withMinute:[[dict objectForKey:@"minute"]integerValue] withSportStep:[[dict objectForKey:@"step"]integerValue] withHeartRateValue:[[dict objectForKey:@"heartRate"]integerValue] withHighPressure:[[dict objectForKey:@"highPressure"]integerValue] withLowPressure:[[dict objectForKey:@"lowPressure"]integerValue]];
        
    }
    NSLog(@"%s",__func__);

}

#pragma mark --- 久坐提醒响应值 ---
- (void)didReceiveLongSitResponseValue:(NSNotification *)notification
{

    if (_delegate && [_delegate respondsToSelector:@selector(LongSitResponse:)])
    {
    
        [_delegate LongSitResponse:[[notification.userInfo objectForKey:@"response"]boolValue]];
        
    }
    NSLog(@"%s",__func__);

}

#pragma mark --- 防丢功能响应值 ---
- (void)didReceiveAntiLostResponseValue:(NSNotification *)notification
{

    if (_delegate && [_delegate respondsToSelector:@selector(antiLostResponse:)])
    {
    
        [_delegate antiLostResponse:[[notification.userInfo objectForKey:@"response"]boolValue]];
        
    }
    NSLog(@"%s",__func__);

}
#pragma mark --- 个性化定制响应值 ---
- (void)didReceivePersonalizeSettingResponseValue:(NSNotification *)notification
{

    
    if (_delegate && [_delegate respondsToSelector:@selector(personalizedSettingsResponse:)])
    {
        
        [_delegate personalizedSettingsResponse:[[notification.userInfo objectForKey:@"response"]boolValue]];
        
    }
    NSLog(@"%s",__func__);

}

#pragma mark --- 同步设备个人信息 ---
- (void)didReceiveSyncPersonalInfomationResponseValue:(NSNotification *)notification
{

    if (_delegate && [_delegate respondsToSelector:@selector(syncPersonalInformationResponse:)])
    {
        
        [_delegate syncPersonalInformationResponse:[[notification.userInfo objectForKey:@"response"]boolValue]];
        
    }
    NSLog(@"%s",__func__);

}

#pragma mark --- 设置手环时间响应值 ---

- (void)didReceiveSetBraceletTimeResponseValue:(NSNotification *)notification
{

    if (_delegate && [_delegate respondsToSelector:@selector(setBraceletTimeResponse:)])
    {
    
        [_delegate setBraceletTimeResponse:[[notification.userInfo objectForKey:@"response"] boolValue]];
    }
    NSLog(@"%s",__func__);

}

#pragma mark --- 抬手亮屏响应值 ---
- (void)didReceiveRaiseHandLightScreenResponseValue:(NSNotification *)notification
{
    if (_delegate && [_delegate respondsToSelector:@selector(raiseHandLightScreenResponse:)])
    {
    
        [_delegate raiseHandLightScreenResponse:[[notification.userInfo objectForKey:@"response"]boolValue]];
    }
    NSLog(@"%s",__func__);

}

#pragma mark --- 设置手环震动时间的响应值 ---

- (void)didReceiveSetBraceletShockTimeResponseValue:(NSNotification *)notification
{

    if (_delegate && [_delegate respondsToSelector:@selector(braceletShockResponse:)])
    {
    
        [_delegate braceletShockResponse:[[notification.userInfo objectForKey:@"response"]boolValue]];
    }
    NSLog(@"%s",__func__);

}

#pragma mark --- 心率报警区间的响应值 ---
- (void)didReceiveHeartRateAlarmResponseValue:(NSNotification *)notification
{

    if (_delegate && [_delegate respondsToSelector:@selector(heartRateAlarmIntervalResponse:)])
    {
        
        [_delegate heartRateAlarmIntervalResponse:[[notification.userInfo objectForKey:@"response"]boolValue]];
    }
    NSLog(@"%s",__func__);

    
}

- (NSDateComponents *)getDateComponentsFromDate:(NSDate *)date
{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekday) fromDate:date];
    
    return components;
}

-(NSString *)IntoWithData:(NSData *)data withLocation:(NSUInteger)location WithLength:(NSUInteger)length{
    
    return [self SeparatedNSString:data WithRangeLocation:location WithLength:length];
}

-(NSString *)JumpWithData:(NSData *)data withLocation:(NSUInteger)location WithLength:(NSUInteger)length{
    
    return [NSString stringWithFormat:@"%.2lu",strtoul([[self SeparatedNSString:data WithRangeLocation:location WithLength:length] UTF8String],0,16)];
}

-(NSString *)SeparatedNSString:(NSData *)data WithRangeLocation:(int)Local WithLength:(int)length{
        
        NSString *Idstr = [NSString stringWithFormat:@"%@",data];
        Idstr = [Idstr stringByReplacingOccurrencesOfString:@" " withString:@""];
        Idstr = [Idstr stringByReplacingOccurrencesOfString:@">" withString:@""];
        Idstr = [Idstr stringByReplacingOccurrencesOfString:@"<" withString:@""];
        Idstr = [Idstr substringWithRange:NSMakeRange(Local, length)];
        return Idstr;
        
    }

-(void)dealloc
{
   
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:DidReceiveBraceletSnakeNotification object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:DidReceiveUserRealTimeTestBloodPressureNotification object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:DidReceiveBraceletTimeNotification object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:DidReceiveUserStepNotification object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:DidReceiveSportDataNotification object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:DidReceiveHeartRateNotification object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:DidReceiveAllDayHeartRateActivityAmountNotification object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:DidReceiveUserSleepDataNotification object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:DidReceiveBatteryPowerNotification object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:DidReceiveLongSitResponseNotification object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:DidReceiveAntiLostResponseNotification object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:DidReceivePersonalizedSettingsResponseNotification object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:DidReceiveSyncPersonalInfomationResponseNotification object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:DidReceiveSetBraceletTimeResponseNotification object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:DidReceiveRaiseHandLightScreenResponseNotification object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:DidReceiveBraceletShockResponseNotification object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:DidReceiveHeartRateAlarmResponseNotification object:nil];

    
}

@end
