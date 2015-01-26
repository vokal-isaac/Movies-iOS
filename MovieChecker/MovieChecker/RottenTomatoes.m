//
//  RottenTomatoes.m
//  MovieChecker
//
//  Created by Joseph Goldberg on 1/22/15.
//  Copyright (c) 2015 Vokal. All rights reserved.
//

#import "RottenTomatoes.h"

static NSString *apiKey = @"jw64knjg769gnmd2zs35ttz6";
static NSString *homeUrlRoot = @"http://api.rottentomatoes.com/api/public/v1.0.json?apikey=";
static NSString *baseURL = @"http://api.rottentomatoes.com/api/public/v1.0/";
static NSString *boxOfficeURL = @"lists/movies/box_office.json?limit=30";

@implementation RottenTomatoes

+ (NSURL *)appRootURL
{
    NSString *url = [[NSString stringWithString:homeUrlRoot] stringByAppendingString:apiKey];
    return [NSURL URLWithString:url];
}

+ (NSURL *)boxOfficeURL
{
    // TODO: Does this need to be cleaned up?
    NSString *url = [[NSString stringWithString:baseURL] stringByAppendingFormat:@"%@&apikey=%@", boxOfficeURL,apiKey];
    return [NSURL URLWithString:url];
}

+ (NSString *)apiKey
{
    return apiKey;
}

+ (NSArray *)arrayFromData:(NSData *)data withKey:(NSString *)key
{
    NSError *jsonError;
    NSDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:data
                                                             options:NSJSONReadingAllowFragments
                                                               error:&jsonError];
    if (!jsonError) {
        return jsonData[key];
    } else {
        // TODO: Handle error!
        return nil;
    }
}

@end
