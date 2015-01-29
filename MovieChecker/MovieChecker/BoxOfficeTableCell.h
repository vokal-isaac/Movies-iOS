//
//  BoxOfficeTableCell.h
//  MovieChecker
//
//  Created by Joseph Goldberg on 1/22/15.
//  Copyright (c) 2015 Vokal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BoxOfficeTableCell : UICollectionViewCell

- (void)setThumbnailImageFromURL:(NSURL *)url;
- (void)setName:(NSString *)name;

@end
