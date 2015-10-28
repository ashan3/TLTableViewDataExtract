//
//  TLItemCell.m
//  TLTableViewDataExtractDemo
//
//  Created by libokun on 15/11/21.
//  Copyright © 2015年 lbk. All rights reserved.
//

#import "TLItemCell.h"
#import "TLConstant.h"

static UILabel *hLabel = nil;

@interface TLItemCell ()<UITextViewDelegate>

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UILabel *rightLabel;

@end

@implementation TLItemCell

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubview: self.titleLabel];
        [self addSubview: self.textField];
        [self addSubview: self.rightLabel];
        [self addSubview: self.textView];
    }
    return self;
}

- (void) layoutSubviews
{
    self.leftFreeSpace = WIDTH_SCREEN * 0.043;
    [super layoutSubviews];
    
    float rightSpace = (self.accessoryType != UITableViewCellAccessoryNone ? 18 : 0) + self.leftFreeSpace;
    
    CGSize size = [self.titleLabel sizeThatFitsMaxSize];
    [self.titleLabel setFrame:CGRectMake(self.leftFreeSpace, 0, size.width, self.frameHeight)];
    
    size = [self.rightLabel sizeThatFitsMaxSize];
    float x = self.frameWidth - rightSpace - size.width;
    [self.rightLabel setFrame:CGRectMake(x, 0, size.width, self.frameHeight)];
    
    
    x = self.titleLabel.hidden ? self.leftFreeSpace : self.titleLabel.originX + self.titleLabel.frameWidth + 10;
    float w = self.rightLabel.hidden ? self.frameWidth - x - rightSpace : self.rightLabel.originX - x - rightSpace;
    [self.textField setFrame:CGRectMake(x, 0, w, self.frameHeight)];
    
    [self.textView setFrame:CGRectMake(x + 5, 3.5, w, self.frameHeight - 5)];
}

+ (CGFloat) getCellHeightOfItem:(TLItem *)item
{
    if (item.type == TLItemTypeToSubVCText) {
        if (hLabel == nil) {
            hLabel = [[UILabel alloc] init];
            [hLabel setNumberOfLines:0];
            [hLabel setFont:[UIFont systemFontOfSize:16.0f]];
        }
        
        [hLabel setText:item.title];
        CGSize size = [hLabel sizeThatFitsMaxSize];
        float x = WIDTH_SCREEN * 0.043 + size.width + 10;
        
        float w = WIDTH_SCREEN - x - WIDTH_SCREEN * 0.043 - 18;
        [hLabel setText:item.placeholder];
        
        float h = 24.0f + [hLabel sizeThatFits:CGSizeMake(w, MAXFLOAT)].height;
        return h > 43.0f ? h : 43.0f;
    }
    return 43.0f;
}


- (void) setItem:(TLItem *)item
{
    _item = item;
    
    // init
    _rac_reSignal = self.textField.rac_textSignal;
    [self.titleLabel setHidden:NO];
    [self.textField setHidden:YES];
    [self.textField setTextAlignment:NSTextAlignmentRight];
    [self.textField setUserInteractionEnabled:YES];
    [self.textView setHidden:YES];
    [self.rightLabel setHidden:YES];
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    [self setAccessoryType:UITableViewCellAccessoryNone];
    
    // setData
    [self.titleLabel setText:item.title];
    [self.textField setPlaceholder:item.placeholder];
    [self.textView setText:item.placeholder];
    [self.rightLabel setText:item.rightTitle];
    
    // updateStyle
    switch (_item.type) {
        case TLItemTypeText:
            [self.textField setHidden:NO];
            break;
        case TLItemTypeMutiText:
            
            break;
        case TLItemTypeTextWithRightTitle:
            [self.textField setHidden:NO];
            [self.rightLabel setHidden:NO];
            break;
        case TLItemTypeToSubVCText:
            _rac_reSignal = self.textView.rac_textSignal;
            [self setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
            [self setSelectionStyle:UITableViewCellSelectionStyleDefault];
            [self.textView setHidden:NO];
            [self.textView setUserInteractionEnabled:NO];
            [self.textView setTextAlignment:NSTextAlignmentRight];
            [self.textView setTextColor:[UIColor blackColor]];
            break;
        case TLItemTypeToSubVCChoose:
        case TLItemTypeDate:
        case TLItemTypeTime:
            [self.textField setText:self.textField.placeholder];
            [self.textField setHidden:NO];
            [self.textField setUserInteractionEnabled:NO];
            [self setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
            [self setSelectionStyle:UITableViewCellSelectionStyleDefault];
            break;
        case TLItemTypeTextWithoutTitle:
            [self.textField setHidden:NO];
            [self.textField setTextAlignment:NSTextAlignmentLeft];
            [self.titleLabel setHidden:YES];
            break;
        case TLItemTypeMutiTextWithoutTitle:
            [self.textView setHidden:NO];
            self.rac_reSignal = self.textView.rac_textSignal;
            [self.titleLabel setHidden:YES];
            break;
        default:
            break;
    }
}

#pragma mark - UITextViewDelegate
- (void) textViewDidBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:self.item.placeholder]) {
        [textView setText:@""];
        [textView setTextColor:[UIColor blackColor]];
    }
}

- (void) textViewDidEndEditing:(UITextView *)textView
{
    if (textView.text.length == 0) {
        [textView setText:self.item.placeholder];
        [textView setTextColor:[UIColor grayColor]];
    }
}

#pragma mark - Getter
- (UILabel *) titleLabel
{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        [_titleLabel setFont:[UIFont systemFontOfSize:16.0f]];
    }
    return _titleLabel;
}

- (UILabel *) rightLabel
{
    if (_rightLabel == nil) {
        _rightLabel = [[UILabel alloc] init];
        [_rightLabel setFont:[UIFont systemFontOfSize:16.0f]];
    }
    return _rightLabel;
}

- (UITextField *) textField
{
    if (_textField == nil) {
        _textField = [[UITextField alloc] init];
        [_textField setFont:[UIFont systemFontOfSize:16.0f]];
    }
    return _textField;
}

- (UITextView *) textView
{
    if (_textView == nil) {
        _textView = [[UITextView alloc] init];
        [_textView setFont:[UIFont systemFontOfSize:16.0f]];
        [_textView setTextColor:COLOR_GRAY];
        [_textView setDelegate:self];
    }
    return _textView;
}

@end
