//
//  BoxOfficeViewController.m
//  MovieChecker
//
//  Created by Joseph Goldberg on 1/21/15.
//  Copyright (c) 2015 Vokal. All rights reserved.
//

#import "BoxOfficeCell.h"
#import "BoxOfficeViewController.h"
#import "Movie.h"
#import "MovieDetailViewController.h"
#import "RottenTomatoesHelperMethods.h"

// Define DLOG to log to NSLog when DEBUG is defined
#ifdef DEBUG
#define DLOG(...) NSLog(@"%s:%d %@", __PRETTY_FUNCTION__, __LINE__, [NSString stringWithFormat:__VA_ARGS__])
#else
#define DLOG(...) do {} while (NO)
#endif

@interface BoxOfficeViewController ()

@property (nonatomic, strong) NSURLSession *session;
@property (nonatomic, strong) NSArray *movies;

@end

@implementation BoxOfficeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration ephemeralSessionConfiguration];
    self.session = [NSURLSession sessionWithConfiguration:config];
    self.movies = [NSMutableArray array];
    [self loadMoviesFromRottenTomatoes];
}

- (void)loadMoviesFromRottenTomatoes
{
    NSURL *url = [RottenTomatoesHelperMethods boxOfficeURL];
    NSURLSessionDataTask *dataTask = [self.session dataTaskWithURL:url completionHandler:^(NSData *data,
                                                                                           NSURLResponse *response,
                                                                                           NSError *error) {
        if (error) {
            // TODO: Handle the error!
            return;
        }
        NSHTTPURLResponse *httpResp = (NSHTTPURLResponse *)response;
        if (httpResp.statusCode != 200) {
            // TODO: Handle bad status code!
            return;
        }
        self.movies = [RottenTomatoesHelperMethods interpretBoxOfficeMoviesFromData:data withkey:@"movies"];
        [self.tableView reloadData];
    }];
    [dataTask resume];
}

- (void)imageForMovie:(Movie *)movie forCell:(BoxOfficeCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    NSURL *url = [NSURL URLWithString:movie.imagePath];
    NSURLSessionDataTask *downloadImageTask = [[NSURLSession sharedSession]
                                               dataTaskWithURL:url
                                               completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                   if (error) {
                                                       // TODO: Handle the error!
                                                       return;
                                                   }
                                                   NSHTTPURLResponse *httpResp = (NSHTTPURLResponse *)response;
                                                   if (httpResp.statusCode != 200) {
                                                       // TODO: Handle the bad status code!
                                                       return;
                                                   }
                                                   UIImage *downloadedImage = [[UIImage alloc] initWithData:data];
                                                   movie.image = downloadedImage;
                                                   [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                                       [cell setThumbnailImage:movie.image];
                                                   }];
                                               }];
    [downloadImageTask resume];
}

#pragma mark - UITableViewDataSource methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.movies.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BoxOfficeCell *boxOfficeCell = (BoxOfficeCell *)[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([BoxOfficeCell class]) forIndexPath:indexPath];
    Movie *movie = self.movies[indexPath.row];
    [boxOfficeCell setName:movie.name];
    [boxOfficeCell setThumbnailImage:nil];
    [self imageForMovie:movie
                forCell:boxOfficeCell
            atIndexPath:indexPath];
    return boxOfficeCell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"MovieDetails"]) {
        Movie *movie = self.movies[[self.tableView indexPathForSelectedRow].row];
        MovieDetailViewController *detailViewController = segue.destinationViewController;
        [detailViewController setMovie:movie];
    }
    
}

@end
