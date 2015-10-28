//
//  TLSubTextViewController.m
//  TLTableViewDataExtractDemo
//
//  Created by libokun on 15/11/21.
//  Copyright © 2015年 lbk. All rights reserved.
//

#import "TLSubTextViewController.h"
#import "TLConstant.h"

#define         HEIGHT_BG_VIEW              220
#define         TEXTVIEW_PLACE_HOLDER       @"请输入..."

@interface TLSubTextViewController () <UITextViewDelegate>

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UIBarButtonItem *finishedButton;

@end

@implementation TLSubTextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:COLOR_BACKGROUND];
    [self.view addSubview:self.bgView];
    [self.bgView addSubview:self.textView];
    
    [self.navigationItem setRightBarButtonItem:self.finishedButton];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.bgView setFrame:CGRectMake(0, HEIGHT_NAVBAR + HEIGHT_STATUSBAR + 10, WIDTH_SCREEN, HEIGHT_BG_VIEW)];
    [self.textView setFrame:CGRectMake(10, 10, WIDTH_SCREEN - 20, HEIGHT_BG_VIEW - 20)];
}

- (void) setText:(NSString *)text
{
    _text = text;
    if (text && text.length > 0) {
        [self.textView setText:text];
        [self.textView setTextColor:[UIColor blackColor]];
    }
}

#pragma mark - UITextViewDelegate
- (void) textViewDidBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:TEXTVIEW_PLACE_HOLDER]) {
        [textView setText:@""];
        [textView setTextColor:[UIColor blackColor]];
    }
}

#pragma mark - Event Response
- (void) finishedButtonDown:(UIBarButtonItem *)sender
{
    if (_delegate && [_delegate respondsToSelector:@selector(subTextViewController:didEnterText:)]) {
        NSString *text = [self.textView.text isEqualToString:TEXTVIEW_PLACE_HOLDER] ? @"" : self.textView.text;
        [_delegate subTextViewController:self didEnterText:text];
    }
}

#pragma mark - Getter
- (UIView *) bgView
{
    if (_bgView == nil) {
        _bgView = [[UIView alloc] init];
        [_bgView setBackgroundColor:[UIColor whiteColor]];
    }
    return _bgView;
}

- (UITextView *) textView
{
    if (_textView == nil) {
        _textView = [[UITextView alloc] init];
        [_textView setFont:[UIFont systemFontOfSize:15.0f]];
        [_textView setDelegate:self];
        [_textView setText:TEXTVIEW_PLACE_HOLDER];
        [_textView setTextColor:[UIColor grayColor]];
    }
    return _textView;
}

- (UIBarButtonItem *) finishedButton
{
    if (_finishedButton == nil) {
        _finishedButton = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(finishedButtonDown:)];
    }
    return _finishedButton;
}

@end
