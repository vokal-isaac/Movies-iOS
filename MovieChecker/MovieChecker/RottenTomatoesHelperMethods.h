//
//  RottenTomatoesHelperMethods.h
//  MovieChecker
//
//  Created by Joseph Goldberg on 1/22/15.
//  Copyright (c) 2015 Vokal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RottenTomatoesHelperMethods : NSObject

+ (NSURL *)appRootURL;
+ (NSString *)apiKey;
+ (NSURL *)boxOfficeURL;
+ (NSArray *)arrayFromData:(NSData *)data withKey:(NSString *)key;

@end
