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

- (void)setThumbnailImageFromURL:(NSURL *)url
{
    [self.thumbnailImageView sd_setImageWithURL:url completed:^(UIImage *image,
                                                                NSError *error,
                                                                SDImageCacheType cacheType,
                                                                NSURL *imageURL) {
        self.thumbnailImageView.image = image;
    }];
}

@end
