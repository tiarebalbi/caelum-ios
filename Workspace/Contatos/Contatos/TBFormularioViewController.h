//
//  TBFormularioViewController.h
//  Contatos
//
//  Created by ios4584 on 09/08/14.
//  Copyright (c) 2014 Tiarê Balbi. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TBFormularioViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *nome;
@property (weak, nonatomic) IBOutlet UITextField *telefone;
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *endereco;
@property (weak, nonatomic) IBOutlet UITextField *site;
@property (weak, nonatomic) IBOutlet UILabel *welcome;

@property (strong, nonatomic) NSArray *campos;
@property (strong, nonatomic) NSMutableArray *contatos;

@end
