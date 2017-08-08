//
//  CJEmotionPopView.m
//  eric微博mysun
//
//  Created by 陈杰 on 16/1/28.
//  Copyright © 2016年 Eric. All rights reserved.
//

#import "CJEmotionPopView.h"
#import "CJEmotionPageButton.h"
@interface CJEmotionPopView ()
@property (weak, nonatomic) IBOutlet CJEmotionPageButton *emotionButton;

@end

@implementation CJEmotionPopView
+(instancetype)popView{
    
    return [[[NSBundle mainBundle]loadNibNamed:@"CJEmotionPopView" owner:nil options:nil]lastObject];
}
//- (void)setEmotions:(CJEmotionModel *)emotions{
//    _emotions = emotions;
//    
//    self.emotionButton.emotions = emotions;
//}
- (void)showFrom:(CJEmotionPageButton *)button{
    if (button == nil) {
        return;
    }
    self.emotionButton.emotions =button.emotions;
    //    取的最外的视图
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    [window addSubview:self];
    
    CGRect btnFrame = [button convertRect:button.bounds toView:window];
    self.y = CGRectGetMidY(btnFrame)-self.height;
    self.centerX = CGRectGetMidX(btnFrame);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
