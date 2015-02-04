//
//  MovieDetailViewController.m
//  MovieChecker
//
//  Created by Joseph Goldberg on 1/22/15.
//  Copyright (c) 2015 Vokal. All rights reserved.
//

#import "MovieDetailViewController.h"

@interface MovieDetailViewController ()

@property (nonatomic, weak) IBOutlet UILabel *movieTitleLabel;
@property (nonatomic, weak) IBOutlet UILabel *ratingLabel;
@property (nonatomic, weak) IBOutlet UILabel *synopsisLabel;
@property (nonatomic, weak) IBOutlet UILabel *yearLabel;
@property (nonatomic, weak) IBOutlet UITableViewCell *detailCell;

@end

@implementation MovieDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = self.movie.name;
    self.movieTitleLabel.text = self.movie.name;
    self.yearLabel.text = [@(self.movie.year) description];
    self.ratingLabel.text = self.movie.rating;
    self.synopsisLabel.numberOfLines = 0;
    self.synopsisLabel.text = self.movie.synopsis;
    [self.synopsisLabel sizeToFit];
    [self.detailCell sizeToFit];
    
    
}

 - (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UIFont *font = [UIFont fontWithName:@"HelveticaNeue" size:17];
    if (indexPath.section == 1) {
        NSString *str = self.movie.synopsis;
        CGSize maximumSize = CGSizeMake(300, MAXFLOAT);
        CGRect strSize = [str boundingRectWithSize:maximumSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
        
        return (ceil(strSize.size.height)+20);
    } else {
        return [super tableView:tableView heightForRowAtIndexPath:indexPath];
    }
}

@end
