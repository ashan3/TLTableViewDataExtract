//
//  TLTableViewCell.m
//  TLTableViewDataExtractDemo
//
//  Created by libokun on 15/11/21.
//  Copyright © 2015年 lbk. All rights reserved.
//

#import "TLTableViewCell.h"

@implementation TLTableViewCell


- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setBackgroundColor:[UIColor whiteColor]];
        _topLineStyle = CellLineStyleNone;
        _bottomLineStyle = CellLineStyleDefault;
        _leftFreeSpace = [UIScreen mainScreen].bounds.size.width * 0.043;
    }
    return self;
}

- (void) layoutSubviews
{
    [super layoutSubviews];
    CGRect rect = self.bottomLine.frame;
    rect.origin.y = self.frame.size.height - _bottomLine.frame.size.height;
    [self.bottomLine setFrame:rect];
    [self setBottomLineStyle:_bottomLineStyle];
    [self setTopLineStyle:_topLineStyle];
}

#pragma mark - 上下横线
- (void) setTopLineStyle:(CellLineStyle)style
{
    _topLineStyle = style;
    CGRect rect = self.topLine.frame;
    if (style == CellLineStyleDefault) {
        rect.origin.x =  _leftFreeSpace;
        rect.size.width = self.frame.size.width - _leftFreeSpace;
        [self.topLine setFrame:rect];
        [self.topLine setHidden:NO];
    }
    else if (style == CellLineStyleFill) {
        rect.origin.x =  0;
        rect.size.width = self.frame.size.width;
        [self.topLine setFrame:rect];
        [self.topLine setHidden:NO];
    }
    else if (style == CellLineStyleNone) {
        [self.topLine setHidden:YES];
    }
}

- (void) setBottomLineStyle:(CellLineStyle)style
{
    _bottomLineStyle = style;
    CGRect rect = self.bottomLine.frame;
    if (style == CellLineStyleDefault) {
        rect.origin.x =  _leftFreeSpace;
        rect.size.width = self.frame.size.width - _leftFreeSpace;
        [self.bottomLine setFrame:rect];
        [self.bottomLine setHidden:NO];
    }
    else if (style == CellLineStyleFill) {
        rect.origin.x =  0;
        rect.size.width = self.frame.size.width;
        [self.bottomLine setFrame:rect];
        [self.bottomLine setHidden:NO];
    }
    else if (style == CellLineStyleNone) {
        [self.bottomLine setHidden:YES];
    }
}

- (UIView *) bottomLine
{
    if (_bottomLine == nil) {
        _bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0.5f)];
        [_bottomLine setBackgroundColor:[UIColor grayColor]];
        [_bottomLine setAlpha:0.4];
        [self.contentView addSubview:_bottomLine];
    }
    return _bottomLine;
}

- (UIView *) topLine
{
    if (_topLine == nil) {
        _topLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0.5f)];
        [_topLine setBackgroundColor:[UIColor grayColor]];
        [_topLine setAlpha:0.4];
        [self.contentView addSubview:_topLine];
    }
    return _topLine;
}

@end
