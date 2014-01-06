//
//  RJCMainTableViewController.h
//  Cinco
//
//  Created by Rory Watson on 02/01/2014.
//  Copyright (c) 2014 Rory Watson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Colours.h"
#import "RJCAddModuleViewController.h"

@interface RJCMainTableViewController : UITableViewController <AddModuleDelegate>

@property (nonatomic, strong) NSArray *modules;

@end
