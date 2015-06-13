//
//  CoreAction.m
//  Infiniti
//
//  Created by Bob Huang on 13-12-8.
//  Copyright (c) 2013年 4view. All rights reserved.
//----latest edited see .h file

#import "CoreAction.h"
#import "Reachability.h"
#import "Config.h"
#import "AFJSONRequestOperation.h"
#import "UIImageView+WebCache.h"
#import "SDWebImageManager.h"
#import "AFHTTPRequestOperation.h"

static Reachability *myRechability;

static int _gettingNum=0;

@implementation CoreAction

+(void)StartTrackNetwork{
    if (!myRechability) {
       // NSString *remoteName=@"http://www.tom-tian.com/";//_basicUrl;
        //myRechability=[Reachability reachabilityWithHostName:remoteName];
        myRechability=[Reachability reachabilityForInternetConnection];
        [myRechability startNotifier];
    }
}

+(BOOL)NetWorkIsWorking{
    
    if (!myRechability) {
        [CoreAction StartTrackNetwork];
    }
    
    NetworkStatus status=[myRechability currentReachabilityStatus];
   
    //NSLog(@"NetWorkIsWorking:--%@",status);
    if (status==NotReachable) {
        return false;
    }else{
        return YES;
    }

}
#pragma mark---获取字典
+(NSDictionary *)_getDictByName:(NSString *)__name{
    NSDictionary *dict;
    NSString *__filePath=[CoreAction _getFilePathByFullName:[__name stringByAppendingString:@".plist"]];
    NSFileManager *fileManager=[NSFileManager defaultManager];
   
    if ([fileManager fileExistsAtPath:__filePath]) {
        dict=[[NSDictionary alloc] initWithContentsOfFile:__filePath];
        
        return dict;
    }
    return nil;
}

+(BOOL)_writeDict:(NSDictionary *)__dict ToFileByName:(NSString *)__name{
    
    
    //[__dict writeToURL:[NSURL URLWithString:[CoreAction _getFilePathByFullName:[__name stringByAppendingString:@".plist"]]] atomically:YES];

    BOOL ok=[__dict writeToFile:[CoreAction _getFilePathByFullName:[__name stringByAppendingString:@".plist"]] atomically:YES];
    
    return ok;
}
#pragma mark---获取文件地址
+(NSString *)_getFilePathByFullName:(NSString *)__name{
   
    NSString* string =[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        
    string = [string  stringByAppendingPathComponent:__name];
   
    return string;
}

#pragma mark---保存图片到本地
+(NSString *)_saveImageAtLocation:(UIImage *)__image useName:(NSString *)__imageName{
    
    NSString *__filePath=[CoreAction _getFilePathByFullName:@"appImages"];
    
   // NSLog(@"%@",__filePath);
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:__filePath]) {
        [fileManager createDirectoryAtPath:__filePath withIntermediateDirectories:YES attributes:Nil error:Nil];
    }else{
        
    }
    
  
    NSString *fileName;
    if ([__imageName isEqualToString:@""]) {
        NSDate *date=[NSDate date];
       fileName=[date description];
       fileName=[fileName stringByAppendingString:@".png"];
    }else{
       fileName=__imageName;
    }
    //=
    
    
    NSString *_imagePath=[__filePath stringByAppendingPathComponent:fileName];
   // NSLog(@"%@",_imagePath);
    NSData *imageData = UIImagePNGRepresentation(__image);
    [imageData writeToFile:_imagePath atomically:NO];
    return _imagePath;    
}

#pragma mark---加载图片
+(void)_getImage:(NSString *)_imageUrl toImageView:(UIImageView *)__imageView{
    
    //  NSLog(@"------start%@",_imageUrl);
    if (!_imageUrl||[_imageUrl isEqualToString:@""]) {
        return;
    }
    
    UIActivityIndicatorView *activeView=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [activeView startAnimating];
    [activeView setFrame:CGRectMake([__imageView frame].size.width*.5f, [__imageView frame].size.height*.5f, 50, 50)];
    [__imageView addSubview:activeView];
    
    if ([_imageUrl rangeOfString:@"/appImages/"].location !=NSNotFound){//-------来自保存本地的images文件夹
        [__imageView setImage:[UIImage imageWithContentsOfFile:_imageUrl]] ;
        [activeView removeFromSuperview];
    }else{
        NSString *_fullPath=_imageUrl;
        if ([_imageUrl rangeOfString:@"http:"].location == NSNotFound){//----来自网络，路径不包括域名
            _fullPath=[NSString stringWithFormat:@"%@%@",_basicUrl,_imageUrl];//
        }
        //NSLog(@"_fullPath:%@",_fullPath);
        [__imageView setImageWithURL:[NSURL URLWithString:_fullPath] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
            [activeView removeFromSuperview];
            
           // SDWebImageManager *imageManager=[SDWebImageManager sharedManager];
           // if ([imageManager diskImageExistsForURL:[NSURL URLWithString:_fullPath]]) {
               //  SDImageCache *imageCache=[SDImageCache sharedImageCache];
                 //[imageCache storeImage:image forKey:_fullPath toDisk:YES];
            //}
        }];
    }
}
#pragma mark 获取网络字段
+(void)_getStringFrom:(NSString *)__url  WithSuccessBlock:(void(^)(NSString *__string))block AndFailBlock:(void(^)(NSError *error))faildBlock{
    NSMutableURLRequest *request=[[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:__url]];
    
    AFHTTPRequestOperation *operation=[[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
       
        //NSArray *_dict=[NSJSONSerialization JSONObjectWithData:[operation.responseString dataUsingEncoding:NSASCIIStringEncoding] options:kNilOptions error:Nil];
        
        //NSLog(@"%@",[_dict objectAtIndex:1 ]);
        
        block(operation.responseString);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        faildBlock(error);
    }];
    [operation start];
}

+(void)_getStringFrom:(NSString *)__url WithParams:(NSDictionary *)__params SuccessBlock:(void(^)(NSString *__string))block AndFailBlock:(void(^)(NSError *error))faildBlock{
  
    
    
    NSMutableURLRequest *request=[[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:__url]];
   
    NSString *__str=@"";
    
    _gettingNum+=1;
    
    
    for (NSString *i in [__params allKeys]) {
       
        __str=[__str stringByAppendingString:[NSString stringWithFormat:@"%@=%@&",i,[__params objectForKey:i]]];
        
    }
    
    
    
    NSData *data=[__str dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:data];
    
    AFHTTPRequestOperation *opreration=[[AFHTTPRequestOperation alloc] initWithRequest:request];
    [opreration setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        _gettingNum-=1;
       // NSLog(@"_getStringFrom_ok:%@",operation.responseString);
        block(opreration.responseString);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        _gettingNum-=1;
        faildBlock(error);
    }];
    [opreration start];
    
    
}

//---获取json数据
+(void)_getJsonFrom:(NSString *)__url WithSuccessBlock:(void(^)(NSDictionary *__dict))block AndFailBlock:(void(^)(NSError *error))faildBlock{
   
    
    NSMutableURLRequest *request=[[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:__url]];
    
    NSString *post = nil;
    // post = [[NSString alloc] initWithFormat:@"format=%@",@"json"];//---4view
    post = [[NSString alloc] initWithFormat:@"order=%@",@"review"];//--tom
    
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:postData];
    
    AFJSONRequestOperation *operation=
    [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        block(JSON);
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        faildBlock(error);
    }];
    [operation start];
}

#pragma mark---提交图片到在线
+(void)_uploadImage:(UIImage *)__image WithSuccessBlock:(void(^)(NSDictionary *dict))block AndFaileDBlock:(void(^)(NSError *error))failedBlock{
    //把图片转换为NSData
    // UIImage *image = [UIImage imageNamed:@"vim_go.png"];
    NSLog(@"---start uploading image");
    NSData *imageData = UIImagePNGRepresentation(__image);
    // post url
    NSString *urlString = _uploadImageUrl;
    // setting up the request object now
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"POST"];
    //
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    //
    NSMutableData *body = [NSMutableData data];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"Content-Disposition: form-data; name=\"file\"; filename=\"vim_go.png\"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[NSData dataWithData:imageData]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [request setHTTPBody:body];
    AFJSONRequestOperation *operation=
    [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        block(JSON);       
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:FALSE];
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
      [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:FALSE];
        failedBlock(error);
    }];
    [operation start];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}


+(int)_networkingNum{
    return _gettingNum;
}


//---返回时间符串
+(NSString *)_timeStr:(NSTimeInterval )__interval{
    NSString *_str=@"";
    
    int _secNum=__interval;
    int _sec=_secNum%60;
    
    if (_sec<10) {
        _str=[NSString stringWithFormat:@"0%d",_sec];
    }else{
        _str=[NSString stringWithFormat:@"%d",_sec];
    }
    
    int _minNum=_secNum/60;
    int _min=_minNum%60;
    
    if (_min<10) {
        _str=[NSString stringWithFormat:@"0%d:%@",_min,_str];
    }else{
        _str=[NSString stringWithFormat:@"%d:%@",_min,_str];
    }
    
    
    int _hourNum=_minNum/60;
    int _hour=_hourNum%60;

    if (_hour<10) {
        _str=[NSString stringWithFormat:@"0%d:%@",_hour,_str];
    }else{
        _str=[NSString stringWithFormat:@"%d:%@",_hour,_str];
    }
    
    return  _str;
}

@end
