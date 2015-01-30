//
//  Movie.m
//  MovieChecker
//
//  Created by Joseph Goldberg on 1/22/15.
//  Copyright (c) 2015 Vokal. All rights reserved.
//

#import "Movie.h"

@implementation Movie

- (Movie *)initWithTitle:(NSString *)name
               imagePath:(NSString *)imagePath
                 urlPath:(NSString *)urlPath;
{
    self = [super init];
    if (self) {
        self.name = name;
        self.imagePath = imagePath;
        self.urlPath = urlPath;
    }
    return self;
}

@end
