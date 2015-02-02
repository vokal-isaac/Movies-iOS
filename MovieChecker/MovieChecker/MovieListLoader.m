//
//  MovieListLoader.m
//  MovieChecker
//
//  Created by Joseph Goldberg on 1/27/15.
//  Copyright (c) 2015 Vokal. All rights reserved.
//

#import "MovieListLoader.h"

#import "Movie.h"

#import "RottenTomatoesHelperMethods.h"

@interface MovieListLoader ()

@property (nonatomic, strong) NSURLSession *session;

@end

@implementation MovieListLoader

- (void)fetchMovies
{
    NSURL *url = [RottenTomatoesHelperMethods boxOfficeURL];
    NSURLSessionDataTask *dataTask = [self.session
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
                                          self.movies = [RottenTomatoesHelperMethods interpretBoxOfficeMoviesFromData:data
                                                                                                withkey:@"movies"];
                                          [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                              [self.delegate movieListLoader:self didLoadMovies:self.movies];
                                          }];
                                      }];
    [dataTask resume];
}

- (void)downloadImageForMovie:(Movie *)movie
{
    NSURL *url = [NSURL URLWithString:movie.imagePath];
    NSURLSessionDataTask *downloadImageTask = [[NSURLSession sharedSession]
                                               dataTaskWithURL:url
                                               completionHandler:^(NSData *data,
                                                                   NSURLResponse *response,
                                                                   NSError *error) {
                                                   if (error) {
                                                       // TODO: Handle the error!
                                                       return;
                                                   }
                                                   NSHTTPURLResponse *httpResp = (NSHTTPURLResponse *)response;
                                                   if (httpResp.statusCode != 200) {
                                                       // TODO: Handle the bad status code!
                                                       return;
                                                   }
                                                   movie.image = [[UIImage alloc] initWithData:data];
                                               }];
    [downloadImageTask resume];
}

- (id)initWithDelegate:(id)delegate
{
    self = [super init];
    if (self) {
        _delegate = delegate;
        _movies = [NSMutableArray array];
        _session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration ephemeralSessionConfiguration]];
        [self fetchMovies];
    }
    return self;
}

@end
