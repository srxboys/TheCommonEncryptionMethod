//
//  GHSRSADigest.m
//  GHS
//
//  Created by readtv_smx on 15/12/9.
//  Copyright (c) 2015年 ghs.net. All rights reserved.
//

#import "GHSRSADigest.h"

#import "GHSRSA.h"

//这个主意  --- 这个有几个，必须要和 加密处理和解密处理 的[字符串匹配] 【在RSA.m里有】


//这个不能测试，这个需要后台 给你

//公钥
#define RSAPublic @"-----BEGIN PUBLIC KEY-----\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDCnItYo2b9gQzB+XrTGOMicTbe\nT7VR/v+PtMZs363VXNac2Na9wYNWvEThWCH5E+tpFYEuCzqfW+hHwjjXsKNK1YiF..............\n-----END PUBLIC KEY-----"

//私钥
#define RSAPrivate @"232432"

//非对称加密

@implementation GHSRSADigest

+ (NSString *)RSADigest:(NSString *)string {
    if([string isKindOfClass:[NSNull class]] || [string isEqualToString:@""]) {
        return @" ";
    }
    //加密 处理--根据自己需要用哪个
    NSString * encWithPubKey = [GHSRSA encryptString:string publicKey:RSAPublic];
    
    // +  替换  $
    encWithPubKey = [encWithPubKey stringByReplacingOccurrencesOfString:@"+" withString:@"$"];
    
    
    //解密-- 这个通常客户端不需要，所有解密的都是服务端处理
//    NSString * decWithPrivKey = [GHSRSA decryptString:encWithPubKey privateKey:RSAPrivate];
//    NSLog(@"Decrypted with private key: %@", decWithPrivKey);
//    
//    
    return encWithPubKey;
}

@end
