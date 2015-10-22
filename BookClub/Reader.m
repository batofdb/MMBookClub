//
//  Reader.m
//  BookClub
//
//  Created by Francis Bato on 10/21/15.
//  Copyright © 2015 Francis Bato. All rights reserved.
//

#import "Reader.h"
#import "Book.h"

@implementation Reader

+ (void)retrieveReaderListWithCompletion:(void (^)(NSArray *array))complete {

    NSURL *url = [NSURL URLWithString:@"https://s3.amazonaws.com/mmios8week/friends.json"];
    [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {

        NSArray *results = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];

        dispatch_async(dispatch_get_main_queue(), ^{
            complete(results);
        });
    }] resume];
    
}
@end
