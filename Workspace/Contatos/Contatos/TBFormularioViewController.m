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

-(void) fecharModal
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (id) initWithContato: (TBContato *) contato
{
    if(self = [super init]) {
        self.selecionado = contato;
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancelar"
                                                                                 style:UIBarButtonItemStylePlain
                                                                                target:self
                                                                                action:@selector(fecharModal)];
        
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Atualizar"
                                                                                  style:UIBarButtonItemStylePlain
                                                                                 target:self
                                                                                 action:@selector(atualizar)];
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
    
    if(self.selecionado)   {
        self.nome.text = self.selecionado.nome;
        self.email.text = self.selecionado.email;
        self.site.text = self.selecionado.site;
        self.endereco.text = self.selecionado.endereco;
        self.telefone.text = self.selecionado.telefone;
    }
    
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


- (void) pegaDadosDoFormEColocaNo: (TBContato *) c
{
    c.nome = self.nome.text;
    c.email = self.email.text;
    c.telefone = self.telefone.text;
    c.endereco = self.endereco.text;
    c.site = self.site.text;
    
}

-(void) atualizar
{
    [self pegaDadosDoFormEColocaNo:self.selecionado];
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    NSLog(@"Atualizando o registro");
    NSLog(@"Nome: %@", self.selecionado.nome);
    NSLog(@"Dados do Contato: %@ [%@] | Total de Registro: %i", self.selecionado.nome, self.selecionado.email, [self.contatos count]);
}

-(void) cadastrar {
    
    TBContato *contato = [TBContato new];
    
    [self pegaDadosDoFormEColocaNo:contato];
    
    [self.contatos addObject:contato];
    [self.view endEditing:YES];
    
    NSLog(@"Salvando o registro");
    NSLog(@"Nome: %@", contato.nome);
    NSLog(@"Dados do Contato: %@ [%@] | Total de Registro: %i", contato.nome, contato.email, [self.contatos count]);
    
    // Volta a view utilizando o modelo de transição
    [self.navigationController popViewControllerAnimated:YES];
    
}
@end
