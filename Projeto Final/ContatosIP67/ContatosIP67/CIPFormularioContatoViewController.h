//
//  CIPFormularioContatoViewController.h
//  ContatosIP67
//
//  Created by Osni Oliveira on 28/11/12.
//  Copyright (c) 2012 Osni Oliveira. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CIPContato.h"
#import "CIPListaContatosProtocol.h"

@interface CIPFormularioContatoViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIActionSheetDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nome;
@property (weak, nonatomic) IBOutlet UITextField *telefone;
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *latitude;
@property (weak, nonatomic) IBOutlet UITextField *longitude;
@property (weak, nonatomic) IBOutlet UITextField *endereco;
@property (weak, nonatomic) IBOutlet UITextField *site;
@property (weak, nonatomic) IBOutlet UIButton *botaoFoto;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loading;

@property (weak) NSManagedObjectContext *contexto;

@property (weak) UITextField *campoAtual;
@property (strong) CIPContato *contato;
@property (weak) id<CIPListaContatosProtocol> delegate;

- (id)initWithContato:(CIPContato *)contato;

- (IBAction)proximoElemento:(UITextField *)sender;
- (IBAction)selecionaFoto:(id)sender;
- (IBAction)buscarCoordenadas:(UIButton *)buscarCoordenadasButton;

@end
