//
//  TLDatePickerController.m
//  TLTableViewDataExtractDemo
//
//  Created by libokun on 15/11/21.
//  Copyright © 2015年 lbk. All rights reserved.
//

#import "TLDatePickerController.h"
#import "TLConstant.h"

@interface TLDatePickerController ()

@property (nonatomic, strong) UILabel *introductionLabel;
@property (nonatomic, strong) UIDatePicker *datePicker;

@end

@implementation TLDatePickerController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:@"日期选择"];
    UIBarButtonItem *okButton = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(okButtonDown)];
    [self.navigationItem setRightBarButtonItem:okButton];
    
    [self.view setBackgroundColor:COLOR_BACKGROUND];
    [self.introductionLabel setFrame:CGRectMake(0, HEIGHT_NAVBAR + 30, WIDTH_SCREEN, 40)];
    [self.view addSubview:self.introductionLabel];
    [self.datePicker setFrame:CGRectMake(0, HEIGHT_NAVBAR + 65, WIDTH_SCREEN, 200)];
    [self.view addSubview:self.datePicker];
}

- (void) setDatePickerMode:(UIDatePickerMode)datePickerMode
{
    [self.datePicker setDatePickerMode:datePickerMode];
    if (datePickerMode == UIDatePickerModeDate) {
        [self.navigationItem setTitle:@"日期选择"];
    }
    else {
        [self.navigationItem setTitle:@"时间选择"];
    }
}

- (void) setIntroductionText:(NSString *)introductionText
{
    _introductionText = introductionText;
    [self.introductionLabel setText:[NSString stringWithFormat:@"    请选择%@:",introductionText]];
}

#pragma mark - Event Response
- (void) okButtonDown
{
    if (_delegate && [_delegate respondsToSelector:@selector(datePickerViewController:didSelectedDate:)]) {
        [_delegate datePickerViewController:self didSelectedDate:self.datePicker.date];
    }
}

#pragma mark - Getter
- (UIDatePicker *) datePicker
{
    if (_datePicker == nil) {
        _datePicker = [[UIDatePicker alloc] init];
        [_datePicker setBackgroundColor:[UIColor whiteColor]];
        [_datePicker setDatePickerMode:UIDatePickerModeDate];
    }
    return _datePicker;
}

- (UILabel *) introductionLabel
{
    if (_introductionLabel == nil) {
        _introductionLabel = [[UILabel alloc] init];
        [_introductionLabel setBackgroundColor:[UIColor whiteColor]];
        [_introductionLabel setFont:[UIFont systemFontOfSize:16.0f]];
        [_introductionLabel setTextColor:[UIColor blackColor]];
        [_introductionLabel setText:@"    请选择:"];
    }
    return _introductionLabel;
}

@end
