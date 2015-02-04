//
//  MovieListLoader.m
//  MovieChecker
//
//  Created by Joseph Goldberg on 1/27/15.
//  Copyright (c) 2015 Vokal. All rights reserved.
//

#import "MovieListLoader.h"

#import "Movie.h"

#import <ILGHttpConstants/HTTPStatusCodes.h>


static NSString *BoxOfficeURL = @"http://api.rottentomatoes.com/api/public/v1.0/lists/movies/box_office.json?limit=50&apikey=jw64knjg769gnmd2zs35ttz6";

@interface MovieListLoader ()

@property (nonatomic, strong) NSURLSession *session;

@end

@implementation MovieListLoader

- (NSArray *)interpretBoxOfficeMoviesFromData:(NSData *)data withkey:(NSString *)key;
{
    NSArray *array = [self arrayFromData:data withKey:key];
    return [self interpretBoxOfficeMoviesFromArray:array];
}

- (NSArray *)arrayFromData:(NSData *)data withKey:(NSString *)key
{
    NSError *jsonError;
    NSDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:data
                                                             options:NSJSONReadingAllowFragments
                                                               error:&jsonError];
    if (!jsonData) {
        // TODO: Handle error by examining jsonError.
        return nil;
    }
    return jsonData[key];
}

- (NSArray *)interpretBoxOfficeMoviesFromArray:(NSArray *)boxOfficeArray
{
    NSMutableArray *movies = [NSMutableArray array];
    Movie *movie;
    for (NSDictionary *movieData in boxOfficeArray) {
        movie = [[Movie alloc] initWithTitle:movieData[@"title"]
                                   imagePath:movieData[@"posters"][@"thumbnail"]
                                     urlPath:movieData[@"links"][@"self"]];
        movie.rating = movieData[@"mpaa_rating"];
        movie.synopsis = movieData[@"synopsis"];
        movie.year = [movieData[@"year"] intValue];
        movie.runtime = [movieData[@"runtime"] intValue];
        [movies addObject:movie];
    }
    return movies;
}

- (void)fetchMovies
{
    NSURL *url = [NSURL URLWithString:BoxOfficeURL];
    typeof(self) __weak weakSelf = self;
    [[self.session
     dataTaskWithURL:url
     completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
         if (error) {
             // TODO: Handle the error!
             return;
         }
         NSHTTPURLResponse *httpResp = (NSHTTPURLResponse *)response;
         if (httpResp.statusCode != kHTTPStatusCodeOK) {
             // TODO: Handle the bad status code!
             return;
         }
         weakSelf.movies = [self interpretBoxOfficeMoviesFromData:data
                                                          withkey:@"movies"];
         [[NSOperationQueue mainQueue] addOperationWithBlock:^{
             [weakSelf.delegate movieListLoader:weakSelf didLoadMovies:weakSelf.movies];
         }];
     }] resume];
}

- (void)downloadImageForMovie:(Movie *)movie
{
    NSURL *url = [NSURL URLWithString:movie.imagePath];
    [[[NSURLSession sharedSession]
      dataTaskWithURL:url
      completionHandler:^(NSData *data,
                          NSURLResponse *response,
                          NSError *error) {
          if (error) {
              // TODO: Handle the error!
              return;
          }
          NSHTTPURLResponse *httpResp = (NSHTTPURLResponse *)response;
          if (httpResp.statusCode != kHTTPStatusCodeOK) {
              // TODO: Handle the bad status code!
              return;
          }
          movie.image = [[UIImage alloc] initWithData:data];
      }] resume];
}

- (id)initWithDelegate:(id)delegate
{
    self = [super init];
    if (self) {
        _delegate = delegate;
        _session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration ephemeralSessionConfiguration]];
    }
    return self;
}

@end
