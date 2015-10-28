//
//  TLItemImagesCell.m
//  TLTableViewDataExtractDemo
//
//  Created by libokun on 15/11/21.
//  Copyright © 2015年 lbk. All rights reserved.
//

#import "TLItemImagesCell.h"
#import "TLConstant.h"

#define     MAX_IMAGE_NUM       9

@interface TLItemImagesCell ()
@property (nonatomic, strong) UIButton *addImageView;
@property (nonatomic, strong) NSMutableArray *imageVCArray;
@property (nonatomic, strong) UIScrollView *scrollView;
@end

@implementation TLItemImagesCell
- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        [self addSubview:self.scrollView];
    }
    return self;
}

- (void) layoutSubviews
{
    self.leftFreeSpace = WIDTH_SCREEN *0.043;
    [super layoutSubviews];
    
    float x = self.leftFreeSpace;
    float y = self.frameHeight * 0.1;
    float h = self.frameHeight - y * 2.0;
    float w = self.frameWidth - x * 2;
    [self.scrollView setFrame:CGRectMake(self.leftFreeSpace, y, w, h)];
    
    x = 0;
    y = 0;
    w = h * 1.2;
    float spaceX = 5;
    int count = (int)self.item.images.count;
    for (int i = 0; i < count; i ++) {
        UIImageView *imageV = [self.imageVCArray objectAtIndex:i];
        [imageV setFrame:CGRectMake(x, y, w, h)];
        x += w + spaceX;
    }
    if (count < MAX_IMAGE_NUM) {
        count ++;
        [self.addImageView setFrame:CGRectMake(x, y, w, h)];
        [self.scrollView addSubview:self.addImageView];
    }
    else {
        [self.addImageView removeFromSuperview];
    }
    [self.scrollView setContentSize:CGSizeMake(w * count + spaceX * (count - 1), h)];
}

- (void) setItem:(TLItem *)item
{
    _item = item;
    
    int count = (int)self.item.images.count;
    for (int i = 0; i < count; i ++) {
        NSString *imageName = [self.item.images objectAtIndex:i];
        NSString *imagePath = [NSString stringWithFormat:@"%@/%@", PATH_IMAGES, imageName];
        UIButton *imageV;
        if (i < self.imageVCArray.count) {
            imageV = [self.imageVCArray objectAtIndex:i];
        }
        else {
            imageV = [[UIButton alloc] init];
            [self.imageVCArray addObject:imageV];
        }
        [imageV setImage:[UIImage imageNamed:imagePath] forState:UIControlStateNormal];
        [imageV setTag:i];
        [imageV addTarget:self action:@selector(imageButtonDown:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView addSubview:imageV];
    }
    for (int i = count; i < self.imageVCArray.count; i ++) {
        UIButton *imageV = [self.imageVCArray objectAtIndex:i];
        [imageV removeFromSuperview];
    }
}

#pragma mark - Event Response
- (void) addImageButtonDown
{
    if (_delegate && [_delegate respondsToSelector:@selector(imageItemCellAddImageButtonDown:)]) {
        [_delegate imageItemCellAddImageButtonDown:_item];
    }
}

- (void) imageButtonDown:(UIButton *)sender
{
    if (_delegate && [_delegate respondsToSelector:@selector(imageItemCell:didSelecteImageIndex:)]) {
        [_delegate imageItemCell:_item didSelecteImageIndex:self.tag];
    }
}

#pragma mark - Getter
- (UIButton *) addImageView
{
    if (_addImageView == nil) {
        _addImageView = [[UIButton alloc] init];
        [_addImageView setImage:[UIImage imageNamed:@"default_add_photo"] forState:UIControlStateNormal];
        [_addImageView addTarget:self action:@selector(addImageButtonDown) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addImageView;
}

- (NSMutableArray *) imageVCArray
{
    if (_imageVCArray == nil) {
        _imageVCArray = [[NSMutableArray alloc] init];
    }
    return _imageVCArray;
}

- (UIScrollView *) scrollView
{
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] init];
        [_scrollView setShowsHorizontalScrollIndicator:NO];
        [_scrollView setShowsVerticalScrollIndicator:NO];
        [_scrollView setScrollsToTop:NO];
    }
    return _scrollView;
}
@end
