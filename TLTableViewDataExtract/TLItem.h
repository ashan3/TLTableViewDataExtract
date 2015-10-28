//
//  TLItem.h
//  TLTableViewDataExtractDemo
//
//  Created by libokun on 15/11/21.
//  Copyright © 2015年 lbk. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, TLItemType) {
    TLItemTypeText,                 // 文字
    TLItemTypeMutiText,             // 多行文字
    TLItemTypeTextWithRightTitle,   // 带右标题
    TLItemTypeToSubVCChoose,        // subVC选择
    TLItemTypeToSubVCText,          // subVC输入文字
    TLItemTypeDate,                 // 日期
    TLItemTypeTime,                 // 时间
    TLItemTypeTextWithoutTitle,     // 文字，没有标题
    TLItemTypeMutiTextWithoutTitle, // 多行文字，没有标题
    TLItemTypeImages,
    TLItemTypeIndustry,
};

@interface TLItem : NSObject

@property (nonatomic, assign) TLItemType type;

@property (nonatomic, strong) NSString *key;        // 网络传输json中的key

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *placeholder;
@property (nonatomic, strong) NSString *rightTitle;
@property (nonatomic, strong) NSArray *images;

@property (nonatomic, strong) NSArray *selectItems;
@property (nonatomic, strong) NSArray *selectedItems;

+ (TLItem *) createTextItemWithKey:(NSString *)key title:(NSString *)title placeholder:(NSString *)placeholder rightTitle:(NSString *)rightTitle;
+ (TLItem *) createTextItemWithKey:(NSString *)key title:(NSString *)title placeholder:(NSString *)placeholder;
+ (TLItem *) createSubSelectItemWithKey:(NSString *)key title:(NSString *)title selecteItems:(NSArray *)selectItems;
+ (TLItem *) createSubTextItemWithKey:(NSString *)key title:(NSString *)title;
+ (TLItem *) createDateItemWithKey:(NSString *)key title:(NSString *)title placeholder:(NSString *)placeholder;
+ (TLItem *) createTimeItemWithKey:(NSString *)key title:(NSString *)title placeholder:(NSString *)placeholder;

- (id) initWithType:(TLItemType)type andKey:(NSString *)key;

@end
