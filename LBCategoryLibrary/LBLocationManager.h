//
//  LBLocationManager.h
//  PandaTakeaway
//
//  Created by smufs on 2017/5/17.
//  Copyright © 2017年 李冰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LBLocationManager : NSObject

+ (instancetype)shareManager;

- (void) startLocationService;

@end
