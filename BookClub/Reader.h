//
//  Reader.h
//  BookClub
//
//  Created by Francis Bato on 10/21/15.
//  Copyright © 2015 Francis Bato. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Book;

NS_ASSUME_NONNULL_BEGIN

@interface Reader : NSManagedObject
+ (void)retrieveReaderListWithCompletion:(void (^)(NSArray *array))complete;
@end

NS_ASSUME_NONNULL_END

#import "Reader+CoreDataProperties.h"
