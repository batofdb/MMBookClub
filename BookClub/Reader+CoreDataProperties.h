//
//  Reader+CoreDataProperties.h
//  BookClub
//
//  Created by Francis Bato on 10/21/15.
//  Copyright © 2015 Francis Bato. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Reader.h"

NS_ASSUME_NONNULL_BEGIN

@interface Reader (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *isFriend;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSSet<Book *> *readingList;

@end

@interface Reader (CoreDataGeneratedAccessors)

- (void)addReadingListObject:(Book *)value;
- (void)removeReadingListObject:(Book *)value;
- (void)addReadingList:(NSSet<Book *> *)values;
- (void)removeReadingList:(NSSet<Book *> *)values;

@end

NS_ASSUME_NONNULL_END
