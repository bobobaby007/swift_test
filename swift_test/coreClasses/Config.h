//
//  Config.h
//  Infiniti
//
//  Created by Bob Huang on 13-12-8.
//  Copyright (c) 2013年 4view. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HuangTaiJiMain.h"

@interface Config : NSObject
//#define _basicUrl [[HuangTaiJiMain _getSettings] objectForKey:@"BasicUrl"]///@"http://192.168.3.69/huangtaiji/"//@"http://127.0.0.1/" //http://huangtaiji.4view.cn/

#define _basicUrl @"http://127.0.0.1/huangtaiji/"///@"http://127.0.0.1/" //http://huangtaiji.4view.cn/
//#define _basicUrl @"http://huangtaiji.4view.cn/"// @"http://192.168.0.2/huangtaiji/"//@"http://huangtaiji.4view.cn/"///@"http://127.0.0.1/" //http://huangtaiji.4view.cn/

#define _getStatusUrl [NSString stringWithFormat:@"%@%@",_basicUrl,@"getStatus.php"]
#define _dataListUrl [NSString stringWithFormat:@"%@%@",_basicUrl,@"dataList.php"]
#define _getOrderUrl [NSString stringWithFormat:@"%@%@",_basicUrl,@"getOrder.php"]
#define _loginUrl [NSString stringWithFormat:@"%@%@",_basicUrl,@"login.php"]
#define _finishOrderUrl [NSString stringWithFormat:@"%@%@",_basicUrl,@"finishOrder.php"]
#define _getProfileUrl [NSString stringWithFormat:@"%@%@",_basicUrl,@"getProfile.php"]
#define _orderUrl [NSString stringWithFormat:@"%@%@",_basicUrl,@"order.php"]


#define _uploadImageUrl @""//





@end
