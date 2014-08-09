//
//  Conta.h
//  Banco
//
//  Created by ios4584 on 09/08/14.
//  Copyright (c) 2014 Tiarê Balbi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Conta : NSObject

@property (nonatomic, readonly) float saldo;
@property (strong, nonatomic) NSString *banco;


- (BOOL) sacar : (float) valor;
- (void) depositar : (float) valor;
- (BOOL) transferir : (float) valor paraConta : (Conta*) c;

@end
