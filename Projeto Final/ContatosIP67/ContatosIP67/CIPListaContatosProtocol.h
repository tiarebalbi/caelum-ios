//
//  CIPListaContatosProtocol.h
//  ContatosIP67
//
//  Created by Osni Oliveira on 03/12/12.
//  Copyright (c) 2012 Osni Oliveira. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CIPContato.h"

@protocol CIPListaContatosProtocol <NSObject>

- (void)contatoAtualizado:(CIPContato *)contato;
- (void)contatoAdicionado:(CIPContato *)contato;

@end
