//
//  TLItem.m
//  TLTableViewDataExtractDemo
//
//  Created by libokun on 15/11/21.
//  Copyright © 2015年 lbk. All rights reserved.
//

#import "TLItem.h"

@implementation TLItem

+ (TLItem *) createTextItemWithKey:(NSString *)key title:(NSString *)title placeholder:(NSString *)placeholder rightTitle:(NSString *)rightTitle
{
    TLItem *item = [[TLItem alloc] initWithType:TLItemTypeTextWithRightTitle andKey:key];
    item.title = title;
    item.placeholder = placeholder;
    item.rightTitle = rightTitle;
    return item;
}

+ (TLItem *) createTextItemWithKey:(NSString *)key title:(NSString *)title placeholder:(NSString *)placeholder
{
    TLItem *item = [[TLItem alloc] initWithType:TLItemTypeText andKey:key];
    item.key = key;
    item.title = title;
    item.placeholder = placeholder;
    return item;
}

+ (TLItem *) createSubSelectItemWithKey:(NSString *)key title:(NSString *)title selecteItems:(NSArray *)selectItems
{
    TLItem *item = [[TLItem alloc] initWithType:TLItemTypeToSubVCChoose andKey:key];
    item.title = title;
    item.selectItems = selectItems;
    return item;
}

+ (TLItem *) createSubTextItemWithKey:(NSString *)key title:(NSString *)title
{
    TLItem *item = [[TLItem alloc] initWithType:TLItemTypeToSubVCText andKey:key];
    item.title = title;
    return item;
}

+ (TLItem *) createDateItemWithKey:(NSString *)key title:(NSString *)title placeholder:(NSString *)placeholder
{
    TLItem *item = [[TLItem alloc] initWithType:TLItemTypeDate andKey:key];
    item.title = title;
    item.placeholder = placeholder;
    return item;
}

+ (TLItem *) createTimeItemWithKey:(NSString *)key title:(NSString *)title placeholder:(NSString *)placeholder
{
    TLItem *item = [[TLItem alloc] initWithType:TLItemTypeTime andKey:key];
    item.title = title;
    item.placeholder = placeholder;
    return item;
}

- (id) initWithType:(TLItemType)type andKey:(NSString *)key
{
    if (self = [super init]) {
        self.type = type;
        self.key = key;
    }
    return self;
}


@end
