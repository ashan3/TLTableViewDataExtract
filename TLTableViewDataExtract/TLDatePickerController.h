//
//  TLDatePickerController.h
//  TLTableViewDataExtractDemo
//
//  Created by libokun on 15/11/21.
//  Copyright © 2015年 lbk. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark - TLDatePickerController
@class TLDatePickerController;
@protocol TLDatePickerControllerDelegate <NSObject>
- (void) datePickerViewController:(TLDatePickerController *)datePickerViewController didSelectedDate:(id)date;
@end


#pragma mark - TLDatePickerController
@interface TLDatePickerController : UIViewController

@property (nonatomic, assign) id<TLDatePickerControllerDelegate>delegate;

/*
 *  说明
 */
@property (nonatomic, strong) NSString *introductionText;

/*
 *  用户自定义
 */
@property (nonatomic, strong) id userInfo;

/*
 *  类型（日期、时间、日期和时间）
 */
- (void) setDatePickerMode:(UIDatePickerMode)datePickerMode;

@end
