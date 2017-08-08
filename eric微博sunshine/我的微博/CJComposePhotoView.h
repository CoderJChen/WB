//
//  CJComposePhotoView.h
//  eric微博mysun
//
//  Created by 陈杰 on 16/1/22.
//  Copyright © 2016年 Eric. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CJComposePhotoView : UIView

@property(strong,nonatomic,readonly) NSMutableArray *photos;

- (void)addImage:(UIImage *)photo;

@end
