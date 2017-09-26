//
//  B15SSleepModel.h
//  TestBlueDemo
//
//  Created by sucheng on 2017/6/10.
//  Copyright © 2017年 sucheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface B15PSleepModel : NSObject

//进入睡眠时间
/**  */
@property(nonatomic,assign)NSUInteger  enterSleep_Month;

/**  */
@property(nonatomic,assign)NSUInteger  enterSleep_Day;

/**  */
@property(nonatomic,assign)NSUInteger  enterSleep_Hour;

/**  */
@property(nonatomic,assign)NSUInteger  enterSleep_Minute;

/**  */
@property(nonatomic,assign)NSUInteger  enterSleep_Time;

//睡眠结束时间
/**  */
@property(nonatomic,assign)NSUInteger  awake_Month;

/**  */
@property(nonatomic,assign)NSUInteger  awake_Day;

/**  */
@property(nonatomic,assign)NSUInteger  awake_Hour;

/**  */
@property(nonatomic,assign)NSUInteger  awake_Minute;

//深睡    浅睡  睡眠质量

/** 深睡 */
@property(nonatomic,assign)NSUInteger  deepSleep;

/** 浅睡 */
@property(nonatomic,assign)NSUInteger  shallowSleep;

/** 睡眠质量 */
@property(nonatomic,assign)NSUInteger  sleepQuality;

/** 起夜总数 Wake up the number of times */
@property(nonatomic,assign)NSUInteger  awakeTimes;

/**  */
@property(nonatomic,assign)NSUInteger  curve;

/**  */
@property(nonatomic,assign)NSUInteger  lineChart;



@end
