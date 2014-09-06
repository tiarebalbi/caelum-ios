//
//  CIPListaContatosViewController.h
//  ContatosIP67
//
//  Created by Osni Oliveira on 28/11/12.
//  Copyright (c) 2012 Osni Oliveira. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MessageUI/MessageUI.h>
#import "CIPListaContatosProtocol.h"

@interface CIPListaContatosViewController : UITableViewController <CIPListaContatosProtocol, UIActionSheetDelegate, MFMailComposeViewControllerDelegate> {
    CIPContato *contatoSelecionado;
}

@property (weak) NSManagedObjectContext *contexto;

@property (weak) NSMutableArray *contatos;
@property NSInteger linhaDestaque;

- (void)exibeMaisAcoes:(UIGestureRecognizer *)gestureRecognizer;

@end
