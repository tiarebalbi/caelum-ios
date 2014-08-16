//
//  TBBAppDelegate.h
//  CalcCaelum
//
//  Created by Tiarê Balbi Bonamini on 8/10/14.
//  Copyright (c) 2014 Tiarê Balbi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TBBAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
