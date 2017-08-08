//
//  CJCompseTool.h
//  eric微博mysun
//
//  Created by 陈杰 on 16/1/21.
//  Copyright © 2016年 Eric. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CJCompseTool;

typedef enum {
    
    CJComposeToolbarButtonTypeCamera, // 拍照
    CJComposeToolbarButtonTypePicture, // 相册
    CJComposeToolbarButtonTypeMention, // @
    CJComposeToolbarButtonTypeTrend, // #
    CJComposeToolbarButtonTypeEmotion // 表情
    
    } CJComposeToolbarButtonType;

@protocol CJCompseToolDelegate <NSObject>

- (void)composeTool:(CJCompseTool *)composeTool buttonType:(CJComposeToolbarButtonType)buttonType;

@end
@interface CJCompseTool : UIView

@property(assign,nonatomic) CJComposeToolbarButtonType btnType;
@property(strong,nonatomic) id <CJCompseToolDelegate> delegate;
@property(assign,nonatomic)BOOL showKeyboardBtn;
@end
