//
//  BookViewController.m
//  BookClub
//
//  Created by Francis Bato on 10/21/15.
//  Copyright © 2015 Francis Bato. All rights reserved.
//

#import "BookViewController.h"
#import "AppDelegate.h"

@interface BookViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property NSManagedObjectContext *moc;
@property NSArray *comments;

@end

@implementation BookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    self.moc = delegate.managedObjectContext;
    self.title = self.book.title;
}

-(void)load{
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"Comment"];
    self.comments = [self.moc executeFetchRequest:request error:nil];
    [self.tableView reloadData];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.comments.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell.textLabel.text = self.comments[indexPath.row];
    return cell;
}

- (IBAction)onCommentButtonPressed:(UIButton *)sender {

    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Add Comment" message:nil preferredStyle:UIAlertControllerStyleAlert];

    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Comment";
    }];


    UIAlertAction *addAction = [UIAlertAction actionWithTitle:@"Add" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){

        UITextField *commentTextField = [[alertController textFields] firstObject];

        NSString *commentString = commentTextField.text;

        NSManagedObject *comment = [NSEntityDescription insertNewObjectForEntityForName:@"Comment" inManagedObjectContext:
                                      self.moc];
        [comment setValue:commentString forKey:@"comment"];

        [self.moc save:nil];
        [self load];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
    }];
    [alertController addAction:addAction];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
}


@end
