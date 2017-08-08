//
//  CJEmotionTextView.h
//  eric微博mysun
//
//  Created by 陈杰 on 16/1/29.
//  Copyright © 2016年 Eric. All rights reserved.
//

#import "CJTextView.h"
@class CJEmotionModel;
@interface CJEmotionTextView : CJTextView
- (void)insertEmotion:(CJEmotionModel *)emotion;
- (NSString *)fullText;
@end
