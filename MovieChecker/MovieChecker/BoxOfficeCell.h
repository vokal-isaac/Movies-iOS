//
//  BoxOfficeCell.h
//  MovieChecker
//
//  Created by Joseph Goldberg on 1/22/15.
//  Copyright (c) 2015 Vokal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BoxOfficeCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *salesLabel;
@property (nonatomic, weak) IBOutlet UIImageView *thumbnailImageView;

@end
