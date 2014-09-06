//
//  Contato.m
//  CoreDataApp
//
//  Created by ios4584 on 06/09/14.
//  Copyright (c) 2014 Tiarê Balbi. All rights reserved.
//

#import "Contato.h"


@implementation Contato

@dynamic nome;
@dynamic email;
@dynamic telefone;
@dynamic latitude;
@dynamic longitude;
@dynamic imagem;
@dynamic endereco;
@dynamic site;

+ (Contato *) contatoWithContext : (NSManagedObjectContext *) ctx andNome : (NSString *) nome
{
    Contato *contato = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([Contato class]) inManagedObjectContext:ctx];
    contato.nome = nome;
    return contato;
}

@end
