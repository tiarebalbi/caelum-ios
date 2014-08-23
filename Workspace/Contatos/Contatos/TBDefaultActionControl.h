//
//  TBActionControl.h
//  Contatos
//
//  Created by ios4584 on 23/08/14.
//  Copyright (c) 2014 Tiarê Balbi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TBContato.h"
#import <MessageUI/MessageUI.h>

@interface TBDefaultActionControl : NSObject <UIActionSheetDelegate>

@property (weak, nonatomic) UITableViewController *tableView;

@property (strong, nonatomic) id<MFMailComposeViewControllerDelegate> mainService;

@property (weak, nonatomic) TBContato *contato;

- (id) initWithView : (UITableViewController *) tableView;
- (void) ligar;
- (void) enviarEmail;
- (void) abrirSite;
- (void) mostrarMapa;
- (void) excluir;

@end
