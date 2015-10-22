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

@interface FriendViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) NSArray *friends;
@property NSMutableArray *results;
@property NSManagedObjectContext *moc;

@end

@implementation FriendViewController


- (void)viewDidLoad {

    

    [super viewDidLoad];
    self.tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);

    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    self.moc = delegate.managedObjectContext;

    [self load];
}

-(void)load{

    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"Reader"];
    //request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"readingList.count" ascending:NO selector:@selector(localizedStandardCompare:)]];
    request.predicate = [NSPredicate predicateWithFormat:@"isFriend = 1"];
    self.friends = [[NSArray alloc]initWithArray:[self.moc executeFetchRequest:request error:nil]];

    [self.tableView reloadData];
}


- (void)setFriends:(NSMutableArray *)friends {
    _friends = friends;
    [self.tableView reloadData];
}


- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.friends.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];

    cell.textLabel.text = [self.friends[indexPath.row] name];

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




@end
