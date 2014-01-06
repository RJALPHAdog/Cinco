//
//  RJCEditNoteViewController.h
//  Cinco
//
//  Created by Rory Watson on 03/01/2014.
//  Copyright (c) 2014 Rory Watson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Colours.h"
#import "CincoNotes.h"

@protocol EditNoteDelegate <NSObject>

- (void)saveText:(NSString *) text ForNote:(CincoNotes *) note;

@end

@interface RJCEditNoteViewController : UIViewController

@property (nonatomic, strong) id <EditNoteDelegate> delegate;
@property (nonatomic, strong) CincoNotes *note;
@property (nonatomic, strong) NSString *text;
@property (weak, nonatomic) IBOutlet UITextView *textView;
- (IBAction)saveButtonPressed:(UIBarButtonItem *)sender;

@end
