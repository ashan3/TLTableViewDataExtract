//
//  TLDEViewController1.m
//  TLTableViewDataExtractDemo
//
//  Created by libokun on 15/11/21.
//  Copyright © 2015年 lbk. All rights reserved.
//

#import "TLDEViewController1.h"
#import "UIAlertView+Blocks.h"

@implementation TLDEViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:@"测试1"];
    
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
    TLItem *productName = [TLItem createTextItemWithKey:@"title"
                                                  title:@"产品名称"
                                            placeholder:@"输入产品名称"];
    TLItem *startMoney = [TLItem createTextItemWithKey:@"min_money"
                                                 title:@"起购金额"
                                           placeholder:@"请输入起购金额"
                                            rightTitle:@"万元"];
    TLItem *timeLimit = [TLItem createTextItemWithKey:@"invest_period"
                                                title:@"投资期限"
                                          placeholder:@"请输入投资期限"
                                           rightTitle:@"天"];
    TLItem *yield = [TLItem createTextItemWithKey:@"income_rate"
                                            title:@"收益率"
                                      placeholder:@"请输入收益率"
                                       rightTitle:@"%"];
    TLItem *profitType = [TLItem createSubSelectItemWithKey:@"income_type"
                                                      title:@"收益类型"
                                               selecteItems:@[@[@"保本固定",
                                                                @"保本浮动",
                                                                @"非保本浮动"],
                                                              ]];
    TLItem *miniYield = [TLItem createTextItemWithKey:@"min_income_rate"
                                                title:@"最低收益率"
                                          placeholder:@"请输入最低收益率"
                                           rightTitle:@"%"];
    TLItem *moneyType = [TLItem createSubSelectItemWithKey:@"coin_type"
                                                     title:@"币种"
                                              selecteItems:@[@[@"人民币",
                                                               @"美金",
                                                               @"英镑"]]];
    TLItem *startSell = [TLItem createDateItemWithKey:@"sale_start_time"
                                                title:@"销售起始日"
                                          placeholder:nil];
    TLItem *endSell = [TLItem createDateItemWithKey:@"sale_end_time"
                                              title:@"销售终止日"
                                        placeholder:nil];
    TLItem *startInterest = [TLItem createDateItemWithKey:@"income_start_time"
                                                    title:@"计息开始日"
                                              placeholder:nil];
    TLItem *endInterest = [TLItem createDateItemWithKey:@"income_end_time"
                                                  title:@"计息终止日"
                                            placeholder:nil];
    TLItem *other = [TLItem createSubTextItemWithKey:@"product_explain"
                                               title:@"其他说明"];
    return @[@[productName], @[startMoney, timeLimit, moneyType], @[yield, profitType, miniYield], @[startSell, endSell, startInterest, endInterest], @[other]];
}

@end
