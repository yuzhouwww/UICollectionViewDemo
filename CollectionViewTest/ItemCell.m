//
//  ItemCell.m
//  CollectionViewTest
//
//  Created by yuzhou on 13-7-5.
//  Copyright (c) 2013年 wzyk. All rights reserved.
//

#import "ItemCell.h"

@implementation ItemCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
//    self.contentView.backgroundColor = [UIColor colorWithRed:arc4random() % 255 / 255.00 green:arc4random() % 255 / 255.00 blue:arc4random() % 255 / 255.00 alpha:1];
}

- (void)prepareForReuse
{
//    self.contentView.backgroundColor = [UIColor colorWithRed:arc4random() % 255 / 255.00 green:arc4random() % 255 / 255.00 blue:arc4random() % 255 / 255.00 alpha:1];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)dealloc {
    [_contentImageView release];
    [super dealloc];
}
@end
