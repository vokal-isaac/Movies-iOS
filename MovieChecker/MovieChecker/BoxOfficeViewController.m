//
//  BoxOfficeViewController.m
//  MovieChecker
//
//  Created by Joseph Goldberg on 1/21/15.
//  Copyright (c) 2015 Vokal. All rights reserved.
//

#import "BoxOfficeViewController.h"
#import "BoxOfficeCell.h"
#import "Movie.h"

@interface BoxOfficeViewController ()

@end

@implementation BoxOfficeViewController

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.movies.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BoxOfficeCell *boxOfficeCell = (BoxOfficeCell *)[tableView dequeueReusableCellWithIdentifier:@"BoxOfficeMovieCell"];
    Movie *movie = self.movies[indexPath.row];
    boxOfficeCell.nameLabel.text = movie.name;
    boxOfficeCell.salesLabel.text = movie.sales;
    return boxOfficeCell;
}

@end
