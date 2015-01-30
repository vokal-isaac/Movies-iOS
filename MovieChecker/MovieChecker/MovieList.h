//
//  MovieList.h
//  MovieChecker
//
//  Created by Joseph Goldberg on 1/27/15.
//  Copyright (c) 2015 Vokal. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MovieListDelegate <NSObject>

- (void)synchMoviesWithArray:(NSArray *)movies;

@end

@interface MovieList : NSObject

@property (nonatomic, strong) NSArray *movies;
@property (nonatomic, weak) id <MovieListDelegate> delegate;

- (id)initWithDelegate:(id)delegate;

@end
