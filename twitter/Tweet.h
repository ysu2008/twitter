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
@property (nonatomic, strong, readonly) NSDate *timeStamp;
@property (nonatomic, strong, readonly) NSString *tweeterImage;
@property (nonatomic, strong, readonly) NSNumber *retweetCount;
@property (nonatomic, strong, readonly) NSNumber *favoriteCount;
@property (nonatomic, strong, readonly) NSString *retweeterName;

+ (NSMutableArray *)tweetsWithArray:(NSArray *)array;
- (BOOL)isSelfRetweeted;
- (BOOL)isRetweet;
- (BOOL)favorited;
- (long long)tweetID;

@end
