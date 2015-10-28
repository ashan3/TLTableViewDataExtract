//
//  TLDEBaseTableViewController.m
//  TLTableViewDataExtractDemo
//
//  Created by libokun on 15/11/21.
//  Copyright © 2015年 lbk. All rights reserved.
//

#import "TLDEBaseTableViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "TLConstant.h"

#import "TLSubTextViewController.h"
#import "TLDataPickerController.h"
#import "TLDatePickerController.h"
#import "DNImagePickerController.h"
#import "DNAsset.h"

#import "TLItemCell.h"
#import "TLItemImagesCell.h"
#import "TLItemIndustryCell.h"

#import "UIAlertView+Blocks.h"
#import "NSDate+Extension.h"


@interface TLDEBaseTableViewController () <TLSubTextVCDelegate, TLDataPickerControllerDelegate, TLDatePickerControllerDelegate, DNImagePickerControllerDelegate>

@property (nonatomic, strong) DNImagePickerController *imagePicker;

@end

@implementation TLDEBaseTableViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:COLOR_BACKGROUND];
    [self.tableView setTableHeaderView:[[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 10)]];
    
    [self.tableView registerClass:[TLItemCell class] forCellReuseIdentifier:@"TLItemCell"];
    [self.tableView registerClass:[TLItemImagesCell class] forCellReuseIdentifier:@"TLItemImagesCell"];
    [self.tableView registerClass:[TLItemIndustryCell class] forCellReuseIdentifier:@"TLItemIndustryCell"];
    
    UIBarButtonItem *sendBarButton = [[UIBarButtonItem alloc] initWithTitle:@"发布" style:UIBarButtonItemStylePlain target:self action:@selector(sendButtonDown)];
    [self.navigationItem setRightBarButtonItem:sendBarButton];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.tableView setFrame:self.view.bounds];
}

#pragma mark - UITableViewDataSource
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return _data.count;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[_data objectAtIndex:section] count];
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TLItem *item = [[_data objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    id cell = nil;
    __weak typeof(self) weakSelf = self;        // 小心循环引用
    if (item.type == TLItemTypeImages) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"TLItemImagesCell"];
        [cell setItem:item];
        [cell setDelegate:self];
    }
    else if (item.type == TLItemTypeIndustry) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"TLItemIndustryCell"];
        [cell setItem:item];
    }
    else {
        cell = [tableView dequeueReusableCellWithIdentifier:@"TLItemCell"];
        [cell setItem:item];
        [[cell rac_reSignal] subscribeNext:^(id x) {
            [weakSelf.dic setValue:x forKey:item.key];
        }];
    }
    indexPath.row == 0 ? [cell setTopLineStyle:CellLineStyleFill] : [cell setTopLineStyle:CellLineStyleNone];
    if (indexPath.row + 1 < [[_data objectAtIndex:indexPath.section] count]){
        TLItem *nextItem = [[_data objectAtIndex:indexPath.section] objectAtIndex:indexPath.row + 1];
        if (nextItem.type == TLItemTypeImages) {
            [cell setBottomLineStyle:CellLineStyleNone];
        }
        else {
            indexPath.row == [[_data objectAtIndex:indexPath.section] count] - 1 ? [cell setBottomLineStyle:CellLineStyleFill] : [cell setBottomLineStyle:CellLineStyleDefault];
        }
    }
    else {
        indexPath.row == [[_data objectAtIndex:indexPath.section] count] - 1 ? [cell setBottomLineStyle:CellLineStyleFill] : [cell setBottomLineStyle:CellLineStyleDefault];
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (UIView *) tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [UIView new];
}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 15.0f;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TLItem *item = [[_data objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    if (item.type == TLItemTypeImages) {
        return 60.0f;
    }
    else if (item.type == TLItemTypeIndustry) {
        return [TLItemIndustryCell getCellHeightOfTLItem:item];
    }
    else if (item.type == TLItemTypeMutiText || item.type == TLItemTypeMutiTextWithoutTitle) {
        return 180.0f;
    }
    return [TLItemCell getCellHeightOfItem:item];
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    TLItem *item = [[_data objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    if (item.type == TLItemTypeDate || item.type == TLItemTypeTime) {
        TLDatePickerController *datePicker = [[TLDatePickerController alloc] init];
        [datePicker setDelegate:self];
        [datePicker setIntroductionText:item.title];
        [datePicker setUserInfo:item];
        [datePicker setDatePickerMode:(item.type == TLItemTypeDate ? UIDatePickerModeDate : UIDatePickerModeDateAndTime)];
        [self.navigationController pushViewController:datePicker animated:YES];
    }
    else if (item.type == TLItemTypeToSubVCChoose || item.type == TLItemTypeIndustry) {
        TLDataPickerController *dataPickerVC = [[TLDataPickerController alloc] init];
        [dataPickerVC setData:item.selectItems];
        [dataPickerVC setDelegate:self];
        [dataPickerVC setUserInfo:item];
        [dataPickerVC setSelectedArray:[NSMutableArray arrayWithArray:item.selectedItems]];
        [dataPickerVC setDataPickerMode:(item.type == TLItemTypeIndustry ? TLDataPickerModeMore : TLDataPickerModeOne)];
        [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]}];
        [self.navigationController pushViewController:dataPickerVC animated:YES];
    }
    else if (item.type == TLItemTypeToSubVCText) {
        TLSubTextViewController *textVC = [[TLSubTextViewController alloc] init];
        [textVC.navigationItem setTitle:item.title];
        [textVC setText:item.placeholder];
        [textVC setDelegate:self];
        [textVC setUserInfo:item];
        [self.navigationController pushViewController:textVC animated:YES];
    }
}

#pragma mark - TLItemImagesCellDelegate
- (void) reImageItemCell:(TLItem *)item didSelecteImageIndex:(NSInteger)index
{
}

- (void) reImageItemCellAddImageButtonDown:(TLItem *)item
{
    self.imagePicker.userInfo = item;
    [self presentViewController:self.imagePicker animated:YES completion:nil];
}

#pragma mark - TLSubTextVCDelegate
- (void) subTextViewController:(TLSubTextViewController *)subTextVC didEnterText:(NSString *)text
{
    TLItem *TLItem = subTextVC.userInfo;
    TLItem.placeholder = text;
    [self.tableView reloadData];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - DNImagePickerControllerDelegate
- (void)dnImagePickerController:(DNImagePickerController *)imagePickerController
                     sendImages:(NSArray *)imageAssets
                    isFullImage:(BOOL)fullImage
{
    NSMutableArray *images = [[NSMutableArray alloc] initWithCapacity:imageAssets.count];
    TLItem *item = imagePickerController.userInfo;
    item.images = images;
    
    __weak typeof(self) weakSelf = self;
    for (DNAsset *dAsset in imageAssets) {
        [[[ALAssetsLibrary alloc] init] assetForURL:dAsset.url
                                        resultBlock:^(ALAsset *asset) {
                                            UIImage *image = [UIImage imageWithCGImage:[[asset defaultRepresentation] fullScreenImage]];
                                            NSString *imageName = [NSString stringWithFormat:@"%lf", [[NSDate date]timeIntervalSince1970]];
                                            NSString *imagePath = [NSString stringWithFormat:@"%@/%@", PATH_IMAGES, imageName];
                                            NSData *imageData = (UIImagePNGRepresentation(image) == nil ? UIImageJPEGRepresentation(image, 1) : UIImagePNGRepresentation(image));
                                            [[NSFileManager defaultManager] createFileAtPath:imagePath contents:imageData attributes:nil];
                                            [images addObject:imageName];
                                            [weakSelf.dic setValue:images forKey:item.key];
                                            [weakSelf.tableView reloadData];
                                        } failureBlock:^(NSError *error) {
                                            [UIAlertView showAlertViewWithTitle:@"出错了" message:[NSString stringWithFormat:@"请到“我”->“意见反馈”中提交错误信息，我们会尽快处理。\n%@", [error description]]];
                                        }];
    }
}

- (void)dnImagePickerControllerDidCancel:(DNImagePickerController *)imagePicker
{
    [imagePicker dismissViewControllerAnimated:YES completion:^{
        
    }];
}

#pragma mark - TLDataPickerControllerDelegate
- (void) dataPickerController:(TLDataPickerController *)dataPickerController didSelectItem:(id)item
{
    TLItem *TLItem = dataPickerController.userInfo;
    TLItem.placeholder = item;
    [self.tableView reloadData];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) dataPickerController:(TLDataPickerController *)dataPickerController didSelectItems:(NSArray *)items
{
    TLItem *TLItem = dataPickerController.userInfo;
    TLItem.selectedItems = items;
    [self.tableView reloadData];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - TLDatePickerControllerDelegate
- (void) datePickerViewController:(TLDatePickerController *)datePickerViewController didSelectedDate:(id)date
{
    TLItem *TLItem = datePickerViewController.userInfo;
    TLItem.placeholder = [NSString stringWithFormat:@"%@", TLItem.type == TLItemTypeDate ? [date formatYMD] : [date formatYMDHM]];
    [self.tableView reloadData];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Event Response
- (void) sendButtonDown
{
    
}

#pragma mark - Getter
- (NSMutableDictionary *) dic
{
    if (_dic == nil) {
        _dic = [[NSMutableDictionary alloc] init];
    }
    return _dic;
}

- (DNImagePickerController *) imagePicker
{
    if (_imagePicker == nil) {
        _imagePicker = [[DNImagePickerController alloc] init];
        [_imagePicker setImagePickerDelegate:self];
    }
    return _imagePicker;
}
@end
