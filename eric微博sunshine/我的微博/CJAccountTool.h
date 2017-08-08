//
//  CJAccountTool.h
//  eric微博mysun
//
//  Created by 陈杰 on 16/1/13.
//  Copyright © 2016年 Eric. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Acount.h"
@interface CJAccountTool : NSObject
//存储账号信息
+ (void)saveAccount:(Acount *)account;
//读取账号信息数据
+ (Acount *)account;
@end
