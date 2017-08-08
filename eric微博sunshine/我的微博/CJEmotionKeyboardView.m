//
//  CJEmotionKeyboardView.m
//  eric微博mysun
//
//  Created by 陈杰 on 16/1/26.
//  Copyright © 2016年 Eric. All rights reserved.
//

#import "CJEmotionKeyboardView.h"
#import "CJEmotionTabBar.h"
#import "CJEmotionListView.h"
#import "CJEmotionModel.h"
#import "MJExtension.h"
#import "CJEmotionToolModel.h"
@interface CJEmotionKeyboardView ()<CJEmotionTabBarDelegate>
/** 保存正在显示listView */
@property (nonatomic, weak) CJEmotionListView *showingListView;
/** 表情内容 */
@property (nonatomic, strong) CJEmotionListView *recentListView;
@property (nonatomic, strong) CJEmotionListView *defaultListView;
@property (nonatomic, strong) CJEmotionListView *emojiListView;
@property (nonatomic, strong) CJEmotionListView *lxhListView;

@property(strong,nonatomic) CJEmotionTabBar *tabBar;
@end

@implementation CJEmotionKeyboardView
-(CJEmotionListView *)recentListView{
    if (_recentListView == nil) {
        self.recentListView = [[CJEmotionListView alloc]init];
        self.recentListView.emotions = [CJEmotionToolModel recentEmotion];
        //self.recentListView.backgroundColor = KRandomColor;
    }
    return _recentListView;
}
- (CJEmotionListView *)defaultListView{
    if (_defaultListView ==nil) {
        self.defaultListView = [[CJEmotionListView alloc]init];
       // self.defaultListView.backgroundColor = KRandomColor;
        NSString *path = [[NSBundle mainBundle]pathForResource:@"EmotionIcons/default/info.plist" ofType:nil];
        self.defaultListView.emotions = [CJEmotionModel objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path]];
    }
    return _defaultListView;
}
- (CJEmotionListView *)emojiListView{
    if (_emojiListView == nil) {
        self.emojiListView = [[CJEmotionListView alloc]init];
       // self.emojiListView.backgroundColor = KRandomColor;
        NSString *path = [[NSBundle mainBundle]pathForResource:@"EmotionIcons/emoji/info.plist" ofType:nil];
        self.emojiListView.emotions = [CJEmotionModel objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path]];
    }
    return _emojiListView;
}
- (CJEmotionListView *)lxhListView{
    if (_lxhListView==nil) {
        self.lxhListView = [[CJEmotionListView alloc]init];
        //self.lxhListView.backgroundColor = KRandomColor;
        NSString *path = [[NSBundle mainBundle]pathForResource:@"EmotionIcons/lxh/info.plist" ofType:nil];
        self.lxhListView.emotions = [CJEmotionModel objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path]];
    }
    return _lxhListView;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        CJEmotionTabBar *tabBar = [[CJEmotionTabBar alloc]init];
        tabBar.delegate =self;
        [self addSubview:tabBar];
        self.tabBar = tabBar;
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.tabBar.width =self.width;
    self.tabBar.height =37;
    self.tabBar.x = 0;
    self.tabBar.y = self.height - self.tabBar.height;
    
    self.showingListView.x = self.showingListView.y = 0;
    self.showingListView.width = self.width;
    self.showingListView.height = self.tabBar.y;
}
- (void)emotionBtn:(CJEmotionTabBar *)btn buttonType:(CJEmotionTabBarButtonType)btnType{
//    移除显示的视图
    [self.showingListView removeFromSuperview];
    
    switch (btnType) {
            
        case CJEmotionTabBarButtonTypeRecent:
        {
            [self addSubview:self.recentListView];
            break;
        }
        case CJEmotionTabBarButtonTypeDefault:
        {
            [self addSubview:self.defaultListView];
            break;
        }
        case CJEmotionTabBarButtonTypeEmoji:
        {
            [self addSubview:self.emojiListView];
            break;
        }
        case CJEmotionTabBarButtonTypeLxh:
        {
            [self addSubview:self.lxhListView];
            break;
        }
    }
//    设置正在显示的视图
    self.showingListView = [self.subviews lastObject];
//    重新布局
    [self setNeedsLayout];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
