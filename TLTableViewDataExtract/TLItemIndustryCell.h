//
//  TLItemIndustryCell.h
//  TLTableViewDataExtractDemo
//
//  Created by libokun on 15/11/21.
//  Copyright © 2015年 lbk. All rights reserved.
//

#import "TLTableViewCell.h"
#import "TLItem.h"

@interface TLItemIndustryCell : TLTableViewCell

@property (nonatomic, strong) TLItem *item;

+ (CGFloat) getCellHeightOfTLItem:(TLItem *)item;

@end
