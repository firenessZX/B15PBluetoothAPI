//
//  B15SPeripheral.m
//  TestBlueDemo
//
//  Created by sucheng on 2017/6/10.
//  Copyright © 2017年 sucheng. All rights reserved.
//

#import "B15PPeripheral.h"
#import "B15PBluetoothDevice.h"
#import "ConstNSNotificationName.h"
#import "B15PDataSource.h"
@interface B15PPeripheral ()<CBPeripheralDelegate>
//** 读特征 */
@property(nonatomic,strong)CBCharacteristic * readCharacteristic;
//** 写特征 */
@property(nonatomic,strong)CBCharacteristic * writeCharacteristic;

@end

static NSString * const  B15PServiceUUID    =@"F0080001-0451-4000-B000-000000000000";
static NSString * const  B15PWrite          =@"F0080003-0451-4000-B000-000000000000";
static NSString * const  B15PRead           =@"F0080002-0451-4000-B000-000000000000";

@implementation B15PPeripheral

+(instancetype)sharedInstance
{
    static  B15PPeripheral *peripheral=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        peripheral=[[super allocWithZone:NULL]init];
        
    });
    
    return peripheral;
}

+(id)allocWithZone:(struct _NSZone *)zone
{
    
    return [B15PPeripheral sharedInstance];
    
}

-(id) copyWithZone:(struct _NSZone *)zone
{
    return [B15PPeripheral sharedInstance];
}

-(void)initPeripheral
{

    [[B15PDataSource sharedInstance]observePerpheralDataChange];
    self.peripheral.delegate=self;
    [_peripheral discoverServices:nil];
    [[B15PBluetoothDevice sharedInstance] setValue:_peripheral forKey:@"peripheral"];;
    NSLog(@"%s",__func__);

}



#pragma mark  --- 已经扫描到了服务 ---
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error {
    
    if (error)
    {
        
        return;
        
    }
    
    for (CBService *service in peripheral.services)
    {
        
        if ([service.UUID isEqual:[CBUUID UUIDWithString:B15PServiceUUID]])
        {
            
            [peripheral discoverCharacteristics:@[[CBUUID UUIDWithString:B15PRead],[CBUUID UUIDWithString:B15PWrite]] forService:service];
            break;
        }
        
    }
    NSLog(@"%s",__func__);

    
}

#pragma mark  --- 已经扫描到了服务的特征值 ---
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error {
    
    if (error)
    {
        return;
    }
    
    for (CBCharacteristic *characteristic in service.characteristics)
    {
        
        if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:B15PRead]])
        {
            
            [peripheral setNotifyValue:YES forCharacteristic:characteristic];
            _readCharacteristic=characteristic;
            break;
        }
        
    }
    //获取Characteristic的值，读到数据会进入方法：-(void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
    for (CBCharacteristic *characteristic in service.characteristics)
    {
        if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:B15PWrite]])
        {
            [peripheral setNotifyValue:YES forCharacteristic:characteristic];
            _writeCharacteristic=characteristic;
            [[B15PBluetoothDevice sharedInstance]setValue:_writeCharacteristic forKey:@"writeCharacter"]; ;
            break;
            
        }
        
    }
    NSLog(@"%s",__func__);

}

#pragma mark ---- 获取的charateristic的值 ---
-(void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{
    //value的类型是NSData，具体开发时，会根据外设协议制定的方式去解析数据
    NSLog(@"%s",__func__);
    NSUInteger length=characteristic.value.length;
    Byte byte[length];
    [characteristic.value getBytes:byte length:length];
    
    if (byte[0]==0xb6 && byte[2]==0x02){   //摇一摇拍照
        
        [[NSNotificationCenter defaultCenter]postNotificationName:DidReceiveBraceletSnakeNotification object:nil];
        
    }
    else if (byte[0]==0x90 && byte[1]>30&&byte[2]>20){
        
        //血压测量,byte[1] 高压 byte[2] 低压
        [[NSNotificationCenter defaultCenter]postNotificationName:DidReceiveUserRealTimeTestBloodPressureNotification object:nil userInfo:@{@"maxBloodPressure":@(byte[1]),@"minBloodPressure":@(byte[2])}];
        
    }
    else if (byte[0]==0xa0){
        //电池电量和电池状态
        [[NSNotificationCenter defaultCenter]postNotificationName:DidReceiveBatteryPowerNotification object:nil userInfo:@{@"powerMode":@(byte[1]),@"batteryPower":@(byte[2]),@"status":@(byte[3]),@"powerLevel":@(byte[4])}];
        
    }
    else if (byte[0]==0xa6){
    //读取手环时间
        [[NSNotificationCenter defaultCenter]postNotificationName:DidReceiveBraceletTimeNotification object:nil userInfo:@{@"year":@((byte[1]<<8)+byte[2]),@"month":@(byte[3]),@"day":@(byte[4]),@"hour":@(byte[5]),@"minute":@(byte[6]),@"second":@(byte[7])}];
        
    }
    else if (byte[0]==0xa8){
        //读取步数
        [[NSNotificationCenter defaultCenter]postNotificationName:DidReceiveUserStepNotification object:nil userInfo:@{@"step":@((byte[1]<<24)+(byte[2]<<16)+(byte[3]<<8)+byte[4])}];
        
    }
    else if (byte[0]==0xa9){
        //读取运动数据
        NSUInteger walkStep = (byte[1]<<24)+(byte[2]<<16)+(byte[3]<<8)+byte[4];
        NSUInteger runStep  = (byte[5]<<24)+(byte[6]<<16)+(byte[7]<<8)+byte[8];
        [[NSNotificationCenter defaultCenter]postNotificationName:DidReceiveSportDataNotification object:nil userInfo:@{@"walkStep":@(walkStep),@"runStep":@(runStep),@"sportsCategory":@(byte[9]),@"attitude":@(byte[10])}];
        
    }
    else if (byte[0]==0xd0){   //读取实时心率
        
        [[NSNotificationCenter defaultCenter]postNotificationName:DidReceiveHeartRateNotification object:nil userInfo:@{@"heartRateValue":@(byte[1]),@"heartRateCondition":@(byte[2])}];
        
    }
    else if (byte[0]==0xe0){
    //读取睡眠数据                                                               
    [[NSNotificationCenter defaultCenter]postNotificationName:DidReceiveUserSleepDataNotification object:nil userInfo:@{@"data":characteristic.value}];
    
    }
    else if (byte[0]==0xd1){
    //读取全天心率，活动量
        [[NSNotificationCenter defaultCenter]postNotificationName:DidReceiveAllDayHeartRateActivityAmountNotification object:nil userInfo:@{@"currentData":@(byte[1]),@"totalData":@(byte[3]),@"day":@(byte[7]),@"hour":@(byte[8]),@"minute":@(byte[9]),@"step":@((byte[12]<<8)+byte[13]),@"heartRate":@(byte[14]),@"highPressure":@(byte[15]),@"lowPressure":@(byte[16])}];
        
    }
    else if (byte[0]==0xe1){
        //久坐提醒响应值
        [[NSNotificationCenter defaultCenter]postNotificationName:DidReceiveLongSitResponseNotification object:nil userInfo:@{@"response":@(byte[1])}];
        
    }
    else if (byte[0]==0xae){
        //防丢功能响应值
        [[NSNotificationCenter defaultCenter]postNotificationName:DidReceiveAntiLostResponseNotification object:nil userInfo:@{@"response":@(byte[1])}];
        
    }
    else if (byte[0]==0x91){
    //个性化定制响应值
        [[NSNotificationCenter defaultCenter]postNotificationName:DidReceivePersonalizedSettingsResponseNotification object:nil userInfo:@{@"response":@(byte[1])}];
        
    }
    else if (byte[0]==0xa3){
    
        //同步设备个人信息的响应值
        [[NSNotificationCenter defaultCenter]postNotificationName:DidReceivePersonalizedSettingsResponseNotification object:nil userInfo:@{@"response":@(byte[1])}];
        
    }
    else if (byte[0]==0xa5){
    //设置手环时间的响应值通知
        [[NSNotificationCenter defaultCenter]postNotificationName:DidReceiveSetBraceletTimeResponseNotification object:nil userInfo:@{@"response":@(byte[1])}];
        
    }
    else if (byte[0]==0xaa){
        //抬手亮屏的响应值通知
        [[NSNotificationCenter defaultCenter]postNotificationName:DidReceiveRaiseHandLightScreenResponseNotification object:nil userInfo:@{@"response":@(byte[1])}];
    }
    else if (byte[0]==0xab){
    //手环震动时间的响应值通知
        [[NSNotificationCenter defaultCenter]postNotificationName:DidReceiveBraceletShockResponseNotification object:nil userInfo:@{@"response":@(byte[1])}];
    }
    else if (byte[0]==0xac){
    //心率报警区间的响应值的通知
        [[NSNotificationCenter defaultCenter]postNotificationName:DidReceiveHeartRateAlarmResponseNotification object:nil userInfo:@{@"response":@(byte[1])}];
    }
    
    
}

#pragma mark ---- 停止扫描并断开连接 ---
-(void)disconnectPeripheral:(CBCentralManager *)centralManager peripheral:(CBPeripheral *)peripheral{
    //停止扫描
    [centralManager stopScan];
    //断开连接
    [centralManager cancelPeripheralConnection:peripheral];
    
}



@end
