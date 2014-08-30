//
//  TBContato.m
//  Contatos
//
//  Created by ios4584 on 09/08/14.
//  Copyright (c) 2014 Tiarê Balbi. All rights reserved.
//

#import "TBContato.h"

@implementation TBContato

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

- (id) initWithName : (NSString *) nome email:(NSString *) email telefone:(NSString *)telefone endereco:(NSString *) endereco site: (NSString *)site
{
    if(self = [self init]) {
        self.nome = nome;
        self.email = email;
        self.telefone = telefone;
        self.endereco = endereco;
        self.site = site;
    }
    
    return self;
}




- (void) encodeWithCoder : (NSCoder *) parse
{
    [parse encodeObject:_nome forKey:@"nome"];
    [parse encodeObject:_email forKey:@"email"];
    [parse encodeObject:_telefone forKey:@"telefone"];
    [parse encodeObject:_site forKey:@"site"];
    [parse encodeObject:_endereco forKey:@"endereco"];
    [parse encodeObject:_imagem forKey:@"imagem"];
    [parse encodeDouble:_latitude forKey:@"latitude"];
    [parse encodeDouble:_longitude forKey:@"longitude"];

}

- (id) initWithCoder : (NSCoder *) parse
{
    self.nome = [parse decodeObjectForKey:@"nome"];
    self.email = [parse decodeObjectForKey:@"email"];
    self.telefone = [parse decodeObjectForKey:@"telefone"];
    self.site = [parse decodeObjectForKey:@"site"];
    self.endereco = [parse decodeObjectForKey:@"endereco"];
    self.imagem = [parse decodeObjectForKey:@"imagem"];
    self.longitude = [parse decodeDoubleForKey:@"longitude"];
    self.latitude = [parse decodeDoubleForKey:@"latitude"];
    
    return self;
}


-(NSString *) title
{
    return _nome;
}

-(NSString *) subtitle
{
    return _email;
}

-(CLLocationCoordinate2D) coordinate
{
    float longitude = [[NSString stringWithFormat:@"%f", self.longitude] floatValue];
    float latitude  = [[NSString stringWithFormat:@"%f", self.latitude] floatValue];
    return CLLocationCoordinate2DMake(latitude , longitude);
}

@end
