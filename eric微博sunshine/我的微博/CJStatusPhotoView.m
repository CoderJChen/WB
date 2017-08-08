//
//  CJStatusPhotoView.m
//  eric微博mysun
//
//  Created by 陈杰 on 16/1/19.
//  Copyright © 2016年 Eric. All rights reserved.
//

#import "CJStatusPhotoView.h"
#import "CJPhotoModel.h"
#import "UIImageView+WebCache.h"

@interface CJStatusPhotoView ()

@property(strong,nonatomic)UIImageView *giftView;
@end

@implementation CJStatusPhotoView
- (UIImageView *)giftView{
    if (_giftView ==nil) {
        UIImageView *gift =[[UIImageView alloc]init];
        gift.image = [UIImage imageNamed:@"timeline_image_gif"];
        
        [self addSubview:gift];
        _giftView = gift;
    }
    return _giftView;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        内容设置
        self.contentMode = UIViewContentModeScaleAspectFill;
//    超出边框的剪除
        self.clipsToBounds = YES;
    }
    return self;
}
-(void)setPhoto:(CJPhotoModel *)photo{
    
    _photo =photo;

    NSURL *url = [NSURL URLWithString:photo.thumbnail_pic];
    UIImage *image = [UIImage imageNamed:@"timeline_image_placeholder"];
    [self sd_setImageWithURL:url placeholderImage:image];
    
    if ([photo.thumbnail_pic.lowercaseString hasSuffix:@"gift"]) {
        self.hidden = NO;
    }else{
        self.hidden = YES;
    }

    
}
-(void)layoutSubviews{
    
    self.giftView.x = self.width - self.giftView.width;
    self.giftView.y = self.height - self.giftView.height;
    
}
@end
