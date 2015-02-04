//
//  BoxOfficeCollectionViewCell.m
//  MovieChecker
//
//  Created by Joseph Goldberg on 1/27/15.
//  Copyright (c) 2015 Vokal. All rights reserved.
//

#import "BoxOfficeCollectionCell.h"

#import <SDWebImage/UIImageView+WebCache.h>

@interface BoxOfficeCollectionCell ()

@property (nonatomic, weak) IBOutlet UIImageView *thumbnailImageView;

@end

@implementation BoxOfficeCollectionCell

- (void)displayMovie:(Movie *)movie
{
    typeof(self) __weak weakSelf = self;
    [self.thumbnailImageView sd_setImageWithURL:[NSURL URLWithString:movie.imagePath]
                                      completed:^(UIImage *image,
                                                  NSError *error,
                                                  SDImageCacheType cacheType,
                                                  NSURL *imageURL) {
                                          weakSelf.thumbnailImageView.image = image;
    }];
}

@end
