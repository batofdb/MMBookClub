//
//  FriendViewController.m
//  BookClub
//
//  Created by Francis Bato on 10/21/15.
//  Copyright © 2015 Francis Bato. All rights reserved.
//
#import "FriendViewController.h"
#import "Reader+CoreDataProperties.h"
#import "AppDelegate.h"
#import "ReadersViewController.h"
#import "ProfileViewController.h"

@interface FriendViewController () <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (nonatomic) NSArray *friends;
@property NSArray *filteredFriends;
@property NSMutableArray *results;
@property NSManagedObjectContext *moc;
@property UISearchController *searchController;
@property BOOL isFiltered;
@end

@implementation FriendViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.isFiltered = NO;
    self.filteredFriends = [NSArray new];

    self.tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);

    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    self.moc = delegate.managedObjectContext;

    [self load];
}

-(void)load{

    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"Reader"];
    request.predicate = [NSPredicate predicateWithFormat:@"isFriend = 1"];
    self.friends= [[NSArray alloc]initWithArray:[self.moc executeFetchRequest:request error:nil]];
    //NSArray* sortedArray = [[NSArray alloc] initWithArray:[array sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"readingList.count" ascending:NO selector:@selector(localizedStandardCompare:)]]]];


    [self.tableView reloadData];
}


- (void)setFriends:(NSMutableArray *)friends {
    _friends = friends;
    [self.tableView reloadData];
}


- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.isFiltered)
        return self.filteredFriends.count;
    else
        return self.friends.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];

    if (self.isFiltered) {
        cell.textLabel.text = [self.filteredFriends[indexPath.row] name];
    } else {
        cell.textLabel.text = [self.friends[indexPath.row] name];
    }

    return cell;
}

- (IBAction)unWindFromAdd:(UIStoryboardSegue *)sender {
    [self load];
    [self.tableView reloadData];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];

    if ([segue.identifier isEqualToString:@"profileSegue"]) {
        ProfileViewController *vc = [segue destinationViewController];
        vc.reader = self.friends[indexPath.row];
    }
}

#pragma mark - search bar methods

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"name contains[cd] %@", searchText];
    self.filteredFriends = [self.friends filteredArrayUsingPredicate:resultPredicate];
    [self.tableView reloadData];
}


- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {

    self.isFiltered = NO;
    if (searchText.length > 0)
        self.isFiltered =YES;

    NSLog(@"search: %@", searchText);
    [self filterContentForSearchText:searchText scope:nil];
}



@end
