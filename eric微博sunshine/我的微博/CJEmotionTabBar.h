//
//  CJEmotionTabBar.h
//  eric微博mysun
//
//  Created by 陈杰 on 16/1/26.
//  Copyright © 2016年 Eric. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CJEmotionTabBar;
typedef enum {
    CJEmotionTabBarButtonTypeRecent, // 最近
    CJEmotionTabBarButtonTypeDefault, // 默认
    CJEmotionTabBarButtonTypeEmoji, // emoji
    CJEmotionTabBarButtonTypeLxh, // 浪小花
} CJEmotionTabBarButtonType;
@protocol  CJEmotionTabBarDelegate<NSObject>

- (void)emotionBtn:(CJEmotionTabBar *)btn buttonType:(CJEmotionTabBarButtonType)btnType;

@end
@interface CJEmotionTabBar : UIView
@property(assign,nonatomic)CJEmotionTabBarButtonType type;
@property(strong,nonatomic) id <CJEmotionTabBarDelegate>delegate;
@end
