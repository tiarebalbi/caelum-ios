//
//  TBFormularioViewController.m
//  Contatos
//
//  Created by ios4584 on 09/08/14.
//  Copyright (c) 2014 Tiarê Balbi. All rights reserved.
//

#import "TBFormularioViewController.h"
#import "TBContato.h"

@interface TBFormularioViewController ()

@end

@implementation TBFormularioViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    self.campos = @[self.nome, self.telefone, self.email, self.endereco, self.site];
    self.contatos = [NSMutableArray new];
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

- (IBAction)cadastrar:(id)sender {
    TBContato *contato = [TBContato new];
    
    contato.nome = self.nome.text;
    contato.email = self.email.text;
    contato.telefone = self.telefone.text;
    contato.endereco = self.endereco.text;
    contato.site = self.site.text;

    [self.contatos addObject:contato];
    [self.view endEditing:YES];
    NSLog(@"Dados do Contato: %@ [%@] | Total de Registro: %i", contato.nome, contato.email, [self.contatos count]);
    
}
@end
