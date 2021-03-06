//
//  TBContato.h
//  Contatos
//
//  Created by ios4584 on 09/08/14.
//  Copyright (c) 2014 Tiarê Balbi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TBContato : NSObject<NSCoding>

@property NSString *nome;
@property NSString *telefone;
@property NSString *email;
@property NSString *endereco;
@property NSString *site;

- (id) initWithName : (NSString *) nome email:(NSString *) email telefone:(NSString *)telefone endereco:(NSString *) endereco site: (NSString *)site;

@end
