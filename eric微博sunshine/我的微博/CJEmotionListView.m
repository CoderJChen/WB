//
//  CJEmotionListView.m
//  eric微博mysun
//
//  Created by 陈杰 on 16/1/26.
//  Copyright © 2016年 Eric. All rights reserved.
//

#import "CJEmotionListView.h"
#import "CJEmotionPageView.h"

@interface CJEmotionListView ()<UIScrollViewDelegate>
@property(strong,nonatomic)UIScrollView *scrollView;
@property(strong,nonatomic)UIPageControl *pageControl;

@end

@implementation CJEmotionListView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //滚动视图
        UIScrollView *scrollView = [[UIScrollView alloc]init];
        scrollView.pagingEnabled = YES;
        scrollView.delegate =self;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.bounces = NO;
        [self addSubview:scrollView];
        self.scrollView =scrollView;
//        翻页视图
        UIPageControl *pageControl = [[UIPageControl alloc]init];
        pageControl.userInteractionEnabled = NO;
        
        pageControl.pageIndicatorTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"compose_keyboard_dot_normal"]];
        
        pageControl.currentPageIndicatorTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"compose_keyboard_dot_selected"]];
        
//        [pageControl setValue:@"compose_keyboard_dot_normal" forKeyPath:@"pageImage"];
//        [pageControl setValue:@"compose_keyboard_dot_selected" forKeyPath:@"currentPageImage"];
        
        [self addSubview:pageControl];
        self.pageControl =pageControl;
    }
    return self;
}
- (void)setEmotions:(NSArray *)emotions{
    _emotions = emotions;
    NSInteger count = (emotions.count +KEmotionPageNumber-1)/KEmotionPageNumber;
    
    self.pageControl.numberOfPages = count;
    
    for (int i = 0; i<self.pageControl.numberOfPages; i++) {
        
        CJEmotionPageView *pageView = [[CJEmotionPageView alloc]init];
        
        NSRange range;
        range.location = i * KEmotionPageNumber;
        NSUInteger left = emotions.count - range.location;
        if (left > KEmotionPageNumber) {
            range.length = KEmotionPageNumber;
        }else{
            range.length = left;
        }
        pageView.emotions = [emotions subarrayWithRange:range];
        
       // pageView.backgroundColor = KRandomColor;
        [self.scrollView addSubview:pageView];
    }
    
    
}
- (void)layoutSubviews{
    [super layoutSubviews];
    
   // NSLog(@"scrollView---%@",self.scrollView.subviews);
    
    self.pageControl.width = self.width;
    self.pageControl.height = 35;
    self.pageControl.x = 0;
    self.pageControl.y = self.height - self.pageControl.height;
    
    self.scrollView.x = self.scrollView.y = 0;
    self.scrollView.width = self.width;
    self.scrollView.height = self.pageControl.y;
    
    for (int i =0; i<self.scrollView.subviews.count; i++) {
        CJEmotionPageView *pageView = self.scrollView.subviews[i];
        pageView.width = self.scrollView.width;
        pageView.height =self.scrollView.height;
        pageView.x = i*pageView.width;
        pageView.y = 0;
    }
    
    self.scrollView.contentSize = CGSizeMake(self.scrollView.subviews.count*self.scrollView.width, 0);
}
#pragma mark -UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    self.pageControl.currentPage = scrollView.contentOffset.x/scrollView.width +0.5;
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
