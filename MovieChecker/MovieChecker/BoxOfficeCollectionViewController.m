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
#import "MovieList.h"

#import "BoxOfficeCollectionCell.h"
#import "BoxOfficeTableCell.h"

// Define DLOG to log to NSLog when DEBUG is defined
#ifdef DEBUG
#define DLOG(...) NSLog(@"%s:%d %@", __PRETTY_FUNCTION__, __LINE__, [NSString stringWithFormat:__VA_ARGS__])
#else
#define DLOG(...) do {} while (NO)
#endif

@interface BoxOfficeCollectionViewController ()

@property (nonatomic, strong) MovieList *movieList;
@property (nonatomic, weak) NSArray *movies;
@property (nonatomic, assign) BOOL isGrid;

@end

@implementation BoxOfficeCollectionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.isGrid = YES;
    self.movieList = [[MovieList alloc] initWithDelegate:self];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"MovieDetailsFromCollection"] || [segue.identifier isEqualToString:@"MovieDetailsFromTable"]) {
        NSIndexPath *path = [self.collectionView indexPathForCell:sender];
        Movie *movie = self.movies[path.row];
        MovieDetailViewController *detailViewController = segue.destinationViewController;
        [detailViewController setMovie:movie];
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
    NSURL *url = [NSURL URLWithString:movie.imagePath];
    if (self.isGrid) {
        BoxOfficeCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([BoxOfficeCollectionCell class])
                                                                                      forIndexPath:indexPath];
        [cell setThumbnailImageFromURL:url];
        return cell;
    } else {
        // TODO: Finish Handling for nongrid
        BoxOfficeTableCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([BoxOfficeTableCell class]) forIndexPath:indexPath];
        [cell setName:movie.name];
        [cell setThumbnailImageFromURL:url];
        return cell;
    }
    
}

#pragma mark <MovieListDelegate>

- (void)synchMoviesWithArray:(NSArray *)movies
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
        return CGSizeMake(320.0f, 44.0f);
    }
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
referenceSizeForHeaderInSection:(NSInteger)section
{
    if (self.isGrid ) {
        return CGSizeZero;
    } else {
        // TODO: Value for nongrid
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
        // TODO: Value for nongrid
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
        return 1.0;
    }
}

- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout *)collectionViewLayout
minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    if (self.isGrid) {
        return 10.0f;
    } else {
        // TODO: Value for nongrid
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
        // TODO: Value for nongrid
        return UIEdgeInsetsZero;
    }
    
}

@end
