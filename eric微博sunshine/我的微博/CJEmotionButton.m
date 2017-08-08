//
//  CJEmotionButton.m
//  eric微博mysun
//
//  Created by 陈杰 on 16/1/26.
//  Copyright © 2016年 Eric. All rights reserved.
//

#import "CJEmotionButton.h"

@implementation CJEmotionButton
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
        self.titleLabel.font = [UIFont systemFontOfSize:13.0];
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
