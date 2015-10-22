//
//  DetailViewController.m
//  BookClub
//
//  Created by Francis Bato on 10/21/15.
//  Copyright © 2015 Francis Bato. All rights reserved.
//

#import "ReadersViewController.h"
#import "FriendViewController.h"
#import "AppDelegate.h"
#import "Reader+CoreDataProperties.h"

@interface ReadersViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) NSArray *readers;
@property NSArray *results;
@property NSManagedObjectContext *moc;

@end

@implementation ReadersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    self.moc = delegate.managedObjectContext;

    [self load];
    [Reader retrieveReaderListWithCompletion:^(NSArray *array) {
            self.results = array;
            [self populateWithReadersIfEmpty];
    }];

}
- (IBAction)onDoneButtonPressed:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:^{

    }];
}

-(void)populateWithReadersIfEmpty {
    if (self.readers.count == 0) {
        for (NSString *result in self.results) {
            NSManagedObject *reader = [NSEntityDescription insertNewObjectForEntityForName:@"Reader" inManagedObjectContext:self.moc];
            [reader setValue:result forKey:@"name"];
            [self.moc save:nil];
            [self load];
        }
    }
}

-(void)load{
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"Reader"];
    NSSortDescriptor *sortDescriptor1 = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    request.sortDescriptors = @[sortDescriptor1];
    self.readers = [self.moc executeFetchRequest:request error:nil];
    [self.tableView reloadData];
}

- (void)setReaders:(NSArray *)readers {
    _readers = readers;
    [self.tableView reloadData];
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.readers.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FriendCell"];

    Reader *reader = self.readers[indexPath.row];

    cell.accessoryType = reader.isFriend ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;

    cell.textLabel.text = [self.readers[indexPath.row] name];

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    NSManagedObject *reader = [self.readers objectAtIndex:indexPath.row];

    if([tableView cellForRowAtIndexPath:indexPath].accessoryType == UITableViewCellAccessoryCheckmark){
        [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryNone;
        [reader setValue:0 forKey:@"isFriend"];
    }else{
        [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
        [reader setValue:@1 forKey:@"isFriend"];
    }

    [self.moc save:nil];
}


@end
