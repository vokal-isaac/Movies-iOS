//
//  MovieDetailViewController.m
//  MovieChecker
//
//  Created by Joseph Goldberg on 1/22/15.
//  Copyright (c) 2015 Vokal. All rights reserved.
//

#import "MovieDetailViewController.h"

@interface MovieDetailViewController ()

@end

@implementation MovieDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.movieTitle.text = self.movie.name;
    self.year.text = [NSString stringWithFormat:@"%ld", (long)self.movie.year];
    self.rating.text = self.movie.rating;
    
    self.synopsis.numberOfLines = 0;
    self.synopsis.text = self.movie.synopsis;
    [self.synopsis sizeToFit];
}

#pragma mark - UITableViewDataSource methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // TODO: Revisit
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 3;
            break;
        case 1:
            return 1;
        default:
            return 0; // Error
    }
}

@end
