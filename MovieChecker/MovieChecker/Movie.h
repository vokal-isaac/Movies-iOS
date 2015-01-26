//
//  Movie.h
//  MovieChecker
//
//  Created by Joseph Goldberg on 1/22/15.
//  Copyright (c) 2015 Vokal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Movie : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *sales;
@property (nonatomic, copy) NSString *imagePath;
@property (nonatomic, copy) NSString *urlPath;
@property (nonatomic, assign) BOOL imageLoaded;

- (Movie *)initWithTitle:(NSString *)name sales:(NSString *)sales imagePath:(NSString *)imagePath urlPath:(NSString *)urlPath;

@end
