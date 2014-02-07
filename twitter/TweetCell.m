//
//  TweetCell.m
//  twitter
//
//  Created by Timothy Lee on 8/6/13.
//  Copyright (c) 2013 codepath. All rights reserved.
//

#import "TweetCell.h"

#import "TwitterClient.h"

@interface TweetCell()
@property (strong, nonatomic) IBOutlet UIButton *favoriteButton;
@property (strong, nonatomic) IBOutlet UIButton *retweetButton;
@property (assign, nonatomic) BOOL isFavorited;
@property (assign, nonatomic) BOOL isRetweeted;

@end


@implementation TweetCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setFavoriteButtonState:(BOOL)favorited {
    self.isFavorited = favorited;
    if (favorited){
        [self.favoriteButton setImage:[UIImage imageNamed:@"favorite_on"] forState:UIControlStateNormal];
    }
    else {
        [self.favoriteButton setImage:[UIImage imageNamed:@"favorite"] forState:UIControlStateNormal];
    }
}

- (void)setRetweetButtonState:(BOOL)retweeted {
    self.isRetweeted = retweeted;
    if (retweeted){
        [self.retweetButton setImage:[UIImage imageNamed:@"retweet_on"] forState:UIControlStateNormal];
    }
    else {
        [self.retweetButton setImage:[UIImage imageNamed:@"retweet"] forState:UIControlStateNormal];
    }
}

- (IBAction)didTapReplyButton:(id)sender {
}

- (IBAction)didTapRetweetButton:(id)sender {
    if (self.isRetweeted){
        [self setRetweetButtonState:NO];
        [[TwitterClient instance] deleteTweetWithIdentifier:self.tweetID
                                                success:^(AFHTTPRequestOperation *operation, id response) {
                                                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                }];
    }
    else {
        [self setRetweetButtonState:YES];
        [[TwitterClient instance] retweetWithIdentifier:self.tweetID
                                                success:^(AFHTTPRequestOperation *operation, id response) {
                                                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                }];
    }
}

- (IBAction)didTapFavoriteButton:(id)sender {
    if (self.isFavorited){
        [self setFavoriteButtonState:NO];
        [[TwitterClient instance] destroyFavoriteTweetWithIdentifier:self.tweetID
                                                      success:^(AFHTTPRequestOperation *operation, id response) {
                                                      } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                      }];
    }
    else {
        [self setFavoriteButtonState:YES];
        [[TwitterClient instance] favoriteTweetWithIdentifier:self.tweetID
                                                      success:^(AFHTTPRequestOperation *operation, id response) {
                                                      } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                      }];
    }
}

@end
