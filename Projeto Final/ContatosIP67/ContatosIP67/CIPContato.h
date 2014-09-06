//
//  CIPContato.h
//  ContatosIP67
//
//  Created by Osni Oliveira on 28/11/12.
//  Copyright (c) 2012 Osni Oliveira. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface CIPContato : NSManagedObject <MKAnnotation>

@property (strong) NSString *nome;
@property (strong) NSString *telefone;
@property (strong) NSString *email;
@property (strong) NSNumber *latitude;
@property (strong) NSNumber *longitude;
@property (strong) NSString *endereco;
@property (strong) NSString *site;
@property (strong) UIImage *foto;

@end
