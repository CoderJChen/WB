//
//  CJEmotionTextAttachment.m
//  eric微博mysun
//
//  Created by 陈杰 on 16/1/29.
//  Copyright © 2016年 Eric. All rights reserved.
//

#import "CJEmotionTextAttachment.h"

@implementation CJEmotionTextAttachment

- (void)setEmotion:(CJEmotionModel *)emotion{
    _emotion =emotion;
    self.image = [UIImage imageNamed:emotion.png];
}
@end
