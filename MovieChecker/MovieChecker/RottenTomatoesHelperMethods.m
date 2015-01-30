//
//  RottenTomatoesHelperMethods.m
//  MovieChecker
//
//  Created by Joseph Goldberg on 1/22/15.
//  Copyright (c) 2015 Vokal. All rights reserved.
//

#import "RottenTomatoesHelperMethods.h"

#import "Movie.h"

static NSString *APIKeyString = @"jw64knjg769gnmd2zs35ttz6";
static NSString *BaseURL = @"http://api.rottentomatoes.com/api/public/v1.0/";
static NSString *BoxOfficeURL = @"lists/movies/box_office.json?limit=50";

@interface RottenTomatoesHelperMethods ()

+ (NSArray *)arrayFromData:(NSData *)data withKey:(NSString *)key;
+ (NSArray *)interpretBoxOfficeMoviesFromArray:(NSArray *)boxOfficeArray;

@end

@implementation RottenTomatoesHelperMethods

+ (NSURL *)boxOfficeURL
{
    NSString *url = [[NSString stringWithString:BaseURL]
                     stringByAppendingFormat:@"%@&apikey=%@", BoxOfficeURL, APIKeyString];
    return [NSURL URLWithString:url];
}

+ (NSArray *)interpretBoxOfficeMoviesFromData:(NSData *)data withkey:(NSString *)key;
{
    NSArray *array = [self arrayFromData:data withKey:key];
    return [self interpretBoxOfficeMoviesFromArray:array];
}

+ (NSArray *)arrayFromData:(NSData *)data withKey:(NSString *)key
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

+ (NSArray *)interpretBoxOfficeMoviesFromArray:(NSArray *)boxOfficeArray
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

@end
