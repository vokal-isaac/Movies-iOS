//
//  MovieDetailViewController.h
//  MovieChecker
//
//  Created by Joseph Goldberg on 1/22/15.
//  Copyright (c) 2015 Vokal. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Movie.h"

@interface MovieDetailViewController : UITableViewController

@property (nonatomic, weak) Movie *movie;

@end
