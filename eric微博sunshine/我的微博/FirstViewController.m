//
//  FirstViewController.m
//  我的微博
//
//  Created by 陈杰 on 16/1/3.
//  Copyright © 2016年 Eric. All rights reserved.
//

#import "FirstViewController.h"
#import "UIView+Extension.h"
#import "UIBarButtonItem+Extension.h"
#import "CJMenuDownView.h"
#import "CJTitleTableViewController.h"
#import "AFNetworking.h"
#import "CJAccountTool.h"
#import "CJTitleButton.h"
#import "StatusModel.h"
#import "UserModel.h"
#import "UIImageView+WebCache.h"
#import "MJExtension.h"
#import "CJFooterView.h"
#import "CJTableViewCell.h"
#import "StatusFrameModel.h"
@interface FirstViewController ()<CJMenuDownViewDelegate>
@property(strong,nonatomic) NSMutableArray *statesFrame;
@end

@implementation FirstViewController
- (NSMutableArray *)statesFrame{
    
    if (_statesFrame ==nil) {
        _statesFrame =[NSMutableArray arrayWithCapacity:10];
    }
    return _statesFrame;
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.tableView.backgroundColor = Kcolor(211, 211, 211, 1.0);
    //设置导航栏
    [self setUpNavigationController];
    //获得用户信息
    [self setUpUserInfo];
    //上拉刷新
    [self setUpRefreshing];
    //下拉刷新
    [self setUpDownRefreshing];
    
//    NSTimer *timer =[NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(setupUnreadCount) userInfo:nil repeats:YES];
//    //主线程运行，也会进行计数
//    [[NSRunLoop mainRunLoop]addTimer:timer forMode:NSRunLoopCommonModes];
}
- (void)setupUnreadCount{
    
    NSLog(@"setupUnreadCount");
    AFHTTPRequestOperationManager *mannager =[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *dict =[NSMutableDictionary dictionary];
    Acount *account = [CJAccountTool account];
    
    dict[@"access_token"]=account.access_token;
    dict[@"uid"] =account.uid;

    [mannager GET:@"https://rm.api.weibo.com/2/remind/unread_count.json" parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
       // NSLog(@"%@",responseObject);
        NSString *string = [responseObject[@"status"] description];
        
        UIUserNotificationType type =  UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound;
        
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:type categories:nil];
        
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];

        if ([string isEqualToString:@"0"]) {
            self.tabBarItem.badgeValue =nil;
            [UIApplication sharedApplication].applicationIconBadgeNumber =0;
        }else{
            self.tabBarItem.badgeValue = string;
            [UIApplication sharedApplication].applicationIconBadgeNumber =string.intValue ;
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error.localizedDescription);
    }];
    

    
}

- (void)setUpRefreshing{
    
    CJFooterView *footer =[CJFooterView footerView];
    footer.hidden =YES;
    self.tableView.tableFooterView =footer;

}
- (void)setUpDownRefreshing{
    
    self.tabBarItem.badgeValue =nil;
    [UIApplication sharedApplication].applicationIconBadgeNumber =0;
    
    UIRefreshControl *refresh = [[UIRefreshControl alloc]init];
    
    [refresh addTarget:self action:@selector(refreshClick:) forControlEvents:UIControlEventValueChanged];
    
    [self.tableView addSubview:refresh];
    
    [refresh beginRefreshing];
    //自动刷新数据
    [self refreshClick:refresh];
    
}
/**数组status 转换到statusFrame*/
- (NSArray *)statusFramesWithStatus:(NSArray *)statuses{
    
    NSMutableArray *frames =[NSMutableArray array];
    
    for (StatusModel *status in statuses) {
        StatusFrameModel *frameModel = [[StatusFrameModel alloc]init];
        frameModel.status =status;
        [frames addObject:frameModel];
    }
    
    return frames;
}
- (void)refreshClick:(UIRefreshControl *)control{
    
    AFHTTPRequestOperationManager *mannager =[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *dict =[NSMutableDictionary dictionary];
    
    Acount *account = [CJAccountTool account];
    
    dict[@"access_token"]=account.access_token;
    //取得最前面的微博
    StatusFrameModel *firstStatus =[self.statesFrame firstObject];
    //若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0
    if (firstStatus) {
        
        dict[@"since_id"] = firstStatus.status.idstr;
    }
    
    [mannager GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSArray *arr = responseObject[@"statuses"];
        //最新的微博数据
        NSArray *newStatus = [StatusModel objectArrayWithKeyValuesArray:arr];
        
        NSArray *fm = [self statusFramesWithStatus:newStatus];
        //[self.states addObjectsFromArray:newStatus];
        //将最新的微博数据存到数组中
        NSRange range = NSMakeRange(0, fm.count);
        
        NSIndexSet *set =[NSIndexSet indexSetWithIndexesInRange:range];
        
        [self.statesFrame insertObjects:fm atIndexes:set];
        
        [self.tableView reloadData];
        
        [control endRefreshing];
        
        [self showNewstatusCount:newStatus.count];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"%@",error.localizedDescription);
        
        [control endRefreshing];
        
    }];

}
- (void)showNewstatusCount:(NSInteger)count{

    UILabel *label =[[UILabel alloc]init];
    label.width = KScreenWidth;
    label.height =35;
     label.y =64 -label.height;
    label.textAlignment = NSTextAlignmentCenter;
    label.font=[UIFont systemFontOfSize:16.0];
    label.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_new_status_background"]];
    
    
    if (count==0) {
        label.text =@"没有新的微博数据,请稍后.....";
    }else{
        label.text = [NSString stringWithFormat:@"共有%lu个新的微博数据",count];
    }
    
//    [self.navigationController.view addSubview:label];
    [self.navigationController.view insertSubview:label belowSubview:self.navigationController.navigationBar];
    [UIView animateWithDuration:1.0 animations:^{
        
        label.transform = CGAffineTransformMakeTranslation(0, label.height);
        
    } completion:^(BOOL finished) {
    //// 延迟1s后，再利用1s的时间，让label往上移动一段距离（回到一开始的状态）
     [UIView animateWithDuration:1.0 delay:1.0 options:UIViewAnimationOptionCurveLinear animations:^{
        //动画返回到起始位置
         label.transform = CGAffineTransformIdentity;
         
     } completion:^(BOOL finished) {
         //移除label
         [label removeFromSuperview];
         
     }];
    }];
    
}
- (void)setUpUserInfo{
    
    /*https://api.weibo.com/2/users/show.json
     "access_token" = "2.00vgscUDl7qIiB6f19d2d7f90vFhqK";
     "expires_in" = 157679999;
     "remind_in" = 157679999;
     uid = 3200955277;
     */
    
    AFHTTPRequestOperationManager *request =[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    Acount *account =[CJAccountTool  account];
    dict[@"access_token"] = account.access_token;
    dict[@"uid"] = account.uid;

    [request GET:@"https://api.weibo.com/2/users/show.json" parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        UIButton *titleBtn =(UIButton *)self.navigationItem.titleView;
        
        [titleBtn setTitle:responseObject[@"name"] forState:UIControlStateNormal];
        
        account.name = responseObject[@"name"];
        
        [CJAccountTool saveAccount:account];
        //NSLog(@"%@",responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"%@",error.localizedDescription);
        
    }];
    

}
- (void)setUpNavigationController{
    
    //设置导航栏
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem addItemWithTarget:self action:@selector(friendsearch) image:@"navigationbar_friendsearch" selectImage:@"navigationbar_friendsearch_highlighted"];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem addItemWithTarget:self action:@selector(pop) image:@"navigationbar_pop" selectImage:@"navigationbar_pop_highlighted"];
    
    //自定义button
    CJTitleButton *btn = [[CJTitleButton alloc]init];
    
    NSString *name = [CJAccountTool account].name;
    
    [btn setTitle:name?name:@"首页" forState:UIControlStateNormal];
    
    [btn addTarget:self action:@selector(titleBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.titleView = btn;

}

- (void)loadNewMoreStates{
    
    //https://api.weibo.com/2/statuses/friends_timeline.json
    
    AFHTTPRequestOperationManager *mannager =[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *dict =[NSMutableDictionary dictionary];
    Acount *account = [CJAccountTool account];
    
    dict[@"access_token"]=account.access_token;
    StatusFrameModel *lastStatus = [self.statesFrame lastObject];
    
    //max_id	false	int64	若指定此参数，则返回ID小于或等于max_id的微博，默认为0。
    if (lastStatus) {
        // 若指定此参数，则返回ID小于或等于max_id的微博，默认为0。
        // id这种数据一般都是比较大的，一般转成整数的话，最好是long long类型
        long long maxId = lastStatus.status.idstr.longLongValue - 1;
        dict[@"max_id"] = @(maxId);
    }

    [mannager GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSArray *arr = responseObject[@"statuses"];
        
       NSArray *status = [StatusModel objectArrayWithKeyValuesArray:arr];
        
        // 将 HWStatus数组 转为 HWStatusFrame数组
        NSArray *newFrames = [self statusFramesWithStatus:status];
        
        [self.statesFrame addObjectsFromArray:newFrames];
        
      [self.tableView reloadData];
        self.tableView.tableFooterView.hidden =YES;
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        self.tableView.tableFooterView.hidden =YES;
        NSLog(@"%@",error.localizedDescription);
    }];
    
}
- (void)titleBtn:(UIButton *)button{
    
    CJMenuDownView *menu =[CJMenuDownView menu];
    
    menu.delegate =self;
    CJTitleTableViewController *titleViewController =[[CJTitleTableViewController alloc]init];
    
    titleViewController.view.width =150;
    titleViewController.view.height = 150;
    
    menu.contentView = titleViewController;
    
    [menu showFrom:button];
    
}
#pragma mark  -CJMenuDownViewDelegate
- (void)menuDidClickDown:(CJMenuDownView *)down{
    UIButton  *btn  = (UIButton *)self.navigationItem.titleView;
    btn.selected =YES;
}
- (void)menuDidClickUp:(CJMenuDownView *)up{
    UIButton  *btn  = (UIButton *)self.navigationItem.titleView;
    btn.selected =NO;
}

- (void)friendsearch{
    NSLog(@"friends");
}

- (void)pop{
    NSLog(@"pop");
}

#pragma mark -UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //scrollView.contentOffset.y == scrollView.contentSize.height - scrollView.frame.size.height
    if (self.statesFrame.count==0||self.tableView.tableFooterView.hidden==NO) {
        return;
    }
    CGFloat offset = self.tableView.contentOffset.y;
    
    CGFloat botton = self.tableView.contentSize.height+self.tableView.contentInset.bottom - self.tableView.frame.size.height - self.tableView.tableFooterView.height;
    if (offset>botton) {
        
        self.tableView.tableFooterView.hidden =NO;
        [self loadNewMoreStates];
        
    }else{
        self.tableView.tableFooterView.hidden =YES;
    }

}

#pragma mark -UITableViewDataSource,UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.statesFrame.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CJTableViewCell *cell =[CJTableViewCell cellWithTableView:tableView];
    
    cell.statusFrame = self.statesFrame[indexPath.row];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    StatusFrameModel *frame = self.statesFrame[indexPath.row];
    
    return frame.cellH;
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
