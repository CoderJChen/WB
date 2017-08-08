//
//  CJStatusPhotosView.m
//  eric微博mysun
//
//  Created by 陈杰 on 16/1/19.
//  Copyright © 2016年 Eric. All rights reserved.
//

#import "CJStatusPhotosView.h"
#define KStatusPhotoWH 70
#define KStatusPhotoColMax(count) (count==4)?2:3

@implementation CJStatusPhotosView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self =[super initWithFrame:frame]) {
        //self.backgroundColor = [UIColor redColor];
    }
    return self;
}
- (void)setPhotos:(NSArray *)photos{
    _photos= photos;
    //当子控件少于需要的控件数
    while(self.subviews.count < photos.count) {
        CJStatusPhotoView *photosView = [[CJStatusPhotoView alloc]init];
        [self addSubview:photosView];
    }
    
    for (int i =0; i<self.subviews.count;i++) {
        CJStatusPhotoView *imageView = self.subviews[i];
        if (i>=photos.count) {
            imageView.hidden = YES;
        }else{
            imageView.photo = photos[i];
            imageView.hidden = NO;
        }
    }
}

+(CGSize)sizeWithcount:(NSInteger)count{
    
    NSInteger maxCol = KStatusPhotoColMax(count);
    
//    int col = count%3;
    NSInteger col = count>=maxCol ? maxCol:count;
    
    CGFloat imageW = col*KStatusPhotoWH +(col-1)*padding;
    //int row = count/3;
    // CGFloat imageH = maxCol *KStatusPhotoWH +(row -1)*padding;
    NSInteger rows =(count + maxCol -1)/maxCol;
    CGFloat imageH = rows * KStatusPhotoWH +(rows-1)*padding;
    
    return CGSizeMake(imageW, imageH);
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    int maxCol = KStatusPhotoColMax(self.photos.count);    
    for (int i =0; i< self.photos.count; i++) {
        CJStatusPhotoView *image = self.subviews[i];
        int col = i % maxCol;
        int row = i/maxCol;
        image.width = KStatusPhotoWH;
        image.height = KStatusPhotoWH;
        image.x = col*(KStatusPhotoWH + padding);
        image.y = row*(KStatusPhotoWH +padding);
    }
    
}
@end
