//
//  CJEmotionToolModel.h
//  eric微博mysun
//
//  Created by 陈杰 on 16/1/29.
//  Copyright © 2016年 Eric. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CJEmotionModel;
@interface CJEmotionToolModel : NSObject
+ (void)addRecentEmotion:(CJEmotionModel *)emotion;
+ (NSArray *)recentEmotion;
@end
