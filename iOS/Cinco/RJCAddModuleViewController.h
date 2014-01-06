//
//  RJCAddModuleViewController.h
//  Cinco
//
//  Created by Rory Watson on 03/01/2014.
//  Copyright (c) 2014 Rory Watson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Colours.h"

@protocol AddModuleDelegate <NSObject>

- (void)addModule:(NSString *)item;

@end

@interface RJCAddModuleViewController : UIViewController

@property (nonatomic, strong) id <AddModuleDelegate> delegate;
@property (weak, nonatomic) IBOutlet UINavigationBar *navigationBar;
@property (weak, nonatomic) IBOutlet UITextView *textView;
- (IBAction)doneButtonPressed:(UIBarButtonItem *)sender;
- (IBAction)cancelButtonPressed:(UIBarButtonItem *)sender;

@end
