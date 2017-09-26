//
//  B15SBluetoothDevice.m
//  TestBlueDemo
//
//  Created by sucheng on 2017/6/10.
//  Copyright © 2017年 sucheng. All rights reserved.
//

#import "B15PBluetoothDevice.h"

@interface B15PBluetoothDevice ()

@end

@implementation B15PBluetoothDevice

+(instancetype)sharedInstance
{
    static  B15PBluetoothDevice *B15SDevice=nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        B15SDevice=[[super allocWithZone:NULL]init];
        
    });
    
    return B15SDevice;
}

+(id)allocWithZone:(struct _NSZone *)zone
{
    
    return [B15PBluetoothDevice sharedInstance];
    
}

-(id) copyWithZone:(struct _NSZone *)zone
{
    return [B15PBluetoothDevice sharedInstance];
}

#pragma mark --- 切换手环语言 ---

-(void)switchLanguageWithConfigure:(NSUInteger)languageConfigure
{

    Byte byte[5]={0};
    byte[0]=0xf4;
    byte[1]=0x00;
    byte[2]=0x00;
    byte[3]=0x00;
    byte[4]=languageConfigure;
    NSData *data=[NSData dataWithBytes:byte length:5];
    [self.peripheral writeValue:data forCharacteristic:_writeCharacter type:CBCharacteristicWriteWithResponse];
}

#pragma mark --- 手环查找手机 ---
-(void)braceletSearchiPhone
{

    Byte byte[2]={0};
    byte[0]=0xb5;
    byte[1]=0x01;
    
    NSData *data=[NSData dataWithBytes:byte length:2];
    
    [self.peripheral writeValue:data forCharacteristic:_writeCharacter type:CBCharacteristicWriteWithResponse];
    
    NSLog(@"------%@",data);
    
}

#pragma mark --- 摇一摇拍照 ---
-(void)shakeBraceletTakePictureWithSwitch:(BOOL)swit
{

    Byte byte[2]={0};
    byte[0]=0xb6;
    byte[1]=swit;
    NSData *data=[NSData dataWithBytes:byte length:2];
    [self.peripheral writeValue:data forCharacteristic:_writeCharacter type:CBCharacteristicWriteWithResponse];
    
}

#pragma mark --- 血压测量 ---

-(void)bloodPressureMeasureWithConfig:(NSUInteger)confi
{

    Byte byte[2]={0};
    byte[0]=0x90;
    byte[1]=confi;
    NSData *data=[NSData dataWithBytes:byte length:2];
    [self.peripheral writeValue:data forCharacteristic:_writeCharacter type:CBCharacteristicWriteWithResponse];
    
}

#pragma mark --- 个性化定制血压 ---

-(void)personalizedSettingsWithSwitch:(BOOL)swit withMaxBloodPressure:(NSUInteger)maxBloodPressure withMinBloodPressure:(NSUInteger)minBloodPressure
{

    Byte byte[4]={0};
    byte[0]=0x91;
    byte[1]=swit;
    byte[2]=maxBloodPressure;
    byte[3]=minBloodPressure;
    
    NSData *data=[NSData dataWithBytes:byte length:4];
    [self.peripheral writeValue:data forCharacteristic:_writeCharacter type:CBCharacteristicWriteWithResponse];
    
}

#pragma mark --- 获取电池状态和电量 ---
-(void)getBatteryPower
{

    Byte byte[2]={0};
    byte[0]=0xa0;
    byte[1]=0x00;
    NSData *data=[NSData dataWithBytes:byte length:2];
    [self.peripheral writeValue:data forCharacteristic:_writeCharacter type:CBCharacteristicWriteWithResponse];
    
}


#pragma mark --- 手环无线固件升级 ---
- (void)BraceletWirelessFirmwareUpgradeWithCode:(NSUInteger)code
{
    
    Byte byte[4] = {0};
    byte[0] = 0xA2;
    byte[1] = 0x00;
    byte[2] = 0x00;
    byte[3] = code;
    
    NSData *data = [NSData dataWithBytes:byte length:4];
    [self.peripheral writeValue:data forCharacteristic:_writeCharacter type:CBCharacteristicWriteWithResponse];
}

#pragma mark --- 同步设备个人信息 ---
- (void)synchronizeDevicePersonalInformationWithHeight:(NSUInteger)height withWeight:(NSUInteger)weight withAge:(NSUInteger)age withSex:(NSUInteger)sex withGoldStep:(NSUInteger)goldStep
{

    NSMutableData *data=[NSMutableData data];
    [self initData:data WithHead:@"0xA3"];
    [self initData:data WithHead:[NSString stringWithFormat:@"0x%x",height]];
    [self initData:data WithHead:[NSString stringWithFormat:@"0x%x",weight]];
    [self initData:data WithHead:[NSString stringWithFormat:@"0x%x",age]];
    [self initData:data WithHead:[NSString stringWithFormat:@"0x%x",sex]];
    [data appendData:[self convertHexStrToData:[self addZero:[NSString stringWithFormat:@"%x",goldStep] withLength:4]]];
    [self.peripheral writeValue:data forCharacteristic:_writeCharacter type:CBCharacteristicWriteWithResponse];

}

//将16进制的字符串转换成NSData
- (NSData *)convertHexStrToData:(NSString *)str {
    if (!str || [str length] == 0) {
        return nil;
    }
    
    NSMutableData *hexData = [[NSMutableData alloc] initWithCapacity:8];
    NSRange range;
    if ([str length] %2 == 0) {
        range = NSMakeRange(0,2);
    } else {
        range = NSMakeRange(0,1);
    }
    for (NSInteger i = range.location; i < [str length]; i += 2) {
        unsigned int anInt;
        NSString *hexCharStr = [str substringWithRange:range];
        NSScanner *scanner = [[NSScanner alloc] initWithString:hexCharStr];
        
        [scanner scanHexInt:&anInt];
        NSData *entity = [[NSData alloc] initWithBytes:&anInt length:1];
        [hexData appendData:entity];
        
        range.location += range.length;
        range.length = 2;
    }
    
    return hexData;
}


#pragma mark --- 读取生产编号 ---
- (void)readTheProductionNumber
{
    Byte byte[2] = {0};
    byte[0] = 0xA4;
    byte[1] = 0x00;
    NSData *data = [NSData dataWithBytes:byte length:2];
    [self.peripheral writeValue:data forCharacteristic:_writeCharacter type:CBCharacteristicWriteWithResponse];
}

#pragma mark --- 设置手环时间 ---
- (void)setTheBraceletTimeWithYear:(NSUInteger)year withMonth:(NSUInteger)month withDay:(NSUInteger)day withHour:(NSUInteger)hour withMinute:(NSUInteger)minute withSecond:(NSUInteger)second withType:(NSUInteger)type
{
    NSMutableData *data = [NSMutableData data];
    [self initData:data WithHead:@"0xA5"];
    //07e0  ---> e007  <a5e007>
    [data appendData:[self convertHexStrToData:[self addZero:[NSString stringWithFormat:@"%x",year] withLength:4]]];
    [self initData:data WithHead:[NSString stringWithFormat:@"0x%x",month]];
    [self initData:data WithHead:[NSString stringWithFormat:@"0x%x",day]];
    [self initData:data WithHead:[NSString stringWithFormat:@"0x%x",hour]];
    [self initData:data WithHead:[NSString stringWithFormat:@"0x%x",minute]];
    [self initData:data WithHead:[NSString stringWithFormat:@"0x%x",second]];
    [self initData:data WithHead:[NSString stringWithFormat:@"0x%x",type]];
    
    [self.peripheral writeValue:data forCharacteristic:_writeCharacter type:CBCharacteristicWriteWithResponse];

}


#pragma mark --- 读取手环时间 ---
- (void)readTheBraceletTime
{
    Byte byte[2] = {0};
    byte[0] = 0xA6;
    byte[1] = 0x00;
    
    NSData *data = [NSData dataWithBytes:byte length:2];
    [self.peripheral writeValue:data forCharacteristic:_writeCharacter type:CBCharacteristicWriteWithResponse];
}

#pragma mark --- 读取记步数 ---
- (void)readTheNumberofStepsWithDay:(NSUInteger)day
{
    Byte byte[2] = {0};
    byte[0] = 0xA8;
    byte[1] = day;
    
    NSData *data = [NSData dataWithBytes:byte length:2];
    [self.peripheral writeValue:data forCharacteristic:_writeCharacter type:CBCharacteristicWriteWithResponse];
    
}

#pragma mark --- 读取运动数据 ---
- (void)readMotionData
{
    Byte byte[3] = {0};
    byte[0] = 0xA9;
    byte[1] = 0x00;
    byte[2] = 0x00;
    
    NSData *data = [NSData dataWithBytes:byte length:3];
    [self.peripheral writeValue:data forCharacteristic:_writeCharacter type:CBCharacteristicWriteWithResponse];
    
}

#pragma mark --- 抬手亮屏 ---
-(void)raiseHandLightScreenWithSwitch:(BOOL)swit
{

    Byte byte[2] = {0};
    byte[0] = 0xAA;
    byte[1] = swit;
    
    NSData *data = [NSData dataWithBytes:byte length:2];
    [self.peripheral writeValue:data forCharacteristic:_writeCharacter type:CBCharacteristicWriteWithResponse];
    
}

#pragma mark --- 设置手环闹钟时间 ---
-(void)setFirstAlarmTimeWithHour:(NSUInteger)firstAlarmHour withFirstAlarmMinute:(NSUInteger)firstAlarmMinute withFirstAlarmSwitch:(BOOL)firstAlarmSwitch withSecondAlarmHour:(NSUInteger)secondAlarmHour withSecondAlarmMinute:(NSUInteger)secondAlarmMinute withSecondAlarmSwitch:(BOOL)secondAlarmSwitch withThirdAlarmHour:(NSUInteger)thirdAlarmHour withThirdAlarmMinute:(NSUInteger)thirdAlarmMinute withThirdAlarmSwitch:(BOOL)thirdAlarmSwitch withType:(NSUInteger)type
{

    Byte byte[11] = {0};
    byte[0] = 0xab;
    byte[1] = firstAlarmHour;
    byte[2] = firstAlarmMinute;
    byte[3] = firstAlarmSwitch;
    byte[4] = secondAlarmHour;
    byte[5] = secondAlarmMinute;
    byte[6] = secondAlarmSwitch;
    byte[7] = thirdAlarmHour;
    byte[8] = thirdAlarmMinute;
    byte[9] = thirdAlarmSwitch;
    byte[10]= type;
    NSData *data=[NSData dataWithBytes:byte length:11];
    [self.peripheral writeValue:data forCharacteristic:_writeCharacter type:CBCharacteristicWriteWithResponse];
    
    
}

#pragma mark --- 设置心率报警区间 ---
- (void)setHeartRateAlarmIntervalWithMaxHeart:(NSUInteger)maxHeart withMinHeart:(NSUInteger)minHeart withConfig:(NSUInteger)con
{
    Byte byte[4] = {0};
    byte[0] = 0xAC;
    byte[1] = maxHeart;
    byte[2] = minHeart;
    byte[3] = con;
    NSData *data = [NSData dataWithBytes:byte length:4];
    [self.peripheral writeValue:data forCharacteristic:_writeCharacter type:CBCharacteristicWriteWithResponse];
}

#pragma mark --- 蓝牙配对 ---
- (void)BluetoothPairing:(BOOL)isPairing
{
    Byte byte[2] = {0};
    byte[0] = 0xBC;
    byte[1] = isPairing;
    
    NSData *data = [NSData dataWithBytes:byte length:2];
    [self.peripheral writeValue:data forCharacteristic:_writeCharacter type:CBCharacteristicWriteWithResponse];
    
}

#pragma mark --- 读取当前心率 ---
- (void)ReadTheCurrentHeartRateWithSwitch:(BOOL)swit withConfig:(NSUInteger)conf
{
    Byte byte[3] = {0};
    byte[0] = 0xD0;
    byte[1] = swit;
    byte[2] = conf;
    
    NSData *data = [NSData dataWithBytes:byte length:3];
    [self.peripheral writeValue:data forCharacteristic:_writeCharacter type:CBCharacteristicWriteWithResponse];
    
}

#pragma mark --- 读取全天心率，活动量 ---
- (void)ReadAllDayHeartRateOrActivityVolumeWithDay:(NSUInteger)day{
    NSMutableData *data = [NSMutableData data];
    [self initData:data WithHead:@"0xD1"];
    [self initData:data WithHead:[NSString stringWithFormat:@"0x%lx",(unsigned long)1]];
    [self initData:data WithHead:[NSString stringWithFormat:@"0x%lx",(unsigned long)0]];
    [self initData:data WithHead:[NSString stringWithFormat:@"0x%lx",(unsigned long)day]];

    [self.peripheral writeValue:data forCharacteristic:_writeCharacter type:CBCharacteristicWriteWithResponse];
}


#pragma mark --- 下载/上传心率定标值 ---
- (void)DownloadOrUploadHeartRateCalibrationValueWithType:(NSUInteger)type WithHeart:(NSUInteger)heart
{
    Byte byte[2] = {0};
    byte[0] = type;
    byte[1] = heart;
    
    NSData *data = [NSData dataWithBytes:byte length:2];
    [self.peripheral writeValue:data forCharacteristic:_writeCharacter type:CBCharacteristicWriteWithResponse];
}

#pragma mark --- 读取睡眠数据 ---
- (void)readSleepDataWithDay:(NSUInteger)day
{

    Byte byte[2]={0};
    byte[0]=0xe0;
    byte[1]=day;
    
    NSData *data=[NSData dataWithBytes:byte length:2];
    
    [self.peripheral writeValue:data forCharacteristic:_writeCharacter type:CBCharacteristicWriteWithResponse];
    
}

#pragma mark --- 设置久坐提醒时间 ---

-(void)setLongSitRemindTimeWithStartHour:(NSUInteger)startHour withStartMinute:(NSUInteger)startMinute withEndHour:(NSUInteger)endHour withEndMinute:(NSUInteger)endMinute withThreshold:(NSUInteger)threshould withType:(NSUInteger)type
{

    Byte byte[7]={0};
    
    byte[0] = 0xe1;
    byte[1] = startHour;
    byte[2] = startMinute;
    byte[3] = endHour;
    byte[4] = endMinute;
    byte[5] = threshould;
    byte[6] = type;
    NSData *data=[NSData dataWithBytes:byte length:7];
    [self.peripheral writeValue:data forCharacteristic:_writeCharacter type:CBCharacteristicWriteWithResponse];
    
}

#pragma mark --- ANCS推送 ---
-(void)ANCSNotificationANCSWithType:(NSUInteger)type withCall:(BOOL)call withMessage:(BOOL)message withWechat:(BOOL)wechat withQQ:(BOOL)QQ withSina:(BOOL)sina withFacebook:(BOOL)faceBook withTwitter:(BOOL)twitter withFlickr:(BOOL)flickr withLinkedIn:(BOOL)linkedin withWhatsapp:(BOOL)whatsapp
{

    
    Byte byte[12]={0};
    byte[0] = 0xad;
    byte[1] = type;
    byte[2] = call;
    byte[3] = message;
    byte[4] = wechat;
    byte[5] = QQ;
    byte[6] = sina;
    byte[7] = faceBook;
    byte[8] = twitter;
    byte[9] = flickr;
    byte[10] = linkedin;
    byte[11] = whatsapp;
    
    NSData *data = [NSData dataWithBytes:byte length:12];
    
    [self.peripheral writeValue:data forCharacteristic:_writeCharacter type:CBCharacteristicWriteWithResponse];
    
    
}
#pragma mark --- 设置防丢功能 ---
-(void)setAntilostWithSwitch:(BOOL)swit
{

    Byte byte[2]={0};
    byte[0] = 0xae;
    byte[1]  = swit;
    NSData *data=[NSData dataWithBytes:byte length:2];
    [self.peripheral writeValue:data forCharacteristic:_writeCharacter type:CBCharacteristicWriteWithResponse];
    
}
#pragma mark --- 设置心率开关 ---
-(void)setHeartRateWithConfig:(NSUInteger)config withSwitch:(BOOL)swit
{
    Byte byte[8]={0};
    
    byte[0]=0xb8;
    byte[1]=config;
    byte[2]=0x01;
    byte[3]=0x01;
    byte[4]=swit;
    byte[5]=0x01;
    byte[6]=0x00;
    byte[7]=0x00;
    NSData *data=[NSData dataWithBytes:byte length:8];
    [self.peripheral writeValue:data forCharacteristic:_writeCharacter type:CBCharacteristicWriteWithResponse];
    
}

/**
 *  封装data
 */
-(void)initData:(NSMutableData *)data WithHead:(NSString *)head{
    unsigned long intd = strtoul([head UTF8String],0,16);
    NSData *MyData = [NSData dataWithBytes:&intd length:1];
    [data appendData:MyData];
}

//字符串补零操作
-(NSString *)addZero:(NSString *)str withLength:(NSUInteger)length{
    NSString *string = nil;
    if (str.length==length) {
        return str;
    }
    if (str.length<length) {
        NSUInteger inter = length-str.length;
        for (int i=0;i< inter; i++) {
            string = [NSString stringWithFormat:@"0%@",str];
            str = string;
        }
    }
    return string;
}

@end
