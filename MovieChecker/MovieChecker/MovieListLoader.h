//
//  MovieListLoader.h
//  MovieChecker
//
//  Created by Joseph Goldberg on 1/27/15.
//  Copyright (c) 2015 Vokal. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MovieListLoader;

@protocol MovieListDelegate <NSObject>

- (void)movieListLoader:(MovieListLoader *)movieListLoader didLoadMovies:(NSArray *)movies;

@end

@interface MovieListLoader : NSObject


@property (nonatomic, strong) NSArray *movies;
@property (nonatomic, weak) id <MovieListDelegate> delegate;

- (NSArray *)interpretBoxOfficeMoviesFromData:(NSData *)data withkey:(NSString *)key;
- (id)initWithDelegate:(id)delegate;
- (void)fetchMovies;

@end
