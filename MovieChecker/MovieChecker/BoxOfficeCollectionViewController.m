//
//  BoxOfficeCollectionViewController.m
//  MovieChecker
//
//  Created by Joseph Goldberg on 1/27/15.
//  Copyright (c) 2015 Vokal. All rights reserved.
//

#import "BoxOfficeCollectionViewCell.h"
#import "BoxOfficeCollectionViewController.h"
#import "Movie.h"
#import "MovieDetailViewController.h"
#import "MovieList.h"

@interface BoxOfficeCollectionViewController ()

@property (nonatomic, strong) MovieList *movieList;
@property (nonatomic, weak) NSArray *movies;

@end

@implementation BoxOfficeCollectionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.movieList = [[MovieList alloc] initWithDelegate:self];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"MovieDetails"]) {
        NSIndexPath *path = [self.collectionView indexPathForCell:sender];
        Movie *movie = self.movies[path.row];
        MovieDetailViewController *detailViewController = segue.destinationViewController;
        [detailViewController setMovie:movie];
    }
    
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSLog(@"Returning itemcount");
    return self.movies.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BoxOfficeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([BoxOfficeCollectionViewCell class])
                                                                                  forIndexPath:indexPath];
    Movie *movie = self.movies[indexPath.row];
    NSURL *url = [NSURL URLWithString:movie.imagePath];
    [cell setThumbnailImageFromURL:url];
    return cell;
}

#pragma mark <MovieListDelegate>

- (void)synchMoviesWithArray:(NSArray *)movies
{
    self.movies = movies;
    [self.collectionView reloadData];
}

@end
