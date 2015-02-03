//
//  MovieDetailViewController.m
//  MovieChecker
//
//  Created by Joseph Goldberg on 1/22/15.
//  Copyright (c) 2015 Vokal. All rights reserved.
//

#import "MovieDetailViewController.h"

@interface MovieDetailViewController ()

@property (nonatomic, weak) IBOutlet UILabel *movieTitleLabel;
@property (nonatomic, weak) IBOutlet UILabel *ratingLabel;
@property (nonatomic, weak) IBOutlet UILabel *synopsisLabel;
@property (nonatomic, weak) IBOutlet UILabel *yearLabel;
@property (nonatomic, weak) IBOutlet UITableViewCell *detailCell;

@end

@implementation MovieDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = self.movie.name;
    self.movieTitleLabel.text = self.movie.name;
    self.yearLabel.text = [@(self.movie.year) description];
    self.ratingLabel.text = self.movie.rating;
    self.synopsisLabel.numberOfLines = 0;
    self.synopsisLabel.text = self.movie.synopsis;
    [self.synopsisLabel sizeToFit];
    [self.detailCell sizeToFit];
    
}

@end
