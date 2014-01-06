//
//  CincoModules.h
//  Cinco
//
//  Created by Rory Watson on 05/01/2014.
//  Copyright (c) 2014 Rory Watson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class CincoNotes;

@interface CincoModules : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSSet *notes;
@end

@interface CincoModules (CoreDataGeneratedAccessors)

- (void)addNotesObject:(CincoNotes *)value;
- (void)removeNotesObject:(CincoNotes *)value;
- (void)addNotes:(NSSet *)values;
- (void)removeNotes:(NSSet *)values;

@end
