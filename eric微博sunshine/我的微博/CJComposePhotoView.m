//
//  CJComposePhotoView.m
//  eric微博mysun
//
//  Created by 陈杰 on 16/1/22.
//  Copyright © 2016年 Eric. All rights reserved.
//

#import "CJComposePhotoView.h"

@implementation CJComposePhotoView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _photos = [NSMutableArray array];
    }
    return self;
}

- (void)addImage:(UIImage *)photo{
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.image = photo;
    [self addSubview:imageView];
    
    [self.photos addObject:photo];
}
- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat photoWH = 70;
    int maxCol = 4;
    
    for (int i =0; i<self.subviews.count; i++) {
        UIImageView *imageView = self.subviews[i];
        int col = i%maxCol;
        int row = i/maxCol;
        
        imageView.x = (photoWH+padding)*col;
        imageView.y = (photoWH+padding)*row;
        imageView.width =photoWH;
        imageView.height = photoWH;
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
