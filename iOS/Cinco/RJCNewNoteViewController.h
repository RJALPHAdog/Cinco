//
//  RJCNewNoteViewController.h
//  Cinco
//
//  Created by Rory Watson on 03/01/2014.
//  Copyright (c) 2014 Rory Watson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Colours.h"

@protocol NewNoteDelegate <NSObject>

- (void)addNote:(NSString *)item WithDate:(NSDate *)date;

@end

@interface RJCNewNoteViewController : UIViewController

@property (nonatomic, strong) id <NewNoteDelegate> delegate;
@property (weak, nonatomic) IBOutlet UINavigationBar *navigationBar;
@property (weak, nonatomic) IBOutlet UITextView *textView;
- (IBAction)doneButtonPressed:(UIBarButtonItem *)sender;
- (IBAction)cancelButtonPressed:(UIBarButtonItem *)sender;

@end
