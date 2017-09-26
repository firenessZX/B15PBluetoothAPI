//
//  StatusTpye.h
//  TestBlueDemo
//
//  Created by sucheng on 2017/6/9.
//  Copyright © 2017年 sucheng. All rights reserved.
//

#import <Foundation/Foundation.h>

/**连接外设的枚举定义*/
typedef NS_ENUM(NSUInteger,B15SBluetoothManagerConnectType) {
    
    /** 设备连接成功 */
    B15SBluetoothManagerConnectSuccess=100,
    /** 设备连接失败 */
    B15SBluetoothManagerConnectFailed=101,

};

/**
 文件下载状态枚举定义

 - DownloadStatusSuccess: 下载成功
 - DownloadStatusFail: 下载失败
 */
typedef NS_ENUM(NSUInteger, DownloadStatus) {
    /** 下载成功 */
    DownloadStatusSuccess,
    /** 下载失败 */
    DownloadStatusFail,

};

/**
 固件包更新状态枚举定义

 - FirmwareUpdateStatusSuccess: 固件包更新成功
 - FirmwareUpdateStatusFail: 固件包更新失败
 */
typedef NS_ENUM(NSUInteger, FirmwareUpdateStatus) {
    //固件包更新成功
    FirmwareUpdateStatusSuccess,
    //固件包更新失败
    FirmwareUpdateStatusFail,

};

