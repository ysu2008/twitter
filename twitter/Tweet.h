//
//  Tweet.h
//  twitter
//
//  Created by Timothy Lee on 8/5/13.
//  Copyright (c) 2013 codepath. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tweet : RestObject

@property (nonatomic, strong, readonly) NSString *text;
@property (nonatomic, strong, readonly) NSString *userName;
@property (nonatomic, strong, readonly) NSString *userHandle;
@property (nonatomic, strong, readonly) NSString *timeStamp;

+ (NSMutableArray *)tweetsWithArray:(NSArray *)array;
- (BOOL)isRetweet;

@end
