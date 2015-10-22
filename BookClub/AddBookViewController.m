//
//  AddBookViewController.m
//  BookClub
//
//  Created by Francis Bato on 10/21/15.
//  Copyright © 2015 Francis Bato. All rights reserved.
//

#import "AddBookViewController.h"
#import "AppDelegate.h"
#import "Book+CoreDataProperties.h"

@interface AddBookViewController ()
@property (weak, nonatomic) IBOutlet UITextField *titleLabel;
@property (weak, nonatomic) IBOutlet UITextField *authorLabel;
@property NSManagedObjectContext *moc;

@end

@implementation AddBookViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    self.moc = delegate.managedObjectContext;

}



- (IBAction)onDoneButtonPressed:(UIButton *)sender {

    NSManagedObject *book = [NSEntityDescription insertNewObjectForEntityForName:@"Book" inManagedObjectContext:self.moc];
    [book setValue:self.titleLabel.text forKey:@"title"];
    [book setValue:self.authorLabel.text forKey:@"author"];
/*
    Book *newBook = [Book new];
    newBook.title = self.titleLabel.text;
    newBook.author = self.authorLabel.text;
*/
    [self.reader addReadingListObject:book];

    [self.moc save:nil];

    [self dismissViewControllerAnimated:YES completion:^{

    }];
}




@end
