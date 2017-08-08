//
//  Acount.h
//  eric微博mysun
//
//  Created by 陈杰 on 16/1/13.
//  Copyright © 2016年 Eric. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Acount : NSObject<NSCoding>
/*
"access_token" = "2.00vgscUDl7qIiB6f19d2d7f90vFhqK";
"expires_in" = 157679999;
"remind_in" = 157679999;
uid = 3200955277;
 */
//授权后得到的token
@property(strong,nonatomic) NSString *access_token;
//access_token的生命周期，单位是秒数。
@property(strong,nonatomic) NSNumber *expires_in;
//将要被废弃
@property(strong,nonatomic) NSString *remind_in;
//用户的id
@property(strong,nonatomic) NSString *uid;

@property(strong,nonatomic) NSDate *create_time;
//昵称
@property(strong,nonatomic) NSString  *name;


-(id)initWithDictionary:(NSDictionary *)dict;

+(instancetype)accountWithDictionary:(NSDictionary *)dict;

@end
