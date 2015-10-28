//
//  TLItemIndustryCell.m
//  TLTableViewDataExtractDemo
//
//  Created by libokun on 15/11/21.
//  Copyright © 2015年 lbk. All rights reserved.
//

#import "TLItemIndustryCell.h"
#import "TLConstant.h"

#define     HEIGHT_BUTTON_ITEM      22

@interface TLItemIndustryCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) NSMutableArray *buttonArray;

@end

@implementation TLItemIndustryCell

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        [self addSubview:self.titleLabel];
        [self.titleLabel setText:@"适用行业"];
    }
    return self;
}

- (void) layoutSubviews
{
    self.leftFreeSpace = WIDTH_SCREEN *0.043;
    [super layoutSubviews];
    
    CGSize size = [self.titleLabel sizeThatFitsMaxSize];
    [self.titleLabel setFrame:CGRectMake(self.leftFreeSpace, (43.0 - size.height) / 2.0, size.width, size.height)];
    
    float x = self.leftFreeSpace;
    float y = 43.0f;
    float w = (self.frameWidth - x * 2 - 10) / 4 - 5;
    float h = HEIGHT_BUTTON_ITEM - 4;
    for (int i = 0; i < self.item.selectedItems.count; i ++) {
        UIButton *button = [self.buttonArray objectAtIndex:i];
        [button setFrame:CGRectMake(x, y, w, h)];
        if ((i + 1) % 4 == 0) {
            x = self.leftFreeSpace;
            y += HEIGHT_BUTTON_ITEM;
        }
        else {
            x += w + 5;
        }
    }
}

- (void) setItem:(TLItem *)item
{
    _item = item;
    for (int i = 0; i < item.selectedItems.count; i++) {
        UIButton *button;
        if (i < self.buttonArray.count) {
            button = [self.buttonArray objectAtIndex:i];
        }
        else {
            button = [[UIButton alloc] init];
            [button.titleLabel setFont:[UIFont systemFontOfSize:13.0f]];
            [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [button.layer setMasksToBounds:YES];
            [button.layer setCornerRadius:2.0f];
            [button.layer setBorderWidth:0.5f];
            [button.layer setBorderColor:[UIColor grayColor].CGColor];
            [self.buttonArray addObject:button];
        }
        [button setTitle:[item.selectedItems objectAtIndex:i] forState:UIControlStateNormal];
        [self addSubview:button];
    }
    for (int i = (int)(item.selectedItems.count); i < self.buttonArray.count; i ++) {
        UIButton *button = [self.buttonArray objectAtIndex:i];
        [button removeFromSuperview];
    }
}

+ (CGFloat) getCellHeightOfTLItem:(TLItem *)item
{
    float h = 43.0f;
    if (item.selectedItems.count != 0) {
        h += ((item.selectedItems.count / 4 + (item.selectedItems.count % 4 == 0 ? 0 : 1)) * HEIGHT_BUTTON_ITEM);
        h += 5;
    }
    return h;
}

#pragma mark - Getter
- (NSMutableArray *) buttonArray
{
    if (_buttonArray == nil) {
        _buttonArray = [[NSMutableArray alloc] init];
    }
    return _buttonArray;
}

- (UILabel *) titleLabel
{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        [_titleLabel setFont:[UIFont systemFontOfSize:15.0f]];
    }
    return _titleLabel;
}

@end
