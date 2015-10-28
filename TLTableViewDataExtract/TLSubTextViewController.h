//
//  TLSubTextViewController.h
//  TLTableViewDataExtractDemo
//
//  Created by libokun on 15/11/21.
//  Copyright © 2015年 lbk. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark - TLSubTextVCDelegate
@class TLSubTextViewController;
@protocol TLSubTextVCDelegate <NSObject>
- (void) subTextViewController:(TLSubTextViewController *)subTextVC didEnterText:(NSString *)text;
@end


#pragma mark - TLSubTextViewController
@interface TLSubTextViewController : UIViewController

@property (nonatomic, assign) id<TLSubTextVCDelegate>delegate;

@property (nonatomic, strong) NSString *text;

/*
 * 用户自定义
 */
@property (nonatomic, strong) id userInfo;

@end
