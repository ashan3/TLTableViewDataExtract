//
//  TLItemImagesCell.h
//  TLTableViewDataExtractDemo
//
//  Created by libokun on 15/11/21.
//  Copyright © 2015年 lbk. All rights reserved.
//

#import "TLTableViewCell.h"
#import "TLItem.h"

@protocol TLItemImagesCellDelegate <NSObject>
- (void) imageItemCell:(TLItem *)item didSelecteImageIndex:(NSInteger)index;
- (void) imageItemCellAddImageButtonDown:(TLItem *)item;
@end

@interface TLItemImagesCell : TLTableViewCell

@property (nonatomic, assign) id<TLItemImagesCellDelegate>delegate;

@property (nonatomic, strong) TLItem *item;

@end
