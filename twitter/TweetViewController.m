//
//  TweetViewController.m
//  twitter
//
//  Created by Yang Su on 2/5/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "TweetViewController.h"

#import "Tweet.h"
#import <AFNetworking/UIImageView+AFNetworking.h>

@interface TweetViewController ()
@property (nonatomic, readwrite, strong) Tweet *tweet;
@property (strong, nonatomic) IBOutlet UIImageView *userImage;
@property (strong, nonatomic) IBOutlet UIImageView *retweetIcon;
@property (strong, nonatomic) IBOutlet UILabel *retweetMessage;
@property (strong, nonatomic) IBOutlet UILabel *userName;
@property (strong, nonatomic) IBOutlet UILabel *userHandle;
@property (strong, nonatomic) IBOutlet UILabel *tweetLabel;
@property (strong, nonatomic) IBOutlet UILabel *timeStampLabel;
@property (strong, nonatomic) IBOutlet UILabel *retweetNumberLabel;
@property (strong, nonatomic) IBOutlet UILabel *favoriteNumberLabel;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *retweetIconHeightConstraint;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *retweetMessageHeightConstraint;


- (IBAction)didTapReplyButton:(id)sender;
- (IBAction)didTapRetweetButton:(id)sender;
- (IBAction)didTapFavoriteButton:(id)sender;

@end

@implementation TweetViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithTweet:(Tweet *)tweet {
    if (self = [super initWithNibName:@"TweetViewController" bundle:nil]){
        _tweet = tweet;
        self.title = @"Tweet";
    }
    return self;
}

- (void)setupView {
    self.tweetLabel.text = self.tweet.text;
    self.userName.text = self.tweet.userName;
    self.userHandle.text = self.tweet.userHandle;
    if (![self.tweet isRetweet]){
        self.retweetIcon.hidden = YES;
        self.retweetMessage.hidden = YES;
        self.retweetIconHeightConstraint.constant = 0;
        self.retweetMessageHeightConstraint.constant = 0;
    }
    self.retweetNumberLabel.text = [self.tweet.retweetCount stringValue];
    self.favoriteNumberLabel.text = [self.tweet.favoriteCount stringValue];
    
    //populate user image
    [self.userImage setImageWithURL:[NSURL URLWithString:self.tweet.tweeterImage]];
    
    //set up time
    NSString *dateString = [NSDateFormatter localizedStringFromDate:self.tweet.timeStamp dateStyle:NSDateFormatterLongStyle timeStyle:NSDateFormatterLongStyle];
    self.timeStampLabel.text = dateString;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setupView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)didTapReplyButton:(id)sender {
}

- (IBAction)didTapRetweetButton:(id)sender {
}

- (IBAction)didTapFavoriteButton:(id)sender {
}
@end
