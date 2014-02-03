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

- (NSString *)timeStamp {
    return self.data[@"created_at"];
}

- (BOOL)isRetweet {
    return !![((NSString *)self.data[@"retweeted"]) intValue];
}

@end
