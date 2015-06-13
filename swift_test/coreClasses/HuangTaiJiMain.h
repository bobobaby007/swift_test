//
//  HuangTaiJiMain.h
//  huangtaiji_jb
//
//  Created by Bob Huang on 14-4-2.
//  Copyright (c) 2014年 4view. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HuangTaiJiMain : NSObject{
    
}




+(void)_getStatusWithSuccessBlock:(void(^)(NSString *__string))block AndFailBlock:(void(^)(NSError *error))faildBlock;

+(NSMutableDictionary *)_getSettings;
+(void)_getOrderWithSuccessBlock:(void(^)(NSString *__string))block AndFailBlock:(void(^)(NSError *error))faildBlock;
+(void)_finishOrderWithSuccessBlock:(void(^)(NSString *__string))block AndFailBlock:(void(^)(NSError *error))faildBlock;
+(void)_getProfileWithSuccessBlock:(void(^)(NSString *__string))block AndFailBlock:(void(^)(NSError *error))faildBlock;
+(void)_getProfileFor:(NSString *)__staffID WithSuccessBlock:(void(^)(NSString *__string))block AndFailBlock:(void(^)(NSError *error))faildBlock;
+(void)_loginAtUserName:(NSString *)__userName andPsw:(NSString *)__psw WithSuccessBlock:(void(^)(NSString *__string))block AndFailBlock:(void(^)(NSError *error))faildBlock;

+(void)_getFormList:(NSString *)__form WithSuccessBlock:(void(^)(NSString *__string))block AndFailBlock:(void(^)(NSError *error))faildBlock;

+(void)_changeFormList:(NSString *)__form From:(NSDictionary *)__form To:(NSDictionary *)__to WithSuccessBlock:(void(^)(NSString *__string))block AndFailBlock:(void(^)(NSError *error))faildBlock;

+(void)_testOrderWithDic:(NSDictionary *)__dict WithSuccessBlock:(void (^)(NSString *))block AndFailBlock:(void (^)(NSError *))faildBlock;


+(void)_setUser:(NSDictionary *)__dict;
+(NSDictionary *)_getUser;

+(void)_setOrder:(NSDictionary *)__dict;
+(NSDictionary *)_getOrder;

+(void)_setProfile:(NSDictionary *)__dict;
+(NSDictionary *)_getProfile;

+(void)setLogDate:(NSDate *)__date;

+(NSDate *)getLogDate;

//--提取



@end
