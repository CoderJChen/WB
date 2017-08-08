//
//  CJEmotionPageButton.m
//  eric微博mysun
//
//  Created by 陈杰 on 16/1/28.
//  Copyright © 2016年 Eric. All rights reserved.
//

#import "CJEmotionPageButton.h"
#import "CJEmotionModel.h"

@implementation CJEmotionPageButton
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setUp];
    }
    return self;
}
- (void)setUp{
    
    self.titleLabel.font = [UIFont systemFontOfSize:32.0];
    // 按钮高亮的时候。不要去调整图片（不要调整图片会灰色）
    self.adjustsImageWhenHighlighted = NO;
    //    self.adjustsImageWhenDisabled

}

- (void)setEmotions:(CJEmotionModel *)emotions{
    _emotions = emotions;
    
    if (emotions.png) {
        [self setImage:[UIImage imageNamed:emotions.png] forState:UIControlStateNormal];
    }else if (emotions.code){        
        [self setTitle:emotions.code.emoji forState:UIControlStateNormal];
    }
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
