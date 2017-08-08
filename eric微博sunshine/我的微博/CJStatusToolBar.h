//
//  CJStatusToolBar.h
//  eric微博mysun
//
//  Created by 陈杰 on 16/1/18.
//  Copyright © 2016年 Eric. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StatusModel.h"
@interface CJStatusToolBar : UIView
+ (instancetype)StatusToolBar;
@property(strong,nonatomic) StatusModel *statuses;
@end
