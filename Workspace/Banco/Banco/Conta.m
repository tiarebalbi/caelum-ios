//
//  Conta.m
//  Banco
//
//  Created by ios4584 on 09/08/14.
//  Copyright (c) 2014 Tiarê Balbi. All rights reserved.
//

#import "Conta.h"

@implementation Conta {
    NSString *_banco;
}

- (NSString*) banco {
    NSLog(@"Getting...");
    return _banco;
}

- (BOOL) sacar:(float)valor {
    if(self.saldo >= valor) {
        _saldo -= valor;
        NSLog(@"Testando custom getter: %@", self.banco);
        return YES;
    }
    
    return NO;
}

- (void) depositar:(float)valor {
    _saldo += valor;
}

- (BOOL) transferir:(float)valor paraConta:(Conta *)c
{
    if([self sacar:valor]) {
        [c depositar:valor];
        return YES;
    }
    
    return NO;
}

@end