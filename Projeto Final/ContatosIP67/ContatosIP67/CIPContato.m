//
//  CIPContato.m
//  ContatosIP67
//
//  Created by Osni Oliveira on 28/11/12.
//  Copyright (c) 2012 Osni Oliveira. All rights reserved.
//

#import "CIPContato.h"

@implementation CIPContato
@dynamic nome, telefone, email, latitude, longitude, endereco, site, foto;

//#pragma mark -
//#pragma mark NSCoding
//
//- (id)initWithCoder:(NSCoder *)aDecoder {
//    self = [super init];
//    
//    if (self) {
//        self.nome = [aDecoder decodeObjectForKey:@"nome"];
//        self.telefone = [aDecoder decodeObjectForKey:@"telefone"];
//        self.email = [aDecoder decodeObjectForKey:@"email"];
//        self.latitude = [aDecoder decodeObjectForKey:@"latitude"];
//        self.longitude = [aDecoder decodeObjectForKey:@"longitude"];
//        self.endereco = [aDecoder decodeObjectForKey:@"endereco"];
//        self.site = [aDecoder decodeObjectForKey:@"site"];
//        self.foto = [aDecoder decodeObjectForKey:@"foto"];
//    }
//    
//    return self;
//}
//
//- (void)encodeWithCoder:(NSCoder *)aCoder {
//    [aCoder encodeObject:self.nome forKey:@"nome"];
//    [aCoder encodeObject:self.telefone forKey:@"telefone"];
//    [aCoder encodeObject:self.email forKey:@"email"];
//    [aCoder encodeObject:self.latitude forKey:@"latitude"];
//    [aCoder encodeObject:self.longitude forKey:@"longitude"];
//    [aCoder encodeObject:self.endereco forKey:@"endereco"];
//    [aCoder encodeObject:self.site forKey:@"site"];
//    [aCoder encodeObject:self.foto forKey:@"foto"];
//}

#pragma mark -
#pragma mark MKAnnotation

- (CLLocationCoordinate2D)coordinate {
    return CLLocationCoordinate2DMake([self.latitude doubleValue], [self.longitude doubleValue]);
}

- (NSString *)title {
    return self.nome;
}

- (NSString *)subtitle {
    return self.email;
}

@end
