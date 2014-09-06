//
//  CIPAppDelegate.h
//  ContatosIP67
//
//  Created by Osni Oliveira on 28/11/12.
//  Copyright (c) 2012 Osni Oliveira. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CIPAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong) NSMutableArray *contatos;
@property (strong) NSString *arquivoContatos;

@property (strong, readonly) NSManagedObjectContext *contexto;

@end
