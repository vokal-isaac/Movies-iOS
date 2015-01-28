//
//  BoxOfficeCell.m
//  MovieChecker
//
//  Created by Joseph Goldberg on 1/22/15.
//  Copyright (c) 2015 Vokal. All rights reserved.
//

#import "BoxOfficeCell.h"

@interface BoxOfficeCell ()

@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UIImageView *thumbnailImageView;

@end

@implementation BoxOfficeCell

- (void)setThumbnailImage:(UIImage *)image
{
    self.thumbnailImageView.image = image;
}

- (void)setName:(NSString *)name
{
    self.nameLabel.text = name;
}

@end
