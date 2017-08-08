//
//  UserModel.h
//  eric微博mysun
//
//  Created by 陈杰 on 16/1/14.
//  Copyright © 2016年 Eric. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    HWUserVerifiedTypeNone = -1, // 没有任何认证
    
    HWUserVerifiedPersonal = 0,  // 个人认证
    
    HWUserVerifiedOrgEnterprice = 2, // 企业官方：CSDN、EOE、搜狐新闻客户端
    HWUserVerifiedOrgMedia = 3, // 媒体官方：程序员杂志、苹果汇
    HWUserVerifiedOrgWebsite = 5, // 网站官方：猫扑
    
    HWUserVerifiedDaren = 220 // 微博达人
} HWUserVerifiedType;


@interface UserModel : NSObject
//用户id
@property(strong,nonatomic) NSString * idstr;
//图片
@property(strong,nonatomic) NSString * profile_image_url;
//用户名字
@property(strong,nonatomic) NSString * name;

/** 会员类型 > 2代表是会员 */
@property (nonatomic, assign) int mbtype;
/** 会员等级 */
@property (nonatomic, assign) int mbrank;
@property (nonatomic, assign, getter = isVip) BOOL vip;
/** 认证类型 */
@property (nonatomic, assign) HWUserVerifiedType verified_type;

//- (id)initWithDictionary:(NSDictionary *)dict;
//+ (instancetype)userWithDictionary:(NSDictionary *)dict;
@end

