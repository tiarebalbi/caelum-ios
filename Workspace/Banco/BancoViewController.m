//
//  BancoViewController.m
//  Banco
//
//  Created by ios4584 on 09/08/14.
//  Copyright (c) 2014 Tiarê Balbi. All rights reserved.
//

#import "BancoViewController.h"

@interface BancoViewController ()

@end

@implementation BancoViewController

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
    self.saldoAtual = 100;
    
    NSString *saldoNaTela = [NSString stringWithFormat:@"R$ %.2f", self.saldoAtual];
    
    self.saldo.text = saldoNaTela;
}

- (IBAction)sacar
{
    NSString *valorTexto = self.input.text;
    float valor = [valorTexto floatValue];
    self.saldoAtual -= valor;
    self.input.text = @"";
    self.saldo.text =[NSString stringWithFormat:@"R$ %.2f", self.saldoAtual];
    
    NSLog(@"MSG: %@",[NSString stringWithFormat:@"Sacau: R$ %.2f", valor]);
}

- (IBAction)depositar
{
    NSString *valorTexto = self.input.text;
    float valor = [valorTexto floatValue];
    self.saldoAtual += valor;
    self.input.text = @"";
    self.saldo.text =[NSString stringWithFormat:@"R$ %.2f", self.saldoAtual];

    NSLog(@"MSG: %@",[NSString stringWithFormat:@"Depositou: R$ %.2f", valor]);
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

@end
