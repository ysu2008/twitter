//
//  TweetCell.h
//  twitter
//
//  Created by Timothy Lee on 8/6/13.
//  Copyright (c) 2013 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TweetCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *tweetLabel;
@property (strong, nonatomic) IBOutlet UILabel *retweetLabel;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UIImageView *tweeterImage;
@property (strong, nonatomic) IBOutlet UILabel *userName;
@property (strong, nonatomic) IBOutlet UIImageView *retweetImage;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *retweetIconHeightConstraint;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *retweetNameHeightConstraint;
@property (assign, nonatomic) long long tweetID;

- (IBAction)didTapReplyButton:(id)sender;
- (IBAction)didTapRetweetButton:(id)sender;
- (IBAction)didTapFavoriteButton:(id)sender;
- (void)setFavoriteButtonState:(BOOL)favorited;
- (void)setRetweetButtonState:(BOOL)retweeted;

@end
