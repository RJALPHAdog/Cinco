//
//  RJCAppDelegate.h
//  Cinco
//
//  Created by Rory Watson on 02/01/2014.
//  Copyright (c) 2014 Rory Watson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RJCAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
