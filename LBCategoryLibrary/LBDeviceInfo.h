//
//  LBDeviceInfo.h
//  LBCategoryLibrary
//
//  Created by smufs on 2017/3/8.
//  Copyright © 2017年 李冰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>


typedef NS_ENUM(NSInteger, LBDeviceNetType) {

    LBDeviceNetTypeNone = 0,
    LBDeviceNetType2G,
    LBDeviceNetType3G,
    LBDeviceNetType4G,
    LBDeviceNetTypeWifi
};

typedef NS_ENUM(NSInteger, LBDeviceNetworkFlowType) {

    LBDeviceNetworkFlowTypeAll = 0,
    LBDeviceNetworkFlowTypeAllReceived,
    LBDeviceNetworkFlowTypeAllSend,
    LBDeviceNetworkFlowTypeWIFITotal,
    LBDeviceNetworkFlowTypeWIFIRecived,
    LBDeviceNetworkFlowTypeWIFISend,
    LBDeviceNetworkFlowTypeWWANTotal,
    LBDeviceNetworkFlowTypeWWANRecived,
    LBDeviceNetworkFlowTypeWWANSend,
    
};

@interface LBDeviceInfo : NSObject

+ (NSString *_Nullable)getDeviceIPIpAddresses;

+ (LBDeviceNetType) netType;

+ (NSString *_Nullable) getNetworkFlowWithType:(LBDeviceNetworkFlowType) type;

+ (NSArray *_Nullable) appIconImageNames;

+ (void) openSetting;

+ (void) sendSMSMessage:(NSString *_Nullable) message delegete:(nonnull UIViewController<MFMessageComposeViewControllerDelegate>*) controller;

+ (void) openSMSDelegate:(nonnull UIViewController *) controller;

@end
