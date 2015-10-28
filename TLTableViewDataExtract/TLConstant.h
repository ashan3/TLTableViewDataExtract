//
//  TLConstant.h
//  TLTableViewDataExtractDemo
//
//  Created by libokun on 15/11/21.
//  Copyright © 2015年 lbk. All rights reserved.
//

#ifndef TLConstant_h
#define TLConstant_h

#pragma mark - Frame
#define     WIDTH_SCREEN        [UIScreen mainScreen].bounds.size.width
#define     HEIGHT_SCREEN       [UIScreen mainScreen].bounds.size.height
#define     HEIGHT_STATUSBAR        20
#define     HEIGHT_TABBAR           49
#define     HEIGHT_BOTTOM_VIEW      39
#define     HEIGHT_NAVBAR           44


#pragma mark - Color
#define     COLOR_BACKGROUND        [UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:246.0/255.0 alpha:1.0]
#define     COLOR_GRAY              [UIColor colorWithWhite:0.3 alpha:0.3]



#pragma mark - Path
#define     PATH_DOCUMENT                   [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]
// 图片缓存目录
#define     PATH_IMAGES                     [PATH_DOCUMENT stringByAppendingPathComponent:@"Images/"]

#endif /* TLConstant_h */
