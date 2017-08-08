//
//  CJTableViewCell.h
//  eric微博mysun
//
//  Created by 陈杰 on 16/1/16.
//  Copyright © 2016年 Eric. All rights reserved.
//

#import <UIKit/UIKit.h>
@class StatusFrameModel;
@interface CJTableViewCell : UITableViewCell

+(instancetype)cellWithTableView:(UITableView *) tableView;

@property(strong,nonatomic)StatusFrameModel  * statusFrame;
@end
