//
//  LBLocationManager.m
//  PandaTakeaway
//
//  Created by smufs on 2017/5/17.
//  Copyright © 2017年 李冰. All rights reserved.
//

#import "LBLocationManager.h"
#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>

@interface LBLocationManager ()<CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;

@end

@implementation LBLocationManager

- (instancetype)init {
    
    @throw [NSException exceptionWithName:@"单例类" reason:@"该类无法使用该初始化方法。" userInfo:nil];
}

+(instancetype)shareManager {
    
    static LBLocationManager *manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        manager = [[LBLocationManager alloc] initPrivate];
    });
    
    return manager;
}

- (instancetype) initPrivate {
    
    if (self = [super init]) {
        
        [self initalizeLocation];
    }
    
    return self;
}

- (void) initalizeLocation {
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.distanceFilter = 10;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
    
}

- (void)startLocationService {

}

#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    
    if (status == kCLAuthorizationStatusAuthorizedAlways || status == kCLAuthorizationStatusAuthorizedWhenInUse)
    {
        [self.locationManager startUpdatingLocation];
    }
    else if(status == kCLAuthorizationStatusDenied)
    {
        [self _alertUserSetting];
    }
    else if (status == kCLAuthorizationStatusNotDetermined)
    {
        [self.locationManager requestWhenInUseAuthorization];
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {

    LBLog(@"%@", locations.lastObject);
    
    CLLocation *currentLocation = locations.lastObject;
    
    // 获取当前所在的城市名
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    //根据经纬度反向地理编译出地址信息
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *array, NSError *error)
     {
         if (array.count > 0)
         {
             CLPlacemark *place = [array objectAtIndex:0];
             //将获得的所有信息显示到label上
             NSLog(@"位置:%@", place.name);
             NSLog(@"国家:%@", place.country);
             NSLog(@"城市:%@", place.locality);
             NSLog(@"区:%@", place.subLocality);
             NSLog(@"街道:%@", place.thoroughfare);
             NSLog(@"子街道:%@", place.subThoroughfare);
             //获取城市
             NSString *city = place.locality;
             if (!city)
             {
                 //四大直辖市的城市信息无法通过locality获得，只能通过获取省份的方法来获得（如果city为空，则可知为直辖市）
                 city = place.administrativeArea;
             }
             NSLog(@"----city---- %@  ",city);
         }
     }];
}

- (void) _alertUserSetting {
    
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示"  message:@"未授权定位服务，是否现在设置？" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        [alertVC dismissViewControllerAnimated:YES completion:nil];
    }];
    
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        NSLog(@"%@", [NSURL URLWithString:UIApplicationOpenSettingsURLString]);
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
    }];
    
    [alertVC addAction:cancelAction];
    [alertVC addAction:sureAction];
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertVC animated:YES completion:nil];
}

@end
