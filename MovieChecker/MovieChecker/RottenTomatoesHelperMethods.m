//
//  RottenTomatoesHelperMethods.m
//  MovieChecker
//
//  Created by Joseph Goldberg on 1/22/15.
//  Copyright (c) 2015 Vokal. All rights reserved.
//

#import "RottenTomatoesHelperMethods.h"

static NSString *APIKeyString = @"jw64knjg769gnmd2zs35ttz6";
static NSString *BaseURL = @"http://api.rottentomatoes.com/api/public/v1.0/";
static NSString *BoxOfficeURL = @"lists/movies/box_office.json?limit=50";

@implementation RottenTomatoesHelperMethods

+ (NSURL *)boxOfficeURL
{
//    NSURL *url = [NSURL URLWithString:BoxOfficeURL relativeToURL:[NSURL URLWithString:BaseURL]];
//    url = [NSURL URLWithString:@"&apikey=" relativeToURL:url];
//    url = [NSURL URLWithString:APIKeyString relativeToURL:url];
//    NSLog(@"URL=%@", url);
//    return url;
    NSString *url = [[NSString stringWithString:BaseURL] stringByAppendingFormat:@"%@&apikey=%@", BoxOfficeURL, APIKeyString];
    return [NSURL URLWithString:url];
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

@end
