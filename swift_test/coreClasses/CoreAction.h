//
//  CoreAction.h
//  Infiniti
//
//  Created by Bob Huang on 13-12-8.
//  Copyright (c) 2013年 4view. All rights reserved.
// ---latest edited at 2015.02.09

#import <Foundation/Foundation.h>
#import "Config.h"
@interface CoreAction : NSObject

+(void)StartTrackNetwork;
+(BOOL)NetWorkIsWorking;
+(void)_uploadImage:(UIImage *)__image WithSuccessBlock:(void(^)(NSDictionary *dict))block AndFaileDBlock:(void(^)(NSError *error))failedBlock;
+(void)_getJsonFrom:(NSString *)__url WithSuccessBlock:(void(^)(NSDictionary *__dict))block AndFailBlock:(void(^)(NSError *error))faildBlock;
+(BOOL)_writeDict:(NSDictionary *)__dict ToFileByName:(NSString *)__name;
+(NSDictionary *)_getDictByName:(NSString *)__name;
+(void)_getImage:(NSString *)_imageUrl toImageView:(UIImageView *)__imageView;

+(NSString *)_saveImageAtLocation:(UIImage *)__image useName:(NSString *)__imageName;

+(void)_getStringFrom:(NSString *)__url  WithSuccessBlock:(void(^)(NSString *__string))block AndFailBlock:(void(^)(NSError *error))faildBlock;

+(void)_getStringFrom:(NSString *)__url WithParams:(NSDictionary *)__params SuccessBlock:(void (^)(NSString *__string))block AndFailBlock:(void(^)(NSError *error))faildBlock;
+(NSString *)_getFilePathByFullName:(NSString *)__name;


+(int)_networkingNum;

+(NSString *)_timeStr:(NSTimeInterval )__interval;
@end
