//
//  Acount.m
//  eric微博mysun
//
//  Created by 陈杰 on 16/1/13.
//  Copyright © 2016年 Eric. All rights reserved.
//

#import "Acount.h"

@implementation Acount
/*
 "access_token" = "2.00vgscUDl7qIiB6f19d2d7f90vFhqK";
 "expires_in" = 157679999;
 "remind_in" = 157679999;
 uid = 3200955277;
 */

-(id)initWithDictionary:(NSDictionary *)dict{
    if (self = [super init]) {
        
        self.access_token =dict[@"access_token"];
        self.expires_in = dict[@"expires_in"];
        self.remind_in = dict[@"remind_in"];
        self.uid = dict[@"uid"];
        self.create_time = [NSDate date];
    }
    return self;
}

+(instancetype)accountWithDictionary:(NSDictionary *)dict{
    
    return [[self alloc]initWithDictionary:dict];
    
}
/*
 * 当一个对象要归档进沙盒中去，就会调用这个方法
 *目的：在这个方法中说明这个对象的那些属性要存进沙盒
  */
- (void)encodeWithCoder:(NSCoder *)aCoder{
    
    [aCoder encodeObject:self.access_token forKey:@"access_token"];
    [aCoder encodeObject:self.expires_in forKey:@"expires_in"];
    [aCoder encodeObject:self.uid forKey:@"uid"];
    [aCoder encodeObject:self.create_time forKey:@"create_time"];
    [aCoder encodeObject:self.name forKey:@"name"];
}
/*
 *  当从沙盒中解档一个对象时（从沙盒中加载一个对象时），就会调用这个方法
 *  目的：在这个方法中说明沙盒中的属性该怎么解析（需要取出哪些属性）
 */
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    if (self = [super init]) {
        
        self.access_token = [aDecoder decodeObjectForKey:@"access_token"];
        self.expires_in = [aDecoder decodeObjectForKey:@"expires_in"];
        self.uid = [aDecoder decodeObjectForKey:@"uid"];
        self.create_time = [aDecoder decodeObjectForKey:@"create_time"];
        self.name = [aDecoder decodeObjectForKey:@"name"];
        
    }
    return self;
}

@end
