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
                                       sales:@"Placeholder Number"
                                   imagePath:movieData[@"posters"][@"thumbnail"]
                                     urlPath:movieData[@"links"][@"self"]];
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
                                                                       DLOG(@"Changing Image");
                                                                       cell.thumbnailImageView.image = movie.image;
                                                                       //[cell setNeedsLayout];
                                                                       //[self.tableView beginUpdates];
                                                                       //[self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                                                                       //[self.tableView endUpdates];
                                                                       //[cell reloadInputViews];
                                                                   }
                                                               });
                                                               //[self.tableView reloadData];
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
    DLOG(@"cellForRowAtIndexPath");
    BoxOfficeCell *boxOfficeCell = (BoxOfficeCell *)[tableView dequeueReusableCellWithIdentifier:@"BoxOfficeMovieCell" forIndexPath:indexPath];
    boxOfficeCell.tag = indexPath.row;
    Movie *movie = self.movies[indexPath.row];
    boxOfficeCell.nameLabel.text = movie.name;
    boxOfficeCell.salesLabel.text = movie.sales;
    boxOfficeCell.thumbnailImageView.image = nil;
    [self imageForMovie:movie forCell:boxOfficeCell atIndexPath:indexPath];
        
    
    return boxOfficeCell;
}

@end
