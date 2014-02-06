//
//  TimelineVC.m
//  twitter
//
//  Created by Timothy Lee on 8/4/13.
//  Copyright (c) 2013 codepath. All rights reserved.
//

#import "TimelineVC.h"

#import "TweetCell.h"
#import "TweetViewController.h"
#import "WriteTweetViewController.h"

#import <AFNetworking/UIImageView+AFNetworking.h>

#define SECONDS_IN_DAY 86400
#define SECONDS_IN_HOUR 3600

@interface TimelineVC ()

@property (nonatomic, strong) NSMutableArray *tweets;

- (void)onSignOutButton;
- (void)reload;

@end

@implementation TimelineVC

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.title = @"Twitter";
        [self setup];
        [self reload];
    }
    return self;
}

- (void)setup {
    UINib *nib = [UINib nibWithNibName:@"TweetCell" bundle:Nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"TweetCell"];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //set up navigation bar items
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Sign Out" style:UIBarButtonItemStylePlain target:self action:@selector(onSignOutButton)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor colorWithWhite:1.0 alpha:1.0];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"New" style:UIBarButtonItemStylePlain target:self action:@selector(onNewButton)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor colorWithWhite:1.0 alpha:1.0];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    //self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (CGFloat)rowHeightForString:(NSString *)string {
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue" size:12]};
    CGRect sizeRect = [string boundingRectWithSize:CGSizeMake(212.0f, CGFLOAT_MAX) options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading) attributes:attributes context:nil];
    
    return sizeRect.size.height + 100;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    Tweet *tweet = self.tweets[indexPath.row];
    return [self rowHeightForString:tweet.text] - ([tweet isRetweet] ? 0 : 18);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tweets.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"TweetCell";
    TweetCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    Tweet *tweet = self.tweets[indexPath.row];
    cell.tweetLabel.text = tweet.text;
    
    //set up user text
    NSMutableAttributedString *userName = [[NSMutableAttributedString alloc] initWithString:
                                           [NSString stringWithFormat:@"%@  %@", tweet.userName, tweet.userHandle]];
    [userName addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:12.0] range:NSMakeRange(0, tweet.userName.length)];
    [userName addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HelveticaNeue-Light" size:12.0] range:NSMakeRange(tweet.userName.length+1, tweet.userHandle.length+1)];
    
    cell.userName.attributedText = userName;
    cell.tweetID = [tweet tweetID];
    
    //if favorited then light up button
    [cell setFavoriteButtonState:[tweet favorited]];
    
    //hide retweet stuff if it is not a retweet
    if (![tweet isRetweet]){
        cell.retweetImage.hidden = YES;
        cell.retweetLabel.hidden = YES;
        cell.retweetIconHeightConstraint.constant = 0;
        cell.retweetNameHeightConstraint.constant = 0;
    }
    
    //populate user image
    [cell.tweeterImage setImageWithURL:[NSURL URLWithString:tweet.tweeterImage]];
    
    //populate time
    double timeSinceTweet = -[tweet.timeStamp timeIntervalSinceNow];
    cell.timeLabel.text = [self timeSinceStringFromDuration:timeSinceTweet];
    
    return cell;
}

-(NSString *)timeSinceStringFromDuration:(double)duration {
    if (duration >= SECONDS_IN_DAY){
        NSInteger numDays = round(duration/SECONDS_IN_DAY);
        return [NSString stringWithFormat:@"%dd", numDays];
    }
    else if (duration >= SECONDS_IN_HOUR) {
        NSInteger numHours = round(duration/SECONDS_IN_HOUR);
        return [NSString stringWithFormat:@"%dh", numHours];
    }
    else {
        NSInteger numMinutes = round(duration/60.0);
        return [NSString stringWithFormat:@"%dm", numMinutes];
    }
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    Tweet *tweet = self.tweets[indexPath.row];
    [self.navigationController pushViewController:[[TweetViewController alloc] initWithTweet:tweet] animated:YES];
}

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

#pragma mark - Private methods

- (void)onSignOutButton {
    [User setCurrentUser:nil];
}

- (void)onNewButton {
    [self.navigationController pushViewController:[[WriteTweetViewController alloc] init] animated:YES];
}

- (void)reload {
    [[TwitterClient instance] homeTimelineWithCount:20 sinceId:0 maxId:0 success:^(AFHTTPRequestOperation *operation, id response) {
        NSLog(@"%@", response);
        self.tweets = [Tweet tweetsWithArray:response];
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // Do nothing
    }];
}

@end
