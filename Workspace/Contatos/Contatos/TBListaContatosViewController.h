//
//  TBListaContatosViewController.h
//  Contatos
//
//  Created by ios4584 on 16/08/14.
//  Copyright (c) 2014 Tiarê Balbi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TBContato.h"
#import "TBListaContatoDelegate.h"
#import "TBDefaultActionControl.h"

@interface TBListaContatosViewController : UITableViewController <TBListaContatoDelegate>

@property (strong, nonatomic) NSMutableArray *contatos;
@property (strong, nonatomic) TBContato *contatoSelecionado;

@property (strong, nonatomic) TBDefaultActionControl *actionControl;


@property NSNumber *linhaDestaque;

- (void) contatoAdicionado :(TBContato *) contato;
- (void) contatoAtualizado :(TBContato *) contato;

@end
