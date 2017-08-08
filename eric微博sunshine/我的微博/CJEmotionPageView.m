//
//  CJEmotionPageView.m
//  eric微博mysun
//
//  Created by 陈杰 on 16/1/27.
//  Copyright © 2016年 Eric. All rights reserved.
//

#import "CJEmotionPageView.h"
#import "CJEmotionPageButton.h"
#import "CJEmotionPopView.h"
#import "CJEmotionToolModel.h"
@interface CJEmotionPageView ()
/**显示放大镜*/
@property(strong,nonatomic)CJEmotionPopView *popView;
@property(strong,nonatomic)UIButton *deleteBtn;
@end

@implementation CJEmotionPageView
- (CJEmotionPopView *)popView{
    if (_popView==nil) {
        self.popView = [CJEmotionPopView popView];
    }
    return _popView;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"compose_emotion_delete"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"compose_emotion_delete_highlighted"] forState:UIControlStateHighlighted];
        [btn addTarget:self action:@selector(deleteClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        self.deleteBtn =btn;
        
        [self addGestureRecognizer:[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressPageView:)]];
    }
    return self;
}
- (CJEmotionPageButton *)emotionButtonWithLocation:(CGPoint)location{
    
    NSUInteger count = self.emotions.count;
    for (int i = 0; i<count; i++) {
        CJEmotionPageButton *btn = self.subviews[i + 1];
        
        if (CGRectContainsPoint(btn.frame, location)) {
            
            // 已经找到手指所在的表情按钮了，就没必要再往下遍历
            return btn;
        }
    }
    return nil;
}
- (void)longPressPageView:(UILongPressGestureRecognizer*)recognizer{
    CGPoint location = [recognizer locationInView:recognizer.view];
    // 获得手指所在的位置\所在的表情按钮
    CJEmotionPageButton *btn = [self emotionButtonWithLocation:location];
    
    switch (recognizer.state) {
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded: // 手指已经不再触摸pageView
            // 移除popView
            [self.popView removeFromSuperview];
            
            // 如果手指还在表情按钮上
            if (btn) {
                // 发出通知
                [self selectEmotion:btn.emotions];
            }
            break;
            
        case UIGestureRecognizerStateBegan: // 手势开始（刚检测到长按）
        case UIGestureRecognizerStateChanged: { // 手势改变（手指的位置改变）
            [self.popView showFrom:btn];
            break;
        }
            
        default:
            break;
    }

}
- (void)setEmotions:(NSArray *)emotions{
    _emotions =emotions;
    
    for (int i = 0; i<emotions.count; i++) {
        
        CJEmotionPageButton *btn = [[CJEmotionPageButton alloc]init];
       // btn.backgroundColor = KRandomColor;
        
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        btn.emotions = emotions[i];
        
        [self addSubview:btn];
        
    }
}
- (void)btnClick:(CJEmotionPageButton *)btn{
   // NSLog(@"btnClick");
    //给放大镜传值
//    self.popView.emotions = btn.emotions;
    [self.popView showFrom:btn];
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.popView removeFromSuperview];
    });
    //发出通知
    [self selectEmotion:btn.emotions];
}
- (void)selectEmotion:(CJEmotionModel *)emotion{
    
    [CJEmotionToolModel addRecentEmotion:emotion];
    
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    userInfo[CJSelectEmotionKey]= emotion;
    
    [CJNotificationCenter postNotificationName:CJEmotionDidSelectNotification object:nil userInfo:userInfo];

    
}
- (void)deleteClick:(UIButton *)deleteBtn{
    
    [CJNotificationCenter postNotificationName:CJEmotionDidDeleteNotification object:nil];
}
- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    int margin =20;
    
    CGFloat btnW = (self.width-2*margin)/CJEmotionMaxCols;
    CGFloat btnH = (self.height-margin)/CJEmotionMaxRows;
    
    NSUInteger count = self.emotions.count;
    
    for (int i =0; i<count; i++) {
        UIButton *btn = self.subviews[i+1];
        
        int col =i%CJEmotionMaxCols;
        int row = i/CJEmotionMaxCols;
        
        btn.width = btnW;
        btn.height = btnH;
        btn.x = margin + col*btnW;
        btn.y = margin + row*btnH;
    }
    
    self.deleteBtn.width = btnW;
    self.deleteBtn.height = btnH;
    self.deleteBtn.x = self.width-margin-btnW;
    self.deleteBtn.y = self.height -btnH;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
