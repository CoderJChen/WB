//
//  UserModel.m
//  eric微博mysun
//
//  Created by 陈杰 on 16/1/14.
//  Copyright © 2016年 Eric. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel

//set读方法
- (void)setMbtype:(int)mbtype{
    
    _mbtype =mbtype;
    if (mbtype>2) {
        self.vip = YES;
    }
}
//- (id)initWithDictionary:(NSDictionary *)dict{
//    if (self =[super init]) {
//        
//        self.name =dict[@"name"];
//        self.profile_image_url = dict[@"profile_image_url"];
//        self.idstr = dict[@"idstr"];
//    }
//    return self;
//}
//
//+ (instancetype)userWithDictionary:(NSDictionary *)dict{
//    
//    return [[self alloc]initWithDictionary:dict];
//    
//}
@end
