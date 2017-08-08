//
//  CJTabBar.h
//  我的微博
//
//  Created by 陈杰 on 16/1/6.
//  Copyright © 2016年 Eric. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CJTabBar;

@protocol CJTabBarDelegate <UITabBarDelegate>

- (void)tabBarDidClickBtn:(CJTabBar *)btn;

@end

@interface CJTabBar : UITabBar

@property(weak,nonatomic) id <CJTabBarDelegate> delegate;

+(instancetype)tabBar;
@end
