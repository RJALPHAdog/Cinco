//
//  CincoNotes.h
//  Cinco
//
//  Created by Rory Watson on 05/01/2014.
//  Copyright (c) 2014 Rory Watson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class CincoModules;

@interface CincoNotes : NSManagedObject

@property (nonatomic, retain) NSString * note;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) CincoModules *modules;

@end
