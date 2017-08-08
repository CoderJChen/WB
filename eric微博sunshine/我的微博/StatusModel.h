//
//  StatusModel.h
//  eric微博mysun
//
//  Created by 陈杰 on 16/1/14.
//  Copyright © 2016年 Eric. All rights reserved.
//

#import <Foundation/Foundation.h>
@class UserModel;
@interface StatusModel : NSObject

@property(strong,nonatomic) NSString *idstr;
@property(strong,nonatomic) NSString *text;
@property(strong,nonatomic) UserModel *user;

/**string	微博创建时间*/
@property(strong,nonatomic) NSString *created_at;

/**微博来源*/
@property(strong,nonatomic) NSString *source;

/**微博配图地址。多图时返回多图链接。无配图返回“[]”*/
@property(strong,nonatomic) NSArray *pic_urls;

/**	object	被转发的原微博信息字段，当该微博为转发微博时返回*/
@property(strong,nonatomic) StatusModel *retweeted_status;

/**	int	转发数*/
@property (nonatomic, assign) int reposts_count;
/**	int	评论数*/
@property (nonatomic, assign) int comments_count;
/**	int	表态数*/
@property (nonatomic, assign) int attitudes_count;

@end
