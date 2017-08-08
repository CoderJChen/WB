//
//  ThirdViewController.m
//  我的微博
//
//  Created by 陈杰 on 16/1/3.
//  Copyright © 2016年 Eric. All rights reserved.
//

#import "ThirdViewController.h"
#import "CJSearchBar.h"
#import "UIView+Extension.h"
@interface ThirdViewController ()

@end

@implementation ThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //定制的searchBar 用textField定制
    CJSearchBar *searchBar = [CJSearchBar searchBar];
    searchBar.width = 300;
    searchBar.height = 30;
    self.navigationItem.titleView =searchBar;
    // Do any additional setup after loading the view.
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
