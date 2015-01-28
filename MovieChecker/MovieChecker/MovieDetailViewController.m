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
    self.title = self.movie.name;
    self.movieTitle.text = self.movie.name;
    self.year.text = [@(self.movie.year) description];
    self.rating.text = self.movie.rating;
    
    self.synopsis.numberOfLines = 0;
    self.synopsis.text = self.movie.synopsis;
    [self.synopsis sizeToFit];
}

@end
