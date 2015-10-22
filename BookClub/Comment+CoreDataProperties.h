//
//  Comment+CoreDataProperties.h
//  BookClub
//
//  Created by Francis Bato on 10/21/15.
//  Copyright © 2015 Francis Bato. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Comment.h"

NS_ASSUME_NONNULL_BEGIN

@interface Comment (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *comment;
@property (nullable, nonatomic, retain) Book *book;

@end

NS_ASSUME_NONNULL_END
