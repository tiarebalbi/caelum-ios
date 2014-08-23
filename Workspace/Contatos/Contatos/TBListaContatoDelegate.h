//
//  TBListaContatoDelegate.h
//  Contatos
//
//  Created by ios4584 on 23/08/14.
//  Copyright (c) 2014 Tiarê Balbi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TBContato.h"

@protocol TBListaContatoDelegate <NSObject>

- (void) contatoAdicionado :(TBContato *) contato;
- (void) contatoAtualizado :(TBContato *) contato;

@end
