//
//  HuangTaiJiMain.m
//  huangtaiji_jb
//
//  Created by Bob Huang on 14-4-2.
//  Copyright (c) 2014年 4view. All rights reserved.
//

#import "HuangTaiJiMain.h"
#import "Config.h"
#import "CoreAction.h"

static NSMutableDictionary *_settings;
static NSDictionary *_userDict;
static NSDictionary *_orderDict;
static NSDictionary *_profileDict;
static NSDate *_logDate;

@implementation HuangTaiJiMain{
    
}


//+(NSString *)_getStatus{
    //return _getStatusUrl;
   // return [NSString stringWithContentsOfURL:[NSURL URLWithString:_getStatusUrl] encoding:NSUTF8StringEncoding error:nil];
//}


+(void)_getStatusWithSuccessBlock:(void (^)(NSString *))block AndFailBlock:(void (^)(NSError *))faildBlock{
    
    NSString *_str=[NSString stringWithFormat:@"%@",[[HuangTaiJiMain _getUser] objectForKey:@"store_id"]];
    //NSLog(@"%@",[HuangTaiJiMain _getUser]);
    //return;
    NSDictionary *_dict=[[NSDictionary alloc] initWithObjectsAndKeys:_str, @"id",nil];
    [CoreAction _getStringFrom:_getStatusUrl WithParams:_dict SuccessBlock:block AndFailBlock:faildBlock];
}

+(NSMutableDictionary *)_getSettings{
    if (!_settings) {
        _settings=[[NSMutableDictionary alloc] initWithDictionary:[CoreAction _getDictByName:@"settings"]];
        if ([_settings objectForKey:@"BasicUrl"]==nil) {
            _settings=[[NSMutableDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"settings" ofType:@"plist"]];
            [CoreAction _writeDict:_settings ToFileByName:@"settings"];
        }else{
            NSLog(@"hasSaveed");
        }
    }
    return _settings;
}

+(void)_getOrderWithSuccessBlock:(void (^)(NSString *))block AndFailBlock:(void (^)(NSError *))faildBlock{
    
    NSString *_str=[NSString stringWithFormat:@"{\"staff_id\":%@}",[[HuangTaiJiMain _getUser] objectForKey:@"staff_id"]];
    NSLog(@"%@",_str);
    NSDictionary *_dict=[[NSDictionary alloc] initWithObjectsAndKeys:_str, @"docs",nil];
    [CoreAction _getStringFrom:_getOrderUrl WithParams:_dict SuccessBlock:block AndFailBlock:faildBlock];
}

+(void)_getProfileWithSuccessBlock:(void(^)(NSString *__string))block AndFailBlock:(void(^)(NSError *error))faildBlock{
    NSDictionary *_dict=[[NSDictionary alloc] initWithObjectsAndKeys:[[HuangTaiJiMain _getUser] objectForKey:@"staff_id"], @"staff_id",nil];
    [CoreAction _getStringFrom:_getProfileUrl WithParams:_dict SuccessBlock:block AndFailBlock:faildBlock];
}
+(void)_getProfileFor:(NSString *)__staffID WithSuccessBlock:(void(^)(NSString *__string))block AndFailBlock:(void(^)(NSError *error))faildBlock{
    NSDictionary *_dict=[[NSDictionary alloc] initWithObjectsAndKeys:__staffID, @"staff_id",nil];
    [CoreAction _getStringFrom:_getProfileUrl WithParams:_dict SuccessBlock:block AndFailBlock:faildBlock];
}
//------admin--
+(void)_getFormList:(NSString *)__form WithSuccessBlock:(void(^)(NSString *__string))block AndFailBlock:(void(^)(NSError *error))faildBlock{
    NSDictionary *_dict=[[NSDictionary alloc] initWithObjectsAndKeys:__form, @"form",@"getAll",@"action",nil];
    [CoreAction _getStringFrom:_dataListUrl WithParams:_dict SuccessBlock:block AndFailBlock:faildBlock];
}
+(void)_changeFormList:(NSString *)__form From:(NSString *)__from To:(NSString *)__to WithSuccessBlock:(void(^)(NSString *__string))block AndFailBlock:(void(^)(NSError *error))faildBlock{
    
    NSDictionary *_dict=[[NSDictionary alloc] initWithObjectsAndKeys:__form, @"form",@"change",@"action",__from,@"from",__to,@"to",nil];
    [CoreAction _getStringFrom:_dataListUrl WithParams:_dict SuccessBlock:block AndFailBlock:faildBlock];
}


//------
+(void)_finishOrderWithSuccessBlock:(void(^)(NSString *__string))block AndFailBlock:(void(^)(NSError *error))faildBlock{
    NSString *_str=[NSString stringWithFormat:@"{\"order_id\":%@}",[[HuangTaiJiMain _getOrder] objectForKey:@"order_id"]];
    NSLog(@"%@",_str);
    NSDictionary *_dict=[[NSDictionary alloc] initWithObjectsAndKeys:_str, @"docs",nil];
    [CoreAction _getStringFrom:_finishOrderUrl WithParams:_dict SuccessBlock:block AndFailBlock:faildBlock];
}

+(void)_loginAtUserName:(NSString *)__userName andPsw:(NSString *)__psw WithSuccessBlock:(void(^)(NSString *__string))block AndFailBlock:(void(^)(NSError *error))faildBlock{
    NSDictionary *_dict=[[NSDictionary alloc] initWithObjectsAndKeys:__userName,@"userName",__psw,@"psw",nil];
    [CoreAction _getStringFrom:_loginUrl WithParams:_dict SuccessBlock:block AndFailBlock:faildBlock];
}

+(void)_testOrderWithDic:(NSDictionary *)__dict WithSuccessBlock:(void (^)(NSString *))block AndFailBlock:(void (^)(NSError *))faildBlock{    
    NSDictionary *_dict=__dict;
    [CoreAction _getStringFrom:_orderUrl WithParams:_dict SuccessBlock:block AndFailBlock:faildBlock];
}

+(void)_setUser:(NSDictionary *)__dict{
    _userDict=__dict;
}
+(NSDictionary *)_getUser{
    return _userDict;
}


+(void)_setOrder:(NSDictionary *)__dict{
    _orderDict=__dict;
    
}
+(NSDictionary *)_getOrder{
    return _orderDict;
}

+(void)_setProfile:(NSDictionary *)__dict{
    _profileDict=__dict;
}
+(NSDictionary *)_getProfile{
    return _profileDict;
}

+(void)setLogDate:(NSDate *)__date{
    _logDate=__date;
}

+(NSDate *)getLogDate{
    return _logDate;
}
@end
