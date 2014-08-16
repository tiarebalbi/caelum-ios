//
//  TBFormularioViewController.m
//  Contatos
//
//  Created by ios4584 on 09/08/14.
//  Copyright (c) 2014 Tiarê Balbi. All rights reserved.
//

#import "TBFormularioViewController.h"
#import "TBContato.h"

#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface TBFormularioViewController ()

@end

@implementation TBFormularioViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Novo Contato";
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Salvar"
                                                                                  style:UIBarButtonItemStylePlain
                                                                                 target:self
                                                                                 action:@selector(cadastrar)];
        
    }
    return self;
}

- (void)viewDidLoad
{
    self.campos = @[self.nome, self.telefone, self.email, self.endereco, self.site];
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName,nil]];
    
    self.telefone.keyboardType = UIKeyboardTypeNumberPad;
    self.email.keyboardType = UIKeyboardTypeEmailAddress;
    self.site.keyboardType = UIKeyboardTypeURL;
    
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (IBAction)change:(UITextField *)sender {
    int posicao = [self.campos indexOfObject:sender];
    if(posicao == [self.campos count] -1) {
        [self.view endEditing:true];
    }else if(posicao < [self.campos count] -1) {
        UITextField *proximo = self.campos[posicao+1];
        [proximo becomeFirstResponder];
    }

}
- (IBAction)trocando:(UITextField *)sender {
    self.welcome.text = [NSString stringWithFormat: @"Bem Vindo, %@",sender.text];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


-(TBContato *) cadastrar {
    TBContato *contato = [TBContato new];
    
    // Testando o valor do contrutor TBContato, onde é inserido o nome nele.
    contato.nome = self.nome.text;
    contato.email = self.email.text;
    contato.telefone = self.telefone.text;
    contato.endereco = self.endereco.text;
    contato.site = self.site.text;
    
    [self.contatos addObject:contato];
    [self.view endEditing:YES];
    NSLog(@"Nome: %@", contato.nome);
    NSLog(@"Dados do Contato: %@ [%@] | Total de Registro: %i", contato.nome, contato.email, [self.contatos count]);
    
    // Volta a view utilizando o modelo de transição
    [self.navigationController popViewControllerAnimated:YES];
    
    // Fecha o modal
//    [self.navigationController dismissViewControllerAnimated:YES
//                                                  completion:nil];
    
    
    return contato;
}
@end
