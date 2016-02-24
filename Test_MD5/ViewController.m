//
//  ViewController.m
//  Test_MD5
//
//  Created by readtv on 15/7/1.
//  Copyright (c) 2015年 readtv. All rights reserved.
//

#import "ViewController.h"
//Xcode 自带的MD5加密,,,下面导入的是，所有自带的加密方法
#import <CommonCrypto/CommonDigest.h>

//这个是MRC 需要 -fno-objc-arc
#import "GTMBase64.h"


#import "GHSAESDigest.h"
#import "GHSRSADigest.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    


    [self show_md5_txt];
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(10, 80, 100, 100);
    btn.backgroundColor = [UIColor redColor];
    [btn addTarget:self action:@selector(show_md5_txt) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    
    
    
    
#pragma mark - ~~~~~~~~~~~---------~~~~~~~~~~~~~~~
    //我自己封装了下
    
    //    1
    NSString * RSA = [GHSRSADigest RSADigest:@"接口数据参数device_id='iOS'user_id='12'...."];
    
    NSString * Aes = [GHSAESDigest AESDigest:@"接口数据参数device_id='iOS'user_id='12'...."];
    
    
    //    2
    //在根据服务器要求，，例如
    //接口请求 就会为  http://www.baidu.com/index.php/dict=RSA
    
    //        而你看到会是 http://www.baidu.com/index.php/dict=gjgeh3y3292W$#T$#9afsahgregherihagdfgrhegiogbgfdlhsdggjerighr#$%$^$%dpfejwrg9hgefisghshsghsdaf
    
    
    //相应最新的包，，，去gitHub 下载
    /**
     
     
     这个 RSA  和 AES 基本都请求接口 加密处理
     
     下面的都是我的再次封装，让程序变得更简单
     
     GHSRSADigest 非对称加密
     
     
     GHSAESDigest 对称加密
     
     */

  
}

/***
 *代码都是来源于，网络<百度>
 *
 */

- (void)show_md5_txt
{
    
    NSLog(@"\nmd5在此网站验证是否正确：%@", @"http://tool.chinaz.com/Tools/MD5.aspx");

    
    NSLog(@"~~~~~md5_32_low=%@~~~~", [self md5HexDigest:@"srx"]);
    NSLog(@"~~~~~md5_32_upp=%@~~~~", [[self md5HexDigest:@"srx"] uppercaseString]);

    
    NSLog(@"~~~~~md5_16_low=%@~~~~", [self getMd5_16Bit_String:@"srx"]);
    NSLog(@"~~~~~md5_16_upp=%@~~~~", [[self getMd5_16Bit_String:@"srx"] uppercaseString]);
    
    
    NSLog(@"\n\n~~~~~下面的在此网站验证=%@~~~~", @"http://encode.chahuo.com");

    
    NSLog(@"~~~~~sha1=%@~~~~", [self getSha1String:@"srx"]);

    NSLog(@"~~~~~sha224=%@~~~~", [self sha224:@"srx"]);
    NSLog(@"~~~~~sha256=%@~~~~", [self sha256:@"srx"]);
    NSLog(@"~~~~~sha384=%@~~~~", [self sha384:@"srx"]);
    
    NSLog(@"~~~~~sha512=%@~~~~", [self getSha512String:@"srx"]);

    NSLog(@"~~~~~\\\\\\\\\\\\~~~~\n\n\n");

    NSLog(@"~~~~~base64_加密=%@~~~~", [self base64_encodeData:@"srx"]);
    
    NSLog(@"~~~~~base64_解密=%@~~~~", [self base64_decodeData:[self base64_encodeData:@"srx"]]);


}


//----------------- 对于用户密码 ，设备，macAddress的加密-----------------

//32 小写
- (NSString *)md5HexDigest:(NSString*)password
{
    const char *original_str = [password UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(original_str, strlen(original_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++)
    {
        [hash appendFormat:@"%02X", result[i]];
    }
    NSString *mdfiveString = [hash lowercaseString];
    
    //NSLog(@"Encryption Result = %@",mdfiveString);
    return mdfiveString;
}

//16
//想要实现16位加密？
//很简单，提取md5散列中的16位就行！（复制以下代码及上一段代码到当前类中）
- (NSString *)getMd5_16Bit_String:(NSString *)srcString{
    //提取32位MD5散列的中间16位
    NSString *md5_32Bit_String=[self md5HexDigest:srcString];
    NSString *result = [[md5_32Bit_String substringToIndex:24] substringFromIndex:8];//即9～25位
    
    return result;
}


//[sha1转换]
- (NSString *)getSha1String:(NSString *)srcString{
    const char *cstr = [srcString cStringUsingEncoding:NSUTF8StringEncoding];
    
    NSData *data = [NSData dataWithBytes:cstr length:srcString.length];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, data.length, digest);
    
    NSMutableString* result = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH *2];
    
    for(int i =0; i < CC_SHA1_DIGEST_LENGTH; i++) {
        [result appendFormat:@"%02x", digest[i]];
    }
    
    return result;
}





//sha512加密方式
- (NSString*) getSha512String:(NSString*)srcString {
    const char *cstr = [srcString cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:srcString.length];
    uint8_t digest[CC_SHA512_DIGEST_LENGTH];
    
    CC_SHA512(data.bytes, data.length, digest);
    
    NSMutableString* result = [NSMutableString stringWithCapacity:CC_SHA512_DIGEST_LENGTH *2];
    for(int i =0; i < CC_SHA512_DIGEST_LENGTH; i++)
        [result appendFormat:@"%02x", digest[i]];
    return result;
}

/***
 
 你需要用到哪一个，就添加哪一个私有方法。调用即可。
 
 [总结]
 个人认为sha加密和md5加密完全没必要去导入第三方类库，实际上调用共享库以后就是一个私有方法几行代码的事，何必搞那么复杂呢？
 需要用到AES加密及base64加密的同学请绕道GTMbase64这个第三方类库，封装的很好了，百度搜一下下载下来就行。

 */





- (NSString*) sha224:(NSString *)cstring
{
    const char *cstr = [cstring cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:cstring.length];
    
    uint8_t digest[CC_SHA224_DIGEST_LENGTH];
    
    CC_SHA224(data.bytes, data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA224_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA224_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
}

- (NSString*) sha256:(NSString *)cstring
{
    const char *cstr = [cstring cStringUsingEncoding:NSUTF8StringEncoding];
    
    NSData *data = [NSData dataWithBytes:cstr length:cstring.length];
    
    uint8_t digest[CC_SHA256_DIGEST_LENGTH];
    
    CC_SHA256(data.bytes, data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA256_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA256_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
}


- (NSString*) sha384:(NSString *)cstring
{
    const char *cstr = [cstring cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:cstring.length];
    
    uint8_t digest[CC_SHA384_DIGEST_LENGTH];
    
    CC_SHA384(data.bytes, data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA384_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA384_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
}


//----------------- base64加密，，对于缓存的加密 -----------------


- (NSString*) base64_encodeData:(NSString *)string
{
    NSData *data= [string dataUsingEncoding:NSUTF8StringEncoding];
    if([data length]>0){
        data = [GTMBase64 encodeData:data];//编码
    }
    
    //        if([data length]>0){
    //            data = [GTMBase64 decodeData:data];//解码
    //        }
    
    NSString *retStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return retStr;
//----------------- <#there tickName#> -----------------
}



- (NSString*) base64_decodeData:(NSString *)string
{
    
    NSData *data= [string dataUsingEncoding:NSUTF8StringEncoding];
//    if([data length]>0){
//        data = [GTMBase64 encodeData:data];//编码
//    }
    
            if([data length]>0){
                data = [GTMBase64 decodeData:data];//解码
            }
    
    NSString *retStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return retStr;
}

/***
 *      其他的base64
 *http://blog.csdn.net/zhangmiaoping23/article/details/38845155
 *3DES＋Base64 加密解密的方法
 */

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
