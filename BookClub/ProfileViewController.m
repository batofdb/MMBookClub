//
//  ProfileViewController.m
//  BookClub
//
//  Created by Francis Bato on 10/21/15.
//  Copyright © 2015 Francis Bato. All rights reserved.
//

#import "ProfileViewController.h"
#import "AddBookViewController.h"
#import "Book+CoreDataProperties.h"
#import "AppDelegate.h"
#import "BookViewController.h"

@interface ProfileViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property NSArray *results;
@property (nonatomic) NSArray *books;
@property NSManagedObjectContext *moc;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.reader.name;

    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    self.moc = delegate.managedObjectContext;

    self.books = [self.reader.readingList allObjects];
}


-(void)load{
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"Book"];
    NSSortDescriptor *sortDescriptor1 = [[NSSortDescriptor alloc] initWithKey:@"title" ascending:YES];
    request.sortDescriptors = @[sortDescriptor1];
    self.books = [self.moc executeFetchRequest:request error:nil];
    [self.tableView reloadData];
}

- (void)setBooks:(NSArray *)books {
    _books = books;
    [self.tableView reloadData];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.books.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];

    Book *book = self.books[indexPath.row];

    cell.textLabel.text = book.title;
    cell.detailTextLabel.text = book.author;

    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"addBookSegue"]) {
    AddBookViewController *vc = [segue destinationViewController];
    vc.reader = self.reader;
    } else {


        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        BookViewController *vc = [segue destinationViewController];
        vc.book = self.books[indexPath.row];
    }

}


- (IBAction)unwindFromBookAdd:(UIStoryboardSegue *)sender {
    self.books = [self.reader.readingList allObjects];
}

@end
