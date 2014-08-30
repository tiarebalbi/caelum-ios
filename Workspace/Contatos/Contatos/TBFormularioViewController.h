//
//  TBFormularioViewController.h
//  Contatos
//
//  Created by ios4584 on 09/08/14.
//  Copyright (c) 2014 Tiarê Balbi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TBContato.h"
#import "TBListaContatosViewController.h"
#import "TBListaContatoDelegate.h"

@interface TBFormularioViewController : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nome;
@property (weak, nonatomic) IBOutlet UITextField *telefone;
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *endereco;
@property (weak, nonatomic) IBOutlet UITextField *site;
@property (weak, nonatomic) IBOutlet UITextField *latitude;
@property (weak, nonatomic) IBOutlet UITextField *longitude;

@property (weak, nonatomic) IBOutlet UIButton *foto;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicator;

- (IBAction)carregarLocalizacao:(id)sender;

@property (strong, nonatomic) NSArray *campos;

@property (weak, nonatomic) id <TBListaContatoDelegate> delegate;

@property (strong, nonatomic) TBContato *selecionado;

@property (nonatomic, weak) UIScrollView *fundo;

- (id) initWithContato: (TBContato *) contato;

@end
