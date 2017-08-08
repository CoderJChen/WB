//
//  StatusFrameModel.h
//  eric微博mysun
//
//  Created by 陈杰 on 16/1/16.
//  Copyright © 2016年 Eric. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class StatusModel;
@interface StatusFrameModel : NSObject
/* 原创微博 */
/** 原创微博整体 */
@property (nonatomic, assign) CGRect originalViewF;
/** 头像 */
@property (nonatomic, assign) CGRect iconViewF;
/** 会员图标 */
@property (nonatomic, assign) CGRect vipViewF;
/** 配图 */
@property (nonatomic, assign) CGRect photoViewF;
/** 昵称 */
@property (nonatomic, assign) CGRect nameLabelF;
/** 时间 */
@property (nonatomic, assign) CGRect timeLabelF;
/** 来源 */
@property (nonatomic, assign) CGRect sourceLabelF;
/** 正文 */
@property (nonatomic, assign) CGRect contentLabelF;
/**cell高度*/
@property(assign,nonatomic) CGFloat cellH;

/* 转发微博 */
/** 转发微博整体 */
@property (nonatomic, assign) CGRect retweetViewF;
/** 转发微博正文 + 昵称 */
@property (nonatomic, assign) CGRect retweetContentLabelF;
/** 转发配图 */
@property (nonatomic, assign) CGRect retweetPhotoViewF;

/**工具条*/
@property(assign,nonatomic) CGRect toolStatusViewF;

@property(strong,nonatomic) StatusModel *status;

@end
