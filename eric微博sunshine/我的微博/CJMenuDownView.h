//
//  CJMenuDownView.h
//  我的微博
//
//  Created by 陈杰 on 16/1/5.
//  Copyright © 2016年 Eric. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+Extension.h"
@class CJMenuDownView;

@protocol CJMenuDownViewDelegate <NSObject>

- (void)menuDidClickUp:(CJMenuDownView *)up;
- (void)menuDidClickDown:(CJMenuDownView *)down;

@end

@interface CJMenuDownView : UIView

@property(strong,nonatomic) UIView *content;
@property(strong,nonatomic) UIViewController *contentView;

@property(strong,nonatomic) id <CJMenuDownViewDelegate>delegate;

+ (instancetype)menu;
- (void)showFrom:(UIView *)from;
- (void)dismiss;
@end
