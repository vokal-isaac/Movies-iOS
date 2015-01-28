//
//  MovieList.m
//  MovieChecker
//
//  Created by Joseph Goldberg on 1/27/15.
//  Copyright (c) 2015 Vokal. All rights reserved.
//

#import "MovieList.h"
#import "RottenTomatoesHelperMethods.h"
#import "Movie.h"

@interface MovieList ()

@property (nonatomic, strong) NSURLSession *session;

@end

@implementation MovieList

- (void)interpretBoxOfficeMoviesFromArray:(NSArray *)boxOfficeArray
{
    [self.movies removeAllObjects];
    Movie *movie;
    NSLog(@"Beginning Loop");

    for (NSDictionary *movieData in boxOfficeArray) {
        movie = [[Movie alloc] initWithTitle:movieData[@"title"]
                                   imagePath:movieData[@"posters"][@"thumbnail"]
                                     urlPath:movieData[@"links"][@"self"]];
        movie.rating = movieData[@"mpaa_rating"];
        movie.synopsis = movieData[@"synopsis"];
        movie.year = [movieData[@"year"] intValue];
        movie.runtime = [movieData[@"runtime"] intValue];
        //[self downloadImageForMovie:movie];
        NSLog(@"Adding movie to model");

        [self.movies addObject:movie];
    }
    NSLog(@"Messaging Delegate");

    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [self.delegate synchMoviesWithArray:self.movies];
    }];
}

- (void)fetchMovies
{
    NSURL *url = [RottenTomatoesHelperMethods boxOfficeURL];
    NSLog(@"Starting NSURLSession");
    NSURLSessionDataTask *dataTask = [self.session dataTaskWithURL:url completionHandler:^(NSData *data,
                                                                                           NSURLResponse *response,
                                                                                           NSError *error) {
        NSLog(@"Received response");
        if (!error) {
            NSHTTPURLResponse *httpResp = (NSHTTPURLResponse *)response;
            if (httpResp.statusCode == 200) {
                NSLog(@"Calling Interpreter");
                [self interpretBoxOfficeMoviesFromArray:[RottenTomatoesHelperMethods arrayFromData:data withKey:@"movies"]];
            } else {
                // TODO: Handle bad status code!
            }
        } else {
            // TODO: Handle the error!
        }
    }];
    [dataTask resume];
}

- (void)downloadImageForMovie:(Movie *)movie
{
    NSURL *url = [NSURL URLWithString:movie.imagePath];
    NSURLSessionDataTask *downloadImageTask = [[NSURLSession sharedSession]
                                               dataTaskWithURL:url
                                               completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                   if (!error) {
                                                       NSHTTPURLResponse *httpResp = (NSHTTPURLResponse *)response;
                                                       if (httpResp.statusCode == 200) {
                                                           UIImage *downloadedImage = [[UIImage alloc] initWithData:data];
                                                           movie.image = downloadedImage;
                                                       } else {
                                                           // TODO: Handle the bad status code!
                                                       }
                                                   } else {
                                                       // TODO: Handle the error!
                                                   }
                                               }];
    [downloadImageTask resume];
}

- (id)initWithDelegate:(id)delegate
{
    self = [super init];
    if (self) {
        self.delegate = delegate;
        self.movies = [NSMutableArray array];
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration ephemeralSessionConfiguration];
        self.session = [NSURLSession sessionWithConfiguration:config];
        [self fetchMovies];
    }
    return self;
}

@end
