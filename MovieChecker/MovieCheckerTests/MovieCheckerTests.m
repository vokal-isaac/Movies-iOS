//
//  MovieCheckerTests.m
//  MovieCheckerTests
//
//  Created by Joseph Goldberg on 1/21/15.
//  Copyright (c) 2015 Vokal. All rights reserved.
//

// Frameworks
#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

// Libraries/CocoaPods
#import <ILGAsserts.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import <VOKMockUrlProtocol.h>

// View Controllers
#import "BoxOfficeCollectionViewController.h"

// Models
#import "Movie.h"
#import "MovieListLoader.h"

// Other

@interface MovieCheckerTests : XCTestCase

@property (nonatomic, strong) NSURLSession *session;

@end

static NSTimeInterval const TimeoutInterval = 10.0;  // 10 seconds
static NSString const *AmericanSniperSynopsis = @"From director Clint Eastwood comes \"American Sniper,\" starring Bradley Cooper as Chris Kyle, the most lethal sniper in U.S. military history. But there was much more to this true American hero than his skill with a rifle. U.S. Navy SEAL sniper Chris Kyle is sent to Iraq with only one mission: to protect his brothers-in-arms. His pinpoint accuracy saves countless lives on the battlefield and, as stories of his courageous exploits spread, he earns the nickname \"Legend.\" However, his reputation is also growing behind enemy lines, putting a price on his head and making him a prime target of insurgents. Despite the danger, as well as the toll on his family at home, Chris serves through four harrowing tours of duty in Iraq, becoming emblematic of the SEAL creed to \"leave no man behind.\" But upon returning home, Chris finds that it is the war he can't leave behind. (C) Warner Bros";
static NSString *BoxOfficeURL = @"http://api.rottentomatoes.com/api/public/v1.0/lists/movies/box_office.json?limit=50&apikey=jw64knjg769gnmd2zs35ttz6";

@implementation MovieCheckerTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration ephemeralSessionConfiguration]];
    Class mockURLProtocol = [VOKMockUrlProtocol class];
    NSMutableArray *currentProtocolClasses = [self.session.configuration.protocolClasses mutableCopy];
    [currentProtocolClasses insertObject:mockURLProtocol atIndex:0];
    self.session.configuration.protocolClasses = [currentProtocolClasses copy];
    
}

- (void)testDownloadBoxOfficeList
{
    

    BOOL __block done = NO;
    BoxOfficeCollectionViewController *vc = [[BoxOfficeCollectionViewController alloc] init];
    MovieListLoader *movieListLoader = [[MovieListLoader alloc] initWithDelegate:vc];
    
    NSURLSessionDataTask *dataTask = [self.session
                                      dataTaskWithURL:[NSURL URLWithString:BoxOfficeURL]
                                      completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                          XCTAssertNil(error, @"Got an error: %@", error);
                                          NSHTTPURLResponse *httpResp = (NSHTTPURLResponse *)response;
                                          XCTAssertEqual(httpResp.statusCode, 200, @"Didn't get the expected 200 status.");
                                          NSArray *movies = [movieListLoader
                                                             interpretBoxOfficeMoviesFromData:data withkey:@"movies"];
                                          XCTAssertEqual(movies.count, 50, @"The wrong number of movies was returned.");
                                          Movie *movie = movies.firstObject;
                                          XCTAssertEqualObjects(movie.name, @"American Sniper", @"The first movie has the wrong name.");
                                          XCTAssertEqualObjects(movie.imagePath,
                                                                @"http://content8.flixster.com/movie/11/18/08/11180834_tmb.jpg",
                                                                @"The first movie has the wrong imagePath.");
                                          XCTAssertEqualObjects(movie.urlPath,
                                                                @"http://api.rottentomatoes.com/api/public/v1.0/movies/771357000.json",
                                                                @"The first movie has the wrong urlPath.");
                                          XCTAssertEqual(movie.runtime, 134, @"The first movie has the wrong value for its runtime.");
                                          XCTAssertEqual(movie.year, 2015, @"The first movie has the wrong release year.");
                                          XCTAssertEqualObjects(movie.rating, @"R", @"The first movie has the wrong MPAA rating.");
                                          XCTAssertEqualObjects(movie.synopsis, AmericanSniperSynopsis, @"The first movie has the wrong synopsis.");
                                          movie = movies.lastObject;
                                          XCTAssertEqualObjects(movie.name, @"Citizenfour", @"The last movie has the wrong name.");
                                          done = YES;
                                      }];
    [dataTask resume];
    
    ILGAssertBlockReturnsYesBeforeTimeout(^{ return done; },
                                          TimeoutInterval,
                                          @"Call failed to return quickly enough.");
}
// Commented out because test inconsistently succeeds or fails.  When it fails, the error says that the image has 0 pixels.
//- (void)testImageDownload
//{
//    BOOL __block done = NO;
//    
//    NSURL *url = [NSURL URLWithString:@"http://content8.flixster.com/movie/11/18/08/11180834_tmb.jpg"];
//    UIImageView *imageview = [[UIImageView alloc] init];
//    [[SDImageCache sharedImageCache] clearDisk];
//    [[SDImageCache sharedImageCache] clearMemory];
//    
//    [imageview sd_setImageWithURL:url completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//        XCTAssertNil(error, @"Got an error: %@", error);
//        XCTAssertEqual(cacheType, SDImageCacheTypeNone, @"Image was already in cache, and was not downloaded.");
//        done = YES;
//    }];
//    
//    ILGAssertBlockReturnsYesBeforeTimeout(^{ return done; },
//                                          TimeoutInterval,
//                                          @"Call failed to return quickly enough.");
//}

@end
