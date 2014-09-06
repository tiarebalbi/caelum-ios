//
//  UIViewController+ComPersistencia.m
//  Contatos
//
//  Created by ios4584 on 06/09/14.
//  Copyright (c) 2014 Tiarê Balbi. All rights reserved.
//

#import "UIViewController+ComPersistencia.h"
#import "TBAppDelegate.h"

@implementation UIViewController (ComPersistencia)

-(NSManagedObjectContext *) contexto
{
    TBAppDelegate *app = (TBAppDelegate *) [[UIApplication sharedApplication] delegate];
    return [app managedObjectContext];
}


@end
