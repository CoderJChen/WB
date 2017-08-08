//
//  CJStatusPhotosView.h
//  eric微博mysun
//
//  Created by 陈杰 on 16/1/19.
//  Copyright © 2016年 Eric. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CJStatusPhotoView.h"
@interface CJStatusPhotosView : UIView

@property(strong,nonatomic) NSArray *photos;

+(CGSize)sizeWithcount:(NSInteger)count;

@end
