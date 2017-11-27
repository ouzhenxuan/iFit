//
//  ZXBottomMultiPurposeViewCollectionCell.m
//  TopHot
//
//  Created by Liushannoon on 16/4/12.
//  Copyright © 2016年 Liushannoon. All rights reserved.
//

#import "ZXBottomMultiPurposeViewCollectionCell.h"
#import "ZXBottomMultiPurposeViewItem.h"
#import "UIView+ZXExtension.h"

@interface ZXBottomMultiPurposeViewCollectionCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *button;

@end

@implementation ZXBottomMultiPurposeViewCollectionCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.titleLabel.font = [UIFont systemFontOfSize:11];
    self.titleLabel.textColor = C5;
    self.clipsToBounds = NO;
    self.titleLabel.adjustsFontSizeToFitWidth = YES;
}

- (void)setItem:(ZXBottomMultiPurposeViewItem *)item
{
    _item = item;
    self.imageView.image = [UIImage imageNamed:item.image];
    self.imageView.highlightedImage = [UIImage imageNamed:item.highImage];
    self.titleLabel.text = item.title;
    self.clipsToBounds = NO;
}

- (void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    if (highlighted) {
        self.alpha = 0.6;
    } else {
        self.alpha = 1.0;
    }
}

@end
