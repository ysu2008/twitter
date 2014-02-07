//
//  WriteTweetViewController.h
//  twitter
//
//  Created by Yang Su on 2/6/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WriteTweetVCDelegate

- (void)didComposeTweetWithBody:(NSString *)body;

@end

@interface WriteTweetViewController : UIViewController<UITextViewDelegate>

- (id)initWithDelegate:(id<WriteTweetVCDelegate>)delegate;

@end
