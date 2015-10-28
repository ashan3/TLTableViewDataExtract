//
//  TLDataPickerController.m
//  TLTableViewDataExtractDemo
//
//  Created by libokun on 15/11/21.
//  Copyright © 2015年 lbk. All rights reserved.
//

#import "TLDataPickerController.h"
#import "TLConstant.h"

#import "TLTableViewCell.h"

@interface TLDataPickerController ()

@property (nonatomic, strong) UIBarButtonItem *finishedBarButton;

@end

@implementation TLDataPickerController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:@"请选择"];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]}];
    
    if (self.navigationController.viewControllers.count == 1) {
        UIBarButtonItem *cancelBarButton = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelButtonDown:)];
        [self.navigationItem setLeftBarButtonItem:cancelBarButton];
    }
    
    [self.tableView setBackgroundColor:COLOR_BACKGROUND];
    [self.tableView setTableHeaderView:[[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_SCREEN, 15.0f)]];
    [self.tableView registerClass:[TLTableViewCell class] forCellReuseIdentifier:@"TLTableViewCell"];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

- (void) setDataPickerMode:(TLDataPickerMode)dataPickerMode
{
    _dataPickerMode = dataPickerMode;
    if (dataPickerMode == TLDataPickerModeOne) {
        [self.navigationItem setRightBarButtonItem:nil];
    }
    else {
        [self.navigationItem setRightBarButtonItem:self.finishedBarButton];
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.data.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self.data objectAtIndex:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *item = [[self.data objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    TLTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TLTableViewCell"];
    [cell.textLabel setText:item];
    [self.selectedArray containsObject:item] ? [cell setAccessoryType:UITableViewCellAccessoryCheckmark] : [cell setAccessoryType:UITableViewCellAccessoryNone];
    indexPath.row == 0 ? [cell setTopLineStyle:CellLineStyleFill] : [cell setTopLineStyle:CellLineStyleNone];
    indexPath.row == [[_data objectAtIndex:indexPath.section] count] - 1 ? [cell setBottomLineStyle:CellLineStyleFill] : [cell setBottomLineStyle:CellLineStyleDefault];
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 43.0f;
}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 15.0f;
}

- (UIView *) tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [UIView new];
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    id item = [[self.data objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    if (self.dataPickerMode == TLDataPickerModeOne) {
        if (_delegate && [_delegate respondsToSelector:@selector(dataPickerController:didSelectItem:)]) {
            [_delegate dataPickerController:self didSelectItem:item];
        }
    }
    else {
        [self.selectedArray containsObject:item] ? [self.selectedArray removeObject:item] : [self.selectedArray addObject:item];
        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

#pragma mark - Event Response
- (void) cancelButtonDown:(UIBarButtonItem *)sender
{
    if (_delegate && [_delegate respondsToSelector:@selector(dataPickerControllerCancelButtonDown:)]) {
        [_delegate dataPickerControllerCancelButtonDown:self];
    }
}

- (void) finishedButtonDown
{
    if (_delegate && [_delegate respondsToSelector:@selector(dataPickerController:didSelectItems:)]) {
        [_delegate dataPickerController:self didSelectItems:self.selectedArray];
    }
}


#pragma mark - Getter
- (NSMutableArray *) selectedArray
{
    if (_selectedArray == nil) {
        _selectedArray = [[NSMutableArray alloc] init];
    }
    return _selectedArray;
}

- (UIBarButtonItem *) finishedBarButton
{
    if (_finishedBarButton == nil) {
        _finishedBarButton = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(finishedButtonDown)];
    }
    return _finishedBarButton;
}

@end
