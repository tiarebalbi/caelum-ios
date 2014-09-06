//
//  TBContato.m
//  Contatos
//
//  Created by ios4584 on 09/08/14.
//  Copyright (c) 2014 Tiarê Balbi. All rights reserved.
//

#import "TBContato.h"

@implementation TBContato

@dynamic nome;
@dynamic email;
@dynamic telefone;
@dynamic latitude;
@dynamic longitude;
@dynamic imagem;
@dynamic endereco;
@dynamic site;

- (TBContato *) init
{
    if(self = [super init]) {
        // Construtor... Exemplo
        
        if(![self conformsToProtocol:@protocol(NSCoding)]) {
            NSLog(@"Não esta com o protocol coding");
        }
//        self.nome = @"Tiarê Balbi Bonamini";
    }
    
    return self;
}

#pragma mark - Active Record

+ (TBContato *) contatoWithContext : (NSManagedObjectContext *) ctx andNome : (NSString *) nome
{
    TBContato *contato = [NSEntityDescription insertNewObjectForEntityForName:@"Contato"inManagedObjectContext:ctx];
    contato.nome = nome;
    return contato;
}

+ (NSArray *) listaTodosInContext : (NSManagedObjectContext *) ctx onError : (void(^)(void)) block
{
    NSFetchRequest *busca = [NSFetchRequest fetchRequestWithEntityName:@"Contato"];
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"nome" ascending:YES];
    busca.sortDescriptors = @[sort];
    
    NSError *error = nil;
    NSArray* resultado = [ctx executeFetchRequest:busca error:&error];
    
    if(error && block) {
        block();
    }
    
    return resultado;
}

#pragma mark - MKAnnotationView
-(NSString *) title
{
    return self.nome;
}

-(NSString *) subtitle
{
    return self.email;
}

-(CLLocationCoordinate2D) coordinate
{
    float longitude = [self.longitude floatValue];
    float latitude  = [self.latitude floatValue];
    return CLLocationCoordinate2DMake(latitude , longitude);
}






@end
