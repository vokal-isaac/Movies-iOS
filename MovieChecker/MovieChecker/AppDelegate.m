//
//  AppDelegate.m
//  MovieChecker
//
//  Created by Joseph Goldberg on 1/21/15.
//  Copyright (c) 2015 Vokal. All rights reserved.
//

#import "AppDelegate.h"
#import "Movie.h"
#import "BoxOfficeViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate
{
    NSMutableArray *_movies;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    _movies = [NSMutableArray array];
    
    Movie *movie = [[Movie alloc] init];
    movie.name = @"Example Hit";
    movie.sales = @"$500 Million";
    [_movies addObject:movie];
    
    movie = [[Movie alloc] init];
    movie.name = @"Example Bomb";
    movie.sales = @"$500 Thousand";
    [_movies addObject:movie];
    
    UINavigationController *navigationController = (UINavigationController *)self.window.rootViewController;
    BoxOfficeViewController *boxOfficeViewController = navigationController.viewControllers.firstObject;
    boxOfficeViewController.movies = _movies;
    
    return YES;
}

@end
