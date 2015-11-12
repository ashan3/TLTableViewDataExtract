//
//  TLTestViewController.m
//  TLTableViewDataExtractDemo
//
//  Created by libokun on 15/11/21.
//  Copyright © 2015年 lbk. All rights reserved.
//

#import "TLTestViewController.h"

@implementation TLTestViewController

- (void) viewDidLoad
{
    [self.navigationItem setTitle:@"TLDEDemo"];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
}

#pragma mark - UITableViewDataSource
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    [cell.textLabel setText:[NSString stringWithFormat:@"测试样例%ld", indexPath.row + 1]];
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *className = [NSString stringWithFormat:@"TLDEViewController%ld", indexPath.row + 1];
    id nextVC = [[NSClassFromString(className) alloc] init];
    if (nextVC != nil) {
        [self.navigationController pushViewController:nextVC animated:YES];
    }
}


@end
