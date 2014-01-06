//
//  RJCEditNoteViewController.m
//  Cinco
//
//  Created by Rory Watson on 03/01/2014.
//  Copyright (c) 2014 Rory Watson. All rights reserved.
//

#import "RJCEditNoteViewController.h"

@interface RJCEditNoteViewController (){
    UIColor *tintColour;
    UIColor *barColour;
}


@end

@implementation RJCEditNoteViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    tintColour = pantone130;
    barColour = pantone300;
    
    [[UITextView appearance] setTintColor:barColour];
    
    self.navigationController.navigationBar.barTintColor = barColour;
    self.navigationController.navigationBar.tintColor = tintColour;
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : tintColour};
    self.view.backgroundColor = tintColour;
    self.textView.backgroundColor = [UIColor clearColor];
    self.textView.textColor = barColour;
    [self.textView setFont:[UIFont systemFontOfSize:17]];
    self.textView.text = self.text;
    [self registerForKeyboardNotifications];
    self.automaticallyAdjustsScrollViewInsets = NO;
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveButtonPressed:(UIBarButtonItem *)sender
{
    [self.delegate saveText:self.textView.text ForNote:self.note];
    [self.textView resignFirstResponder];
}

@end
