//
//  TLDataPickerController.h
//  TLTableViewDataExtractDemo
//
//  Created by libokun on 15/11/21.
//  Copyright © 2015年 lbk. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 *  选择模式枚举
 */
typedef NS_ENUM(NSInteger, TLDataPickerMode) {
    TLDataPickerModeOne,        /* 单选模式 */
    TLDataPickerModeMore,       /* 多选模式 */
};


#pragma mark - TLDataPickerControllerDelegate
@class TLDataPickerController;
@protocol TLDataPickerControllerDelegate <NSObject>
@optional
/*
 *  选择完成（单选模式）
 */
- (void) dataPickerController:(TLDataPickerController *)dataPickerController didSelectItem:(id)item;

/*
 *  选择完成（多选模式）
 */
- (void) dataPickerController:(TLDataPickerController *)dataPickerController didSelectItems:(NSArray *)items;

/*
 *  选择取消（摸态视图时使用）
 */
- (void) dataPickerControllerCancelButtonDown:(TLDataPickerController *)dataPickerController;
@end


#pragma mark - TLDataPickerController
@interface TLDataPickerController : UITableViewController

@property (nonatomic, assign) id<TLDataPickerControllerDelegate>delegate;

/*
 *  选择模式
 */
@property (nonatomic, assign) TLDataPickerMode dataPickerMode;

/*
 *  数据源
 */
@property (nonatomic, strong) NSArray *data;

/*
 *  已选择的数据
 */
@property (nonatomic, strong) NSMutableArray *selectedArray;

/*
 *  用户自定义数据
 */
@property (nonatomic, strong) id userInfo;

@end
