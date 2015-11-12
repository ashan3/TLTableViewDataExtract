//
//  TLDEViewController2.m
//  TLTableViewDataExtractDemo
//
//  Created by libokun on 15/11/21.
//  Copyright © 2015年 lbk. All rights reserved.
//

#import "TLDEViewController2.h"
#import "UIAlertView+Blocks.h"

@implementation TLDEViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:@"测试2"];
    
    self.data = [self getTextData];
}

#pragma mark - Event Response
- (void) sendButtonDown
{
    [self.dic setValue:@"123" forKey:@"auth_key"];
    NSLog(@"%@", self.dic);
    [UIAlertView showAlertViewWithTitle:@"Dic 数据" message:[NSString stringWithFormat:@"%@", self.dic]];
}

#pragma mark - Getter
- (NSArray *) getTextData
{
    TLItem *title = [[TLItem alloc] initWithType:TLItemTypeTextWithoutTitle andKey:@"title"];
    [title setPlaceholder:@"请输入标题"];
    TLItem *industry = [[TLItem alloc] initWithType:TLItemTypeIndustry andKey:@"industry"];
    [industry setSelectItems:@[@[@"机构组织",
                                 @"农林牧渔",
                                 @"医药卫生",
                                 @"建筑建材",
                                 @"冶金矿产",
                                 @"石油化工",
                                 @"水利水电",
                                 @"交通运输",
                                 @"信息产业",
                                 @"机械机电",
                                 @"轻工食品",
                                 @"服装纺织",
                                 @"专业服务",
                                 @"安全防护",
                                 @"环保绿化",
                                 @"旅游休闲",
                                 @"办公文教",
                                 @"电子电工",
                                 @"玩具礼品",
                                 @"家居用品",
                                 @"物资",
                                 @"包装",
                                 @"体育",
                                 @"办公"]]];
    TLItem *detail = [[TLItem alloc] initWithType:TLItemTypeMutiTextWithoutTitle andKey:@"detail"];
    [detail setPlaceholder:@"请输入内容"];
    TLItem *images = [[TLItem alloc] initWithType:TLItemTypeImages andKey:@"images"];
    return @[@[title], @[industry, detail, images]];
}

@end
