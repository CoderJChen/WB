//
//  StatusFrameModel.m
//  eric微博mysun
//
//  Created by 陈杰 on 16/1/16.
//  Copyright © 2016年 Eric. All rights reserved.
//

#import "StatusFrameModel.h"
#import "StatusModel.h"
#import "UserModel.h"
#import "CJStatusPhotosView.h"
#define KStatusPhotoWidth  35

@implementation StatusFrameModel

//text自适应

- (void)setStatus:(StatusModel *)status{
    _status =status;
    
    UserModel *user = status.user;
    
    CGFloat maxW = [UIScreen mainScreen].bounds.size.width - 2*padding;
   //用户头像
    CGFloat  iconX = padding;
    CGFloat iconY = padding;
    CGFloat iconW = KStatusCellIconW;
    self.iconViewF =CGRectMake(iconX, iconY, iconW, iconW);
//    昵称
    CGFloat nameX = CGRectGetMaxX(self.iconViewF) + padding;
    CGFloat nameY = iconY;
    
    CGSize nameSize = [user.name sizeWithFont:KStatusNameFont];
    
    self.nameLabelF = (CGRect){{nameX,nameY},nameSize};
    
    //判断是否是vip会员
    if (user.isVip) {
        CGFloat vipX = CGRectGetMaxX(self.nameLabelF)+padding;
        CGFloat vipY = iconY;
        CGFloat vipW = KStatusVipW;
        CGFloat vipH = KStatusVipW;
        self.vipViewF = CGRectMake(vipX, vipY, vipW, vipH);
    }
    CGFloat timeX = nameX;
    CGFloat timeY = CGRectGetMaxY(self.nameLabelF)+padding;
    CGSize  timeSize = [status.created_at sizeWithFont:KStatusTimeFont];
    
    self.timeLabelF = (CGRect){{timeX,timeY},timeSize};
    
    CGFloat sourceX = CGRectGetMaxX(self.timeLabelF)+padding;
    CGFloat sourceY = timeY;
    CGSize sourceSize =[status.text sizeWithFont:KStatusSourceFont];
    self.sourceLabelF = (CGRect){{sourceX,sourceY},sourceSize};
    
//    内容
    CGFloat contentX = iconX;
    CGFloat contentY = MAX(CGRectGetMaxY(self.iconViewF),CGRectGetMaxY(self.timeLabelF))+padding;

    CGSize  contentSize = [status.text sizeWithFont:KStatusContentFont maxW:maxW];
    self.contentLabelF = (CGRect){{contentX,contentY},contentSize};
    
    CGFloat originalH = 0;
    if (status.pic_urls.count) {
        CGFloat photoX = contentX;
        CGFloat photoY = CGRectGetMaxY(self.contentLabelF)+padding;
//        CGFloat photoW = KStatusPhotoWidth;
//        self.photoViewF =CGRectMake(photoX, photoY, photoW, photoW);
     CGSize photoSize = [CJStatusPhotosView sizeWithcount:status.pic_urls.count];
        
        self.photoViewF = (CGRect){{photoX,photoY},photoSize};

        originalH = CGRectGetMaxY(self.photoViewF)+padding;
        
    }else{
        originalH = CGRectGetMaxY(self.contentLabelF)+padding;
        //NSLog(@"------%f",originalH);
    }
//  原始微博
    CGFloat originalX = 0;
    CGFloat originalY = padding;
    CGFloat originalW = KCellWidth;
    //CGFloat originalH = CGRectGetMaxY(self.contentLabelF);
    
    self.originalViewF = CGRectMake(originalX, originalY, originalW, originalH);
    //NSLog(@"originalViewF---%@",NSStringFromCGRect(self.originalViewF));
    
    CGFloat toolBarX = 0;
    CGFloat toolBarW = KCellWidth;
    CGFloat toolBarH = 35;
    //转发微博
    if (status.retweeted_status) {
        StatusModel *retweet_status = status.retweeted_status;
        UserModel *retweet_user = retweet_status.user;
        NSString *content =[NSString stringWithFormat:@"%@:%@",retweet_user.name,retweet_status.text];
//       转发微博内容
        CGFloat retweetContentX = padding;
        CGFloat retweetContentY = padding;
        CGSize retweetContentSize = [content sizeWithFont:KRetweetStatusContentFont maxW:maxW];
        self.retweetContentLabelF = (CGRect){{retweetContentX,retweetContentY},retweetContentSize};
        
        CGFloat retweetViewH =0;
        if (retweet_status.pic_urls.count) {//是否有配图
            CGFloat retweetPhotoX = retweetContentX;
            CGFloat retweetPhotoY = CGRectGetMaxY(self.retweetContentLabelF)+padding;
//            CGFloat retweetPhotoW = KRetweetStatusPhotoW;
//            self.retweetPhotoViewF = CGRectMake(retweetPhotoX, retweetPhotoY, retweetPhotoW, retweetPhotoW);
            CGSize retweetPhotoSize = [CJStatusPhotosView sizeWithcount:retweet_status.pic_urls.count];
            self.retweetPhotoViewF = (CGRect){{retweetPhotoX,retweetPhotoY},retweetPhotoSize};
            
            retweetViewH = CGRectGetMaxY(self.retweetPhotoViewF)+padding;

        }else{
        
            retweetViewH =CGRectGetMaxY(self.retweetContentLabelF)+padding;
        }
        CGFloat retweetViewX = 0;
        CGFloat retweetViewY = CGRectGetMaxY(self.originalViewF);
        CGFloat retweetViewW = KCellWidth;
        self.retweetViewF = CGRectMake(retweetViewX, retweetViewY, retweetViewW, retweetViewH);
        
        CGFloat toolBarY = CGRectGetMaxY(self.retweetViewF) ;
        self.toolStatusViewF = CGRectMake(toolBarX, toolBarY, toolBarW, toolBarH);

        self.cellH = CGRectGetMaxY(self.toolStatusViewF);
    }else{
        CGFloat toolBarY = CGRectGetMaxY(self.originalViewF);
        
     self.toolStatusViewF = CGRectMake(toolBarX, toolBarY, toolBarW, toolBarH);
//   cell的高度
    self.cellH =CGRectGetMaxY(self.toolStatusViewF);
        
    }
    
}
@end
