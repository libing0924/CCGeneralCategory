//
//  LBDataSecure.h
//  LBCategoryLibrary
//
//  Created by smufs on 2017/3/8.
//  Copyright © 2017年 李冰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LBDataSecure : NSObject

/**
 * MD5加密(签名)
 *
 *
 */
+ (NSString *) MD5WithString:(NSString *) string;


/**
 * SHA加密(签名)
 *
 *
 */
+ (NSString *) Sha1WithString:(NSString *) str;

+ (NSString *) Sha256WithString:(NSString *) str;

+ (NSString *) Sha512WithString:(NSString *) str;


/**
 * AES128加密解密
 *
 *
 */
+ (NSString *)encryptAES:(NSString *)content key:(NSString *)key;
+ (NSString *)decryptAES:(NSString *)content key:(NSString *)key;

@end
