//
//  BoxOfficeCollectionViewController.m
//  MovieChecker
//
//  Created by Joseph Goldberg on 1/27/15.
//  Copyright (c) 2015 Vokal. All rights reserved.
//

#import "BoxOfficeCollectionViewController.h"

#import "MovieDetailViewController.h"

#import "Movie.h"
#import "MovieListLoader.h"

#import "BoxOfficeCollectionCell.h"
#import "BoxOfficeTableCell.h"

// Define DLOG to log to NSLog when DEBUG is defined
#ifdef DEBUG
#define DLOG(...) NSLog(@"%s:%d %@", __PRETTY_FUNCTION__, __LINE__, [NSString stringWithFormat:__VA_ARGS__])
#else
#define DLOG(...) do {} while (NO)
#endif

@interface BoxOfficeCollectionViewController ()

@property (nonatomic, strong) MovieListLoader *movieListLoader;
@property (nonatomic, weak) NSArray *movies;
@property (nonatomic, assign) BOOL isGrid;

@end

@implementation BoxOfficeCollectionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.isGrid = YES;
    self.collectionView.backgroundColor = [UIColor grayColor];
    self.collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    self.movieListLoader = [[MovieListLoader alloc] initWithDelegate:self];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"MovieDetailsFromCollection"] || [segue.identifier isEqualToString:@"MovieDetailsFromTable"]) {
        NSIndexPath *path = [self.collectionView indexPathForCell:sender];
        Movie *movie = self.movies[path.row];
        MovieDetailViewController *detailViewController = segue.destinationViewController;
        detailViewController.movie = movie;
    }
    
}

#pragma mark - Flow Navigation Presets

- (IBAction)toggleLayout:(UIBarButtonItem *)sender
{
    self.isGrid = !self.isGrid;
    [self.collectionView reloadData];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.movies.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    Movie *movie = self.movies[indexPath.row];
    if (self.isGrid) {
        BoxOfficeCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([BoxOfficeCollectionCell class])
                                                                                  forIndexPath:indexPath];
        [cell displayMovie:movie];
        return cell;
    } else {
        BoxOfficeTableCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([BoxOfficeTableCell class]) forIndexPath:indexPath];
        cell.backgroundColor = [UIColor whiteColor];
        [cell displayMovie:movie];
        return cell;
    }
    
}

#pragma mark <MovieListDelegate>

- (void)movieListLoader:(id<MovieListDelegate> *)movieListLoader didLoadMovies:(NSArray *)movies;
{
    self.movies = movies;
    [self.collectionView reloadData];
}

#pragma mark <UICollectionViewDelegateFlowLayout>

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.isGrid) {
        
        return CGSizeMake(54.0f, 80.0f);
    } else {
        return CGSizeMake(320.0f, 100.0f);
    }
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
referenceSizeForHeaderInSection:(NSInteger)section
{
    if (self.isGrid ) {
        return CGSizeZero;
    } else {
        return CGSizeZero;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
referenceSizeForFooterInSection:(NSInteger)section
{
    if (self.isGrid ) {
        return CGSizeZero;
    } else {
        return CGSizeZero;
    }
}

- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout *)collectionViewLayout
minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    if (self.isGrid) {
        return 10.0f;
    } else {
        return 1.0f;
    }
}

- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout *)collectionViewLayout
minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    if (self.isGrid) {
        return 10.0f;
    } else {
        return 0.0;
    }
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView
                        layout:(UICollectionViewLayout *)collectionViewLayout
        insetForSectionAtIndex:(NSInteger)section
{
    if (self.isGrid) {
        return UIEdgeInsetsMake(7.0f, 7.0f, 7.0f, 7.0f);
    } else {
        return UIEdgeInsetsZero;
    }
    
}

@end
