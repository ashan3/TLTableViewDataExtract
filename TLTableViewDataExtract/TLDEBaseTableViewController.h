//
//  TLDEBaseTableViewController.h
//  TLTableViewDataExtractDemo
//
//  Created by libokun on 15/11/21.
//  Copyright © 2015年 lbk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLItem.h"

@interface TLDEBaseTableViewController : UITableViewController

/**
 *  表格数据源，由子类设置
 */
@property (nonatomic, strong) NSArray *data;

/**
 *  用户编辑后的结果字典，在加入用户信息后可直接发送给服务器
 */
@property (nonatomic, strong) NSMutableDictionary *dic;


/*
 *  用户点击完成按钮时触发，建议在子类中重写
 */
- (void) sendButtonDown;

@end
