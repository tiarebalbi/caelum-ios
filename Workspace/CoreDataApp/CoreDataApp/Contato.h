//
//  Contato.h
//  CoreDataApp
//
//  Created by ios4584 on 06/09/14.
//  Copyright (c) 2014 Tiarê Balbi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Contato : NSManagedObject

@property (nonatomic, retain) NSString * nome;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * telefone;
@property (nonatomic, retain) NSString * site;
@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) UIImage  * imagem;
@property (nonatomic, retain) NSString * endereco;

@end
