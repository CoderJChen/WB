//
//  CJEmotionTextAttachment.h
//  eric微博mysun
//
//  Created by 陈杰 on 16/1/29.
//  Copyright © 2016年 Eric. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CJEmotionModel.h"
@interface CJEmotionTextAttachment : NSTextAttachment
@property(strong,nonatomic) CJEmotionModel *emotion;
@end
