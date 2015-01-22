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
#import "RottenTomatoes.h"

@interface BoxOfficeViewController ()

@property (nonatomic, strong) NSURLSession *session;

@end

@implementation BoxOfficeViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration ephemeralSessionConfiguration];
        //[config setHTTPAdditionalHeaders:@{@"apikey": [RottenTomatoes apiKey]}];
        self.session = [NSURLSession sessionWithConfiguration:config];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self moviesOnRottenTomatoes];
}

- (void)moviesOnRottenTomatoes
{
    NSURL *url = [RottenTomatoes boxOfficeURL];
    NSURLSessionDataTask *dataTask = [self.session dataTaskWithURL:url completionHandler:^(NSData *data,
                                                                                           NSURLResponse *response,
                                                                                           NSError *error) {
        if (!error) {
            NSHTTPURLResponse *httpResp = (NSHTTPURLResponse *)response;
            if (httpResp.statusCode == 200) {
                [self interpretBoxOfficeMoviesFromArray:[RottenTomatoes arrayFromData:data withKey:@"movies"]];
            } else {
                // TODO: Handle bad status code!
            }
        } else {
            // TODO: Handle the error!
        }
    }];
    [dataTask resume];
}

- (void)interpretBoxOfficeMoviesFromArray:(NSArray *)boxOfficeArray
{
    [self.movies removeAllObjects];
    Movie *movie;
    for (NSDictionary *movieData in boxOfficeArray) {
        // TODO: Fix placeholders
        movie = [[Movie alloc] initWithTitle:movieData[@"title"]
                                       sales:@"Placeholder Number"
                                   imagePath:@"Placeholder InagePath"
                                     urlPath:@"Placeholder urlPath"];
        [self.movies addObject:movie];
    }
    [self.tableView reloadData];
    NSLog(@"have data!");
}

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
    //boxOfficeCell.thumbnailImageView.image = [UIImage imageNamed:movie.imagePath];
    return boxOfficeCell;
}

@end
