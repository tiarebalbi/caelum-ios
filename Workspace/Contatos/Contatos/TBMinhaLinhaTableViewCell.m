//
//  TBMinhaLinhaTableViewCell.m
//  Contatos
//
//  Created by ios4584 on 23/08/14.
//  Copyright (c) 2014 Tiarê Balbi. All rights reserved.
//

#import "TBMinhaLinhaTableViewCell.h"

#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


@implementation TBMinhaLinhaTableViewCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
//    [super setSelected:selected animated:animated];
    if(selected) {
        self.backgroundColor = UIColorFromRGB(0x91C46C);
        selected = NO;
    }

    // Configure the view for the selected state
}

@end
