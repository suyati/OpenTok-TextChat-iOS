//
//  ChatCell.m
//  SingleFit
//
//  Created by Rijo George on 30/07/15.
//  Copyright (c) 2015 Suyati Technologies. All rights reserved.
//

#import "ChatCell.h"

@implementation ChatCell

- (void)awakeFromNib {
    // Initialization code
    [self.bubbleView.layer setCornerRadius:15.0];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
