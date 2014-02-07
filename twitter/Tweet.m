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
    if ([self isRetweet]){
        return self.data[@"retweeted_status"][@"text"];
    }
    else {
        return self.data[@"text"];
    }
}

- (NSString *)userName {
    if ([self isRetweet]){
        return self.data[@"retweeted_status"][@"user"][@"name"];
    }
    else {
        return self.data[@"user"][@"name"];
    }
}

- (NSString *)userHandle {
    if ([self isRetweet]){
        return [NSString stringWithFormat:@"@%@", self.data[@"retweeted_status"][@"user"][@"screen_name"]];
    }
    else {
        return [NSString stringWithFormat:@"@%@", self.data[@"user"][@"screen_name"]];
    }
}

- (NSString *)retweeterName {
    return [self isRetweet] ? self.data[@"user"][@"name"] : @"";
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

- (long long)tweetID {
    return [self.data[@"id_str"] longLongValue];
}

- (BOOL)isSelfRetweeted {
    return !![((NSString *)self.data[@"retweeted"]) intValue];
}

- (BOOL)isRetweet {
    return !!self.data[@"retweeted_status"];
}

- (BOOL)favorited {
    return !![((NSString *)self.data[@"favorited"]) intValue];
}

- (NSString *)tweeterImage {
    if ([self isRetweet]){
        return self.data[@"retweeted_status"][@"user"][@"profile_image_url"];
    }
    else {
        return self.data[@"user"][@"profile_image_url"];
    }
}
@end
