//
//  CJIconView.m
//  eric微博mysun
//
//  Created by 陈杰 on 16/1/20.
//  Copyright © 2016年 Eric. All rights reserved.
//

#import "CJIconView.h"
#import "UserModel.h"
#import "UIImageView+WebCache.h"

@interface CJIconView ()
@property(nonatomic,strong)UIImageView *verified_type;
@end

@implementation CJIconView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}
-(UIImageView *)verified_type{
    if (_verified_type ==nil) {
     UIImageView *verified_type = [[UIImageView alloc]init];
        [self addSubview:verified_type];
        _verified_type =verified_type;
    }
    return _verified_type;
}
-(void)setUser:(UserModel *)user{
    
    _user =user;
    [self sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
    
    // 2.设置加V图片
    switch (user.verified_type) {
        case HWUserVerifiedPersonal: // 个人认证
            self.verified_type.hidden = NO;
            self.verified_type.image = [UIImage imageNamed:@"avatar_vip"];
            break;
            
        case HWUserVerifiedOrgEnterprice:
        case HWUserVerifiedOrgMedia:
        case HWUserVerifiedOrgWebsite: // 官方认证
            self.verified_type.hidden = NO;
            self.verified_type.image = [UIImage imageNamed:@"avatar_enterprise_vip"];
            break;
            
        case HWUserVerifiedDaren: // 微博达人
            self.verified_type.hidden = NO;
            self.verified_type.image = [UIImage imageNamed:@"avatar_grassroot"];
            break;
            
        default:
            self.verified_type.hidden = YES; // 当做没有任何认证
            break;
    }


}
-(void)layoutSubviews{
    
    self.verified_type.size = self.verified_type.image.size;
    double scale = 0.6;
    
    self.verified_type.x = self.width - self.verified_type.size.width*scale;
    self.verified_type.y = self.height - self.verified_type.size.height*scale;
}
@end
