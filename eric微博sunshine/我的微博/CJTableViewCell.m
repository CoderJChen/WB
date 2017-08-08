//
//  CJTableViewCell.m
//  eric微博mysun
//
//  Created by 陈杰 on 16/1/16.
//  Copyright © 2016年 Eric. All rights reserved.
//

#import "CJTableViewCell.h"
#import "StatusFrameModel.h"
#import "UIImageView+WebCache.h"
#import "UserModel.h"
#import "StatusModel.h"
#import "CJPhotoModel.h"
#import "CJStatusToolBar.h"
#import "CJStatusPhotosView.h"
#import "CJIconView.h"
@interface CJTableViewCell ()

/* 原创微博 */
/** 原创微博整体 */
@property (nonatomic, weak) UIView *originalView;
/** 头像 */
@property (nonatomic, weak) CJIconView *iconView;
/** 会员图标 */
@property (nonatomic, weak) UIImageView *vipView;
/** 配图 */
@property (nonatomic, weak) CJStatusPhotosView *photoView;
/** 昵称 */
@property (nonatomic, weak) UILabel *nameLabel;
/** 时间 */
@property (nonatomic, weak) UILabel *timeLabel;
/** 来源 */
@property (nonatomic, weak) UILabel *sourceLabel;
/** 正文 */
@property (nonatomic, weak) UILabel *contentLabel;

/* 转发微博 */
/** 转发微博整体 */
@property (nonatomic, weak) UIView *retweetView;
/** 转发微博正文 + 昵称 */
@property (nonatomic, weak) UILabel *retweetContentLabel;
/** 转发配图 */
@property (nonatomic, weak) CJStatusPhotosView *retweetPhotoView;

/**工具条*/
@property(strong,nonatomic) CJStatusToolBar *toolStatusView;

@end

@implementation CJTableViewCell
+(instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *cellIdentifer = @"cell";
    CJTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellIdentifer];
    if (cell==nil) {
        
        cell = [[CJTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifer];
    }
    return cell;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        //创建原始微博
        [self setUpOriginalView];
//        创建转发微博
        [self setUpRetweetView];
        
        [self setUpToolStatusBtn];
    }
    return self;
}

- (void)setUpToolStatusBtn{
    
    CJStatusToolBar * toolBar = [CJStatusToolBar StatusToolBar];
    [self.contentView addSubview:toolBar];
    
    self.toolStatusView = toolBar;
}
- (void)setUpRetweetView{
    
    UIView *retweetView = [[UIView alloc]init];
    retweetView.backgroundColor = Kcolor(247, 247, 247,1.0);
    [self.contentView addSubview:retweetView];
    self.retweetView =retweetView;
    
    UILabel *retweetContentLabel = [[UILabel alloc]init];
    retweetContentLabel.numberOfLines =0;
    retweetContentLabel.font = KRetweetStatusContentFont;
    [retweetView addSubview:retweetContentLabel];
    
    self.retweetContentLabel = retweetContentLabel;
    
    CJStatusPhotosView *retweetPhoto = [[CJStatusPhotosView alloc]init];
    [retweetView addSubview:retweetPhoto];
    self.retweetPhotoView = retweetPhoto;
    
}

- (void)setUpOriginalView{
//   原始微博
    UIView *originalView = [[UIView alloc]init];
    originalView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:originalView];
    self.originalView =originalView;
//   用户头像
    CJIconView *iconView =[[CJIconView alloc]init];
    [originalView addSubview:iconView];
    self.iconView = iconView;
//    昵称
    UILabel *nameLabel =[[UILabel alloc]init];
    nameLabel.font = KStatusNameFont;
    [originalView addSubview:nameLabel];
    self.nameLabel =nameLabel;
//   vip图标
    UIImageView *vipView =[[UIImageView alloc]init];
    vipView.contentMode = UIViewContentModeCenter;
    [originalView addSubview:vipView];
    self.vipView =vipView;
//    时间
    UILabel *timeLabel =[[UILabel alloc]init];
    timeLabel.font = KStatusTimeFont;
    timeLabel.textColor = [UIColor orangeColor];
    [originalView addSubview:timeLabel];
    self.timeLabel =timeLabel;
//    来源
    UILabel *sourceLabel =[[UILabel alloc]init];
    sourceLabel.font = KStatusSourceFont;
    [originalView addSubview:sourceLabel];
    self.sourceLabel =sourceLabel;
//    内容
    UILabel *contentLabel =[[UILabel alloc]init];
    contentLabel.font = KStatusContentFont;
    //contentLabel.backgroundColor = [UIColor blueColor];
    contentLabel.numberOfLines =0;
    [originalView addSubview:contentLabel];
    self.contentLabel =contentLabel;
//    配图
    CJStatusPhotosView *photoView = [[CJStatusPhotosView alloc]init];
    [originalView addSubview:photoView];
    self.photoView =photoView;

}
- (void)setStatusFrame:(StatusFrameModel *)statusFrame{
    
    _statusFrame =statusFrame;
    
    StatusModel * status = statusFrame.status;
    
    UserModel *user = status.user;
    
    self.originalView.frame = statusFrame.originalViewF;
        
    self.iconView.frame = statusFrame.iconViewF;
    self.iconView.user = user;
    
    self.nameLabel.frame = statusFrame.nameLabelF;
    self.nameLabel.text =user.name;
    
   
    if (user.isVip) {
        self.vipView.hidden =NO;
        self.vipView.frame = statusFrame.vipViewF;
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"common_icon_membership_level%d",user.mbrank]];
        self.vipView.image =image;
        self.nameLabel.textColor = [UIColor orangeColor];
    }else{
        self.nameLabel.textColor = [UIColor blackColor];
        self.vipView.hidden = YES;
    }
//    时间
    CGFloat timeX = self.nameLabel.origin.x;
    CGFloat timeY = CGRectGetMaxY(statusFrame.nameLabelF)+padding;
    CGSize  timeSize = [status.created_at sizeWithFont:KStatusTimeFont];
    
    self.timeLabel.frame = (CGRect){{timeX,timeY},timeSize};
    self.timeLabel.text = status.created_at;
    
//    来源
    CGFloat sourceX = CGRectGetMaxX(self.timeLabel.frame)+padding;
    CGFloat sourceY = timeY;
    CGSize sourceSize =[status.source sizeWithFont:KStatusSourceFont];
    
    self.sourceLabel.frame = (CGRect){{sourceX,sourceY},sourceSize};
    self.sourceLabel.text = status.source;
    
//    内容
    self.contentLabel.frame =statusFrame.contentLabelF;
    self.contentLabel.text = status.text;
//是否有配图
    if (status.pic_urls.count) {
        
        self.photoView.hidden =NO;
        self.photoView.frame = statusFrame.photoViewF;
        self.photoView.photos = status.pic_urls;
        
      //  CJPhotoModel *photo = [status.pic_urls firstObject];
        
    }else{
        self.photoView.hidden = YES;
    }
 /**转发微博*/
    if (status.retweeted_status) {
        
        self.retweetView.hidden =NO;
        StatusModel *retweet_status = status.retweeted_status;
        UserModel *retweet_user = retweet_status.user;
        
        self.retweetView.frame = statusFrame.retweetViewF;
        
        self.retweetContentLabel.frame = statusFrame.retweetContentLabelF;
        NSString *content = [NSString stringWithFormat: @"%@:%@",retweet_user.name,retweet_status.text];
        self.retweetContentLabel.text = content;
        
        if (retweet_status.pic_urls.count) {
            self.retweetPhotoView.frame = statusFrame.retweetPhotoViewF;
//            CJPhotoModel *photoModel = [retweet_status.pic_urls firstObject];
//            UIImage *image = [UIImage imageNamed:@"timeline_image_placeholder"];
//            NSURL *url = [NSURL URLWithString:photoModel.thumbnail_pic];
//            [self.retweetPhotoView sd_setImageWithURL:url placeholderImage:image];
            self.retweetPhotoView.photos = retweet_status.pic_urls;
            self.retweetPhotoView.hidden = NO;
        }else{
            self.retweetPhotoView.hidden =YES;
        }
    }else{
        self.retweetView.hidden = YES;
    }
    self.toolStatusView.frame = statusFrame.toolStatusViewF;
    self.toolStatusView.statuses =status;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
