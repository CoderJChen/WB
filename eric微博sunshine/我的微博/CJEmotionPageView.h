//
//  CJEmotionPageView.h
//  eric微博mysun
//
//  Created by 陈杰 on 16/1/27.
//  Copyright © 2016年 Eric. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CJEmotionModel.h"
#define CJEmotionMaxCols 7
#define CJEmotionMaxRows 3

#define KEmotionPageNumber ((CJEmotionMaxCols*CJEmotionMaxRows)-1)

@interface CJEmotionPageView : UIView
@property(strong,nonatomic)NSArray *emotions;
@end
