//
//  Tweet.m
//  twitter
//
//  Created by Timothy Lee on 8/5/13.
//  Copyright (c) 2013 codepath. All rights reserved.
//

#import "Tweet.h"

@implementation Tweet

+ (NSMutableArray *)tweetsWithArray:(NSArray *)array {
    NSMutableArray *tweets = [[NSMutableArray alloc] initWithCapacity:array.count];
    for (NSDictionary *params in array) {
        [tweets addObject:[[Tweet alloc] initWithDictionary:params]];
    }
    return tweets;
}

- (NSString *)text {
    return [self.data valueOrNilForKeyPath:@"text"];
}

- (NSString *)userName {
    return self.data[@"user"][@"name"];
}

- (NSString *)userHandle {
    return [NSString stringWithFormat:@"@%@", self.data[@"user"][@"screen_name"]];
}

- (NSDate *)timeStamp {
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [df setDateFormat:@"EEE MMM d HH:mm:ss Z y"];
    NSDate *date = [df dateFromString:(NSString *)self.data[@"created_at"]];
    
    return date;
}

- (NSNumber *)retweetCount {
    return self.data[@"retweet_count"];
}

- (NSNumber *)favoriteCount {
    return self.data[@"favorite_count"];
}

- (BOOL)isRetweet {
    return !![((NSString *)self.data[@"retweeted"]) intValue];
}

- (NSString *)tweeterImage {
    return self.data[@"user"][@"profile_image_url"];
}
@end
