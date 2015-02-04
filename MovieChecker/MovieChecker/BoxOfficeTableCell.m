//
//  BoxOfficeCell.m
//  MovieChecker
//
//  Created by Joseph Goldberg on 1/22/15.
//  Copyright (c) 2015 Vokal. All rights reserved.
//

#import "BoxOfficeTableCell.h"

#import <SDWebImage/UIImageView+WebCache.h>

@interface BoxOfficeTableCell ()

@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UIImageView *thumbnailImageView;

@end

@implementation BoxOfficeTableCell

- (void)displayMovie:(Movie *)movie
{
    [super displayMovie:movie];
    self.nameLabel.text = movie.name;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.contentView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.contentView.translatesAutoresizingMaskIntoConstraints = YES;
}

@end
