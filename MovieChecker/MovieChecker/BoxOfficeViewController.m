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
#import "MovieDetailViewController.h"
// Define DLOG to log to NSLog when DEBUG is defined
#ifdef DEBUG
#define DLOG(...) NSLog(@"%s:%d %@", __PRETTY_FUNCTION__, __LINE__, [NSString stringWithFormat:__VA_ARGS__])
#else
#define DLOG(...) do {} while (NO)
#endif

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
                                   imagePath:movieData[@"posters"][@"thumbnail"]
                                     urlPath:movieData[@"links"][@"self"]];
        movie.rating = movieData[@"mpaa_rating"];
        movie.synopsis = movieData[@"synopsis"];
        movie.year = [movieData[@"year"] intValue];
        movie.runtime = [movieData[@"runtime"] intValue];
        [self.movies addObject:movie];
    }
    [self.tableView reloadData];
}

- (void)imageForMovie:(Movie *)movie forCell:(BoxOfficeCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    NSURL *url = [NSURL URLWithString:movie.imagePath];
    NSURLSessionDataTask *downloadImageTask = [[NSURLSession sharedSession]
                                                   dataTaskWithURL:url
                                                   completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                       if (!error) {
                                                           NSHTTPURLResponse *httpResp = (NSHTTPURLResponse *)response;
                                                           if (httpResp.statusCode == 200) {
                                                               UIImage *downloadedImage = [[UIImage alloc] initWithData:data];
                                                               //DLOG(@"");
                                                               movie.image = downloadedImage;
                                                               dispatch_async(dispatch_get_main_queue(), ^{
                                                                   if (cell.tag == indexPath.row) {
                                                                       cell.thumbnailImageView.image = movie.image;
                                                                   }
                                                               });
                                                           } else {
                                                               // TODO: Handle the bad status code!
                                                           }
                                                       } else {
                                                           // TODO: Handle the error!
                                                       }
                                                   }];
    [downloadImageTask resume];
}

#pragma mark - UITableViewDataSource methods

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
    // TODO: Fix Image Loading to not be laggy.
    BoxOfficeCell *boxOfficeCell = (BoxOfficeCell *)[tableView dequeueReusableCellWithIdentifier:@"BoxOfficeMovieCell" forIndexPath:indexPath];
    boxOfficeCell.tag = indexPath.row;
    Movie *movie = self.movies[indexPath.row];
    boxOfficeCell.nameLabel.text = movie.name;
    boxOfficeCell.thumbnailImageView.image = nil;
    [self imageForMovie:movie forCell:boxOfficeCell atIndexPath:indexPath];
        
    
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
