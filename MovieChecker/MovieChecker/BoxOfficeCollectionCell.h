//
//  BoxOfficeCollectionCell.h
//  MovieChecker
//
//  Created by Joseph Goldberg on 1/27/15.
//  Copyright (c) 2015 Vokal. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Movie.h"

@interface BoxOfficeCollectionCell : UICollectionViewCell

- (void)displayMovie:(Movie *)movie;

@end
