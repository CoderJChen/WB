//
//  CJEmotionPopView.h
//  eric微博mysun
//
//  Created by 陈杰 on 16/1/28.
//  Copyright © 2016年 Eric. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CJEmotionModel,CJEmotionPageButton;
@interface CJEmotionPopView : UIView
+(instancetype)popView;
//@property(strong,nonatomic) CJEmotionModel *emotions;

- (void)showFrom:(CJEmotionPageButton *)button;
@end
