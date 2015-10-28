//
//  TLItemCell.h
//  TLTableViewDataExtractDemo
//
//  Created by libokun on 15/11/21.
//  Copyright © 2015年 lbk. All rights reserved.
//

#import "TLTableViewCell.h"
#import <ReactiveCocoa.h>
#import "TLItem.h"

@interface TLItemCell : TLTableViewCell

@property (nonatomic, strong) TLItem *item;

@property (nonatomic, strong) RACSignal *rac_reSignal;

+ (CGFloat) getCellHeightOfItem:(TLItem *)item;

@end
