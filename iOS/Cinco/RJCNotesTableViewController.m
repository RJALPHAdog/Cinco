//
//  RJCNotesTableViewController.m
//  Cinco
//
//  Created by Rory Watson on 03/01/2014.
//  Copyright (c) 2014 Rory Watson. All rights reserved.
//

#import "RJCAppDelegate.h"
#import "RJCNotesTableViewController.h"
#import "CincoModules.h"
#import "CincoNotes.h"

@interface RJCNotesTableViewController (){
    UIColor *tintColour;
    UIColor *barColour;
}

@property (nonatomic, strong) RJCAppDelegate *appDelegate;

@end

@implementation RJCNotesTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.appDelegate = (RJCAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    tintColour = pantone130;
    barColour = pantone300;
    
    self.navigationController.navigationBar.barTintColor = barColour;
    self.navigationController.navigationBar.tintColor = tintColour;
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : tintColour};
    self.tableView.backgroundColor = tintColour;
    self.tableView.separatorColor = barColour;
    
    self.notes = [[NSMutableArray alloc] init];
    [self updateCoreDataContent];
    //if (debugBool) [self.notes addObject:@"Test"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.notes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"notesCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    NSDate *date = [[self.notes objectAtIndex:indexPath.row] valueForKey:@"date"];
    //NSLog(@"Date: %@",date);
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    if([[dateFormatter stringFromDate:date] isEqualToString:[dateFormatter stringFromDate:[NSDate date]]])
        [dateFormatter setDateStyle:NSDateFormatterNoStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    
    cell.textLabel.text = [dateFormatter stringFromDate:date];
    
//    cell.textLabel.text = [NSString stringWithFormat:@"%@",[[self.notes objectAtIndex:indexPath.row] valueForKey:@"title"]];
    cell.backgroundColor = [UIColor clearColor];
    
    UIView *bgColorView = [[UIView alloc] init];
    bgColorView.backgroundColor = [barColour colorWithAlphaComponent:0.6];
    bgColorView.layer.masksToBounds = YES;
    [cell setSelectedBackgroundView:bgColorView];
    cell.textLabel.textColor = barColour;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        [tableView beginUpdates];
        [self.appDelegate.managedObjectContext deleteObject:[self.notes objectAtIndex:indexPath.row]];
        [self.appDelegate.managedObjectContext save:nil];
        [self updateCoreDataContent];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [tableView endUpdates];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"newNoteSegue"])
    {
        RJCNewNoteViewController *dvc = segue.destinationViewController;
        dvc.delegate = self;
    }
    if ([segue.identifier isEqualToString:@"editNoteSegue"]) {
        RJCEditNoteViewController *dvc = segue.destinationViewController;
        dvc.delegate = self;
        dvc.note = [self.notes objectAtIndex:[self.tableView indexPathForSelectedRow].row];
        dvc.text = [[self.notes objectAtIndex:[self.tableView indexPathForSelectedRow].row] valueForKey:@"note"];
    }
    
}

- (void)updateCoreDataContent
{
    NSArray *unsorted = [self.selectedModule.notes allObjects];
    NSArray *sortDescriptors = [NSArray arrayWithObject: [[NSSortDescriptor alloc]
                                                          initWithKey:@"date"
                                                          ascending:YES
                                                          selector:@selector(compare:)]];
    self.notes = [unsorted sortedArrayUsingDescriptors:sortDescriptors];
    [self.tableView reloadData];
}

- (void)addNote:(NSString *)item WithDate:(NSDate *)date
{
    NSManagedObjectContext *managedObjectContext = self.appDelegate.managedObjectContext;
    if (![item isEqual: @""] && ![item isEqual: @" "]) {
        CincoNotes *cincoNotes = (CincoNotes *)[NSEntityDescription insertNewObjectForEntityForName:@"CincoNotes"inManagedObjectContext:managedObjectContext];
        
        cincoNotes.note = item;
        cincoNotes.date = date;
        cincoNotes.modules = self.selectedModule;
        
        NSError *err;
        if (![managedObjectContext save:&err]) {
            NSLog(@"Couldn't save: %@",[err localizedDescription]);
        }
        [self updateCoreDataContent];
        [self dismissViewControllerAnimated:YES completion:nil];
        [self.tableView reloadData];
    }
}

- (void)saveText:(NSString *)text ForNote:(CincoNotes *)note
{
    NSManagedObjectContext *managedObjectContext = self.appDelegate.managedObjectContext;
    NSError *err;
    note.date = [NSDate date];
    note.note = text;
    [managedObjectContext save:&err];
    [self updateCoreDataContent];
    [self.tableView reloadData];
}

@end
