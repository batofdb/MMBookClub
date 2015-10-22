//
//  Book+CoreDataProperties.h
//  BookClub
//
//  Created by Francis Bato on 10/21/15.
//  Copyright © 2015 Francis Bato. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Book.h"

NS_ASSUME_NONNULL_BEGIN

@interface Book (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *author;
@property (nullable, nonatomic, retain) NSString *title;
@property (nullable, nonatomic, retain) NSSet<Book *> *commentList;

@end

@interface Book (CoreDataGeneratedAccessors)

- (void)addCommentListObject:(Book *)value;
- (void)removeCommentListObject:(Book *)value;
- (void)addCommentList:(NSSet<Book *> *)values;
- (void)removeCommentList:(NSSet<Book *> *)values;

@end

NS_ASSUME_NONNULL_END
