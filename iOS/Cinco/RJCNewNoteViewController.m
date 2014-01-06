//
//  RJCNewNoteViewController.m
//  Cinco
//
//  Created by Rory Watson on 03/01/2014.
//  Copyright (c) 2014 Rory Watson. All rights reserved.
//

#import "RJCNewNoteViewController.h"

@interface RJCNewNoteViewController (){
    UIColor *tintColour;
    UIColor *barColour;
}

@end

@implementation RJCNewNoteViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.navigationBar.delegate = self;
    
    tintColour = pantone130;
    barColour = pantone300;
    
    [[UITextView appearance] setTintColor:barColour];
    
    self.navigationBar.barTintColor = barColour;
    self.navigationBar.tintColor = tintColour;
    self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : tintColour};
    self.view.backgroundColor = tintColour;
    self.textView.backgroundColor = [UIColor clearColor];
    self.textView.textColor = barColour;
    [self.textView setFont:[UIFont systemFontOfSize:17]];
    [self registerForKeyboardNotifications];
    [self.textView becomeFirstResponder];
}

- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
}

- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    self.textView.contentInset = contentInsets;
    self.textView.scrollIndicatorInsets = contentInsets;
}

- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.textView.contentInset = contentInsets;
}

-(UIBarPosition)positionForBar:(id<UIBarPositioning>)bar
{
    CGRect frame = self.navigationBar.frame;
    frame.origin = CGPointMake(0, [UIApplication sharedApplication].statusBarFrame.size.height);
    self.navigationBar.frame = frame;
    
    return UIBarPositionTopAttached;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)doneButtonPressed:(UIBarButtonItem *)sender
{
    [self.delegate addNote:self.textView.text WithDate:[NSDate date]];
}

-(void)cancelButtonPressed:(UIBarButtonItem *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
