//
//  GHSAESDigest.m
//  GHS
//
//  Created by readtv_smx on 15/12/9.
//  Copyright (c) 2015年 ghs.net. All rights reserved.
//

//对称加密

#import "GHSAESDigest.h"

#import "AESCrypt.h"

#define AES_ENCRYPT_KEY @"sdjf^ew874w932" //我随便写的

@implementation GHSAESDigest


+ (NSString *)AESDigest:(NSString *)string {
    //加密--根据自己需要用哪个
    NSString * encryptString = [AESCrypt encrypt:string password:AES_ENCRYPT_KEY];
    
    // +  替换  $
    encryptString = [encryptString stringByReplacingOccurrencesOfString:@"+" withString:@"$"];
    
    
    
    //解密
//    NSString * dnCryptString = [AESCrypt decrypt:encryptString password:AES_ENCRYPT_KEY];
//    NSLog(@"AES = dnCryptString%@", dnCryptString);
    
    
   
    return encryptString;
}
@end
