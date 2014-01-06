//
//  RJCMainTableViewController.m
//  Cinco
//
//  Created by Rory Watson on 02/01/2014.
//  Copyright (c) 2014 Rory Watson. All rights reserved.
//

#import "RJCAppDelegate.h"
#import "RJCMainTableViewController.h"
#import "RJCNotesTableViewController.h"
#import "CincoModules.h"
#import "CincoNotes.h"

@interface RJCMainTableViewController (){
    UIColor *tintColour;
    UIColor *barColour;
}

@property (nonatomic, strong) RJCAppDelegate *appDelegate;

@end

@implementation RJCMainTableViewController

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
    
    self.modules = [[NSMutableArray alloc] init];
    //if (debugBool) [self.modules addObject:@"Test"];
    [self updateCoreDataContent];
}

- (void)updateCoreDataContent
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"CincoModules" inManagedObjectContext:self.appDelegate.managedObjectContext];
    [fetchRequest setEntity:entityDescription];
    NSError *err;
    self.modules = [self.appDelegate.managedObjectContext executeFetchRequest:fetchRequest error:&err];
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
    return self.modules.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"moduleCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@",[[self.modules objectAtIndex:indexPath.row] valueForKey:@"title"]];
    cell.backgroundColor = [UIColor clearColor];
    
    UIView *bgColorView = [[UIView alloc] init];
    bgColorView.backgroundColor = [barColour colorWithAlphaComponent:0.6];
    bgColorView.layer.masksToBounds = YES;
    [cell setSelectedBackgroundView:bgColorView];
    cell.textLabel.textColor = barColour;
    
    //cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 60;
//}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        [tableView beginUpdates];
        [self.appDelegate.managedObjectContext deleteObject:[self.modules objectAtIndex:indexPath.row]];
        [self.appDelegate.managedObjectContext save:nil];
        [self updateCoreDataContent];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [tableView endUpdates];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"addModuleSegue"])
    {
        RJCAddModuleViewController *dvc = segue.destinationViewController;
        dvc.delegate = self;
    }
    if ([segue.identifier isEqualToString:@"notesViewSegue"]) {
        RJCNotesTableViewController *dvc = segue.destinationViewController;
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        CincoModules *selectedModule = [self.modules objectAtIndex:indexPath.row];
        dvc.selectedModule = selectedModule;
    }
    
}

- (void)addModule:(NSString *)item
{
    NSManagedObjectContext *managedObjectContext = self.appDelegate.managedObjectContext;
    if (![item isEqual: @""] && ![item isEqual: @" "]) {
        CincoModules *cincoModules = (CincoModules *)[NSEntityDescription insertNewObjectForEntityForName:@"CincoModules"inManagedObjectContext:managedObjectContext];
        cincoModules.title = item;
        
        NSError *err;
        if (![managedObjectContext save:&err]) {
            NSLog(@"Couldn't save: %@",[err localizedDescription]);
        }
        [self updateCoreDataContent];
    
    //[self.modules addObject: item];
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.tableView reloadData];
    }
}

@end
