//
//  WriteTweetViewController.m
//  twitter
//
//  Created by Yang Su on 2/6/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "WriteTweetViewController.h"

#import <AFNetworking/UIImageView+AFNetworking.h>

@interface WriteTweetViewController ()
@property (strong, nonatomic) IBOutlet UITextView *composeTextField;
@property (strong, nonatomic) IBOutlet UIImageView *UserImage;
@property (strong, nonatomic) IBOutlet UILabel *userName;
@property (strong, nonatomic) IBOutlet UILabel *userHandle;
@property (strong, nonatomic, readwrite) id<WriteTweetVCDelegate> delegate;
@property (strong, nonatomic, readwrite) UILabel *numCharsLeftLabel;
@property (assign, nonatomic, readwrite) int numCharsLeft;
@end

@implementation WriteTweetViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"";
        _numCharsLeft = 140;
    }
    return self;
}

- (id)initWithDelegate:(id<WriteTweetVCDelegate>)delegate {
    if (self = [super init]){
        _delegate = delegate;
    }
    return self;
}

- (void)onTweetButton {
    [self.delegate didComposeTweetWithBody:self.composeTextField.text];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITextViewDelegate methods

- (void)textViewDidChange:(UITextView *)textView {
    self.numCharsLeft = 140 - [textView.text length];
    self.numCharsLeftLabel.text = [NSString stringWithFormat:@"%d", self.numCharsLeft];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if (textView.text.length - range.length + text.length > 140){
        return NO;
    }
    return YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.composeTextField becomeFirstResponder];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Tweet" style:UIBarButtonItemStylePlain target:self action:@selector(onTweetButton)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor colorWithWhite:1.0 alpha:1.0];

    self.numCharsLeftLabel = [[UILabel alloc] initWithFrame:CGRectMake(230,8,200,30)];
    self.numCharsLeftLabel.text = [NSString stringWithFormat:@"%d", self.numCharsLeft];
    self.numCharsLeftLabel.textColor = [UIColor lightGrayColor];
    [self.navigationController.navigationBar addSubview:self.numCharsLeftLabel];
    [self.numCharsLeftLabel setBackgroundColor:[UIColor clearColor]];
    
    //set up user stuff
    self.userName.text = [[User currentUser] name];
    self.userHandle.text = [NSString stringWithFormat:@"@%@", [[User currentUser] handle]];
    [self.UserImage setImageWithURL:[NSURL URLWithString:[[User currentUser] imageURL]]];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.numCharsLeftLabel removeFromSuperview];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
