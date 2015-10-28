//
//  UIView+WB.h
//  WhichBanker
//
//  Created by libokun on 15/9/22.
//  Copyright (c) 2015年 lettai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (WB)

@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGSize size;

@property (nonatomic, assign) CGFloat originX;
@property (nonatomic, assign) CGFloat originY;

@property (nonatomic, assign) CGFloat frameRight;
@property (nonatomic, assign) CGFloat frameBottom;

@property (nonatomic, assign) CGFloat frameWidth;
@property (nonatomic, assign) CGFloat frameHeight;

- (BOOL) containsSubView:(UIView *)subView;
- (BOOL) containsSubViewOfClassType:(Class)aClass;
- (UIImage *) imageRepresentation;
- (CGSize)sizeThatFitsMaxSize;

@end
