//
//  BradescoViewController.m
//  Banco
//
//  Created by ios4584 on 09/08/14.
//  Copyright (c) 2014 Tiarê Balbi. All rights reserved.
//

#import "BradescoViewController.h"
#import "Conta.h"


@interface BradescoViewController ()

@end

@implementation BradescoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    self.campo.keyboardType = UIKeyboardTypeNumberPad;
    
    self.cp = [Conta new];
    self.cp.banco = @"Teste";
    
    self.cc = [Conta new];
    
    [self.cc depositar:100];
    [self.cc transferir:12 paraConta:self.cp];
    
    NSLog(@" MSG: %@", [self.campo text]);
    
    [self atualizarTela];
}
- (void) atualizarTela
{
    self.texto.text = [NSString stringWithFormat:@"R$ %.2f", self.cc.saldo];
    self.textoCp.text = [NSString stringWithFormat:@"R$ %.2f", self.cp.saldo];
    
    self.campo.text = @"";
}

-(IBAction) sacar
{
    BOOL retorno = [self.cc sacar: [self.campo.text floatValue]];
    if(retorno == YES) {
        self.notificacao.text = @"Saque realizado com sucesso";
        self.notificacao.textColor = [UIColor greenColor];
        
        NSLog(@"OK!");
    }else {
        self.notificacao.textColor = [UIColor redColor];
        self.notificacao.text = @"Ops!! Sem saldo";
        NSLog(@"Sem Saldo");
    }
    
    [self atualizarTela];
    
}

-(IBAction) depositar
{
    float valor = [self.campo.text floatValue];
    [self.cc depositar: valor];
    [self atualizarTela];
}

-(IBAction) transferir
{
    BOOL retorno = [self.cc transferir:[self.campo.text floatValue] paraConta:self.cp];
    if(retorno) {
        self.notificacao.text = @"Transf. Realizada!!";
        self.notificacao.textColor = [UIColor blueColor];
        NSLog(@"OK!");
    }else{
        self.notificacao.text = @"Erro ao Transf.!!";
        self.notificacao.textColor = [UIColor redColor];
        NSLog(@"Erro ao trans...!");
    }
    
    [self atualizarTela];
}

-(IBAction)sacarCp
{
    BOOL retorno = [self.cp transferir:[self.campo.text floatValue] paraConta:self.cc];
    if(retorno) {
        self.notificacao.text = @"Transf. Realizada!!";
        self.notificacao.textColor = [UIColor blueColor];
        NSLog(@"OK!");
    }else{
        self.notificacao.text = @"Erro ao Transf.!!";
        self.notificacao.textColor = [UIColor redColor];
        NSLog(@"Erro ao trans...!");
    }
    
    [self atualizarTela];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end