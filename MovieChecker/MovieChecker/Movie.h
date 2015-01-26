//
//  Movie.h
//  MovieChecker
//
//  Created by Joseph Goldberg on 1/22/15.
//  Copyright (c) 2015 Vokal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Movie : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *sales;
@property (nonatomic, strong) NSString *imagePath;
@property (nonatomic, strong) NSString *urlPath;
@property (nonatomic, assign) BOOL imageLoaded;
@property (nonatomic, strong) UIImage *image;

- (Movie *)initWithTitle:(NSString *)name sales:(NSString *)sales imagePath:(NSString *)imagePath urlPath:(NSString *)urlPath;

@end
