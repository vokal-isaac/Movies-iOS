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

- (void)setThumbnailImageFromURL:(NSURL *)url
{
    [self.thumbnailImageView sd_setImageWithURL:url completed:^(UIImage *image,
                                                                NSError *error,
                                                                SDImageCacheType cacheType,
                                                                NSURL *imageURL) {
        self.thumbnailImageView.image = image;
    }];
}

- (void)setName:(NSString *)name
{
    self.nameLabel.text = name;
}

@end
