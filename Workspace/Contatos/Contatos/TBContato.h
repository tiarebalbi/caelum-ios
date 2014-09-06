//
//  TBContato.h
//  Contatos
//
//  Created by ios4584 on 09/08/14.
//  Copyright (c) 2014 Tiarê Balbi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TBContato : NSManagedObject<MKAnnotation>

@property (nonatomic, retain) NSString * nome;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * telefone;
@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) UIImage  * imagem;
@property (nonatomic, retain) NSString * endereco;
@property (nonatomic, retain) NSString * site;

#pragma mark - Active Record

+ (TBContato *) contatoWithContext : (NSManagedObjectContext *) ctx andNome : (NSString *) nome;
+ (NSArray *) listaTodosInContext : (NSManagedObjectContext *) ctx onError : (void(^)(void)) block;
@end
