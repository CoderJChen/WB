//
//  StartViewController.m
//  我的微博
//
//  Created by 陈杰 on 16/1/7.
//  Copyright © 2016年 Eric. All rights reserved.
//

#import "StartViewController.h"
#import "RootViewController.h"
#import "UIView+Extension.h"
#define KImageCount 4
@interface StartViewController ()<UIScrollViewDelegate>
@property(strong,nonatomic)UIPageControl *pageControl;
@end

@implementation StartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIScrollView *scrollView =[[ UIScrollView alloc]init];
    scrollView.frame = self.view.bounds;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.bounces = NO;
    scrollView.pagingEnabled = YES;
    scrollView.contentSize = CGSizeMake(KImageCount*scrollView.frame.size.width, 0);
    scrollView.delegate =self;
    [self.view addSubview:scrollView];
    
    CGFloat KImageWidth = scrollView.frame.size.width;
    CGFloat kImageHeight = scrollView.frame.size.height;
    for (int i =0; i<KImageCount; i++) {
        
        UIImageView *imageView =[[UIImageView alloc]initWithFrame:CGRectMake(i*KImageWidth, 0, KImageWidth, kImageHeight)];
        
        UIImage *image =[UIImage imageNamed:[NSString stringWithFormat:@"new_feature_%d",i+1]];
        imageView.image = image;
        
        [scrollView addSubview:imageView];
        
        if (i==KImageCount-1) {
            
            [self setButtnClickAndImageView:imageView];
            
        }
    }
    
    UIPageControl *pageControl = [[UIPageControl alloc]init];
    pageControl.centerX =self.view.frame.size.width*0.5;
    pageControl.y = self.view.frame.size.height*9/10;
    pageControl.numberOfPages = KImageCount;
    pageControl.pageIndicatorTintColor = [UIColor grayColor];
    pageControl.currentPageIndicatorTintColor =[UIColor redColor];
    [self.view addSubview:pageControl];
    self.pageControl = pageControl;
    
    // Do any additional setup after loading the view.
}
- (void)setButtnClickAndImageView:(UIImageView *)imageView{
    
    imageView.userInteractionEnabled = YES;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
    [btn setTitle:@"分享给大家" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //内切
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    
    [btn addTarget:self action:@selector(shareBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    btn.width = 200;
    btn.height =50;
    btn.centerX = imageView.width*0.5;
    btn.centerY = imageView.height*0.65;
    
    [imageView addSubview:btn];
    
    UIButton *startBtn =[UIButton  buttonWithType:UIButtonTypeCustom];
    [startBtn setTitle:@"开始微博" forState:UIControlStateNormal];
    [startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
    [startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
    [startBtn addTarget:self action:@selector(startBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    startBtn.width = 150;
    startBtn.height =50;
    
    startBtn.centerX = imageView.width/2;
    
    startBtn.y = CGRectGetMaxY(btn.frame)+20;
    
    [imageView addSubview:startBtn];
    
}
- (void)shareBtnClick:(UIButton *)shareBtn{
    
    shareBtn.selected = !shareBtn.isSelected;
    
}
- (void)startBtnClick{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    window.rootViewController = [[RootViewController alloc]init];//跳转后新特征自动销毁
}
#pragma mark -UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    self.pageControl.currentPage = scrollView.contentOffset.x/scrollView.frame.size.width+0.5;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
