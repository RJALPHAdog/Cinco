//
//  RJCNotesTableViewController.h
//  Cinco
//
//  Created by Rory Watson on 03/01/2014.
//  Copyright (c) 2014 Rory Watson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RJCNewNoteViewController.h"
#import "RJCEditNoteViewController.h"
#import "Colours.h"
#import "CincoModules.h"

@interface RJCNotesTableViewController : UITableViewController <NewNoteDelegate, EditNoteDelegate>

@property (nonatomic, strong) NSArray *notes;
@property (nonatomic, strong) CincoModules *selectedModule;

@end
