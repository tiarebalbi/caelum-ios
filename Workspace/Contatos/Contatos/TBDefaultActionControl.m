//
//  TBActionControl.m
//  Contatos
//
//  Created by ios4584 on 23/08/14.
//  Copyright (c) 2014 Tiarê Balbi. All rights reserved.
//

#import "TBDefaultActionControl.h"
#import "TBContato.h"
#import <MessageUI/MessageUI.h>
#import "TBMailServiceControl.h"

@implementation TBDefaultActionControl

- (id) init
{
    if(self = [super init]) {
        
    }
    
    return self;
}

- (id) initWithView : (UITableViewController *) tableView
{
    
    if(self = [super init]) {
        self.tableView = tableView;
    }
    
    return self;
}

- (id) initWithContato : (TBContato *) contato
{
    
    if(self = [super init]) {
        self.contato = contato;
    }
    
    return self;
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            [self excluir];
            break;
        case 1:
            [self ligar];
            break;
        case 2:
            // Com problema
            //[self enviarEmail];
            break;
        case 3:
            [self abrirSite];
            break;
        case 4:
            [self mostrarMapa];
            break;
        default:
            break;
    }
}

- (void) ligar
{
    NSLog(@"Ligando...");
    
    // Simplificando esta verificação usando category
    // UIDevice *device = [UIDevice currentDevice];
    // if([device.model isEqualToString:@"iPhone"]) {
    
    if([UIDevice isIPhone]) {
        [self abrirUrl: [NSString stringWithFormat:@"Tel.: %@", self.contato.telefone]];
    }else {
        [[[UIAlertView alloc] initWithTitle:@"Notificação"
                                    message:@"Você não pode realizar ligação deste dispositivo"
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil] show];
    }
}

- (void) abrirSite
{
    NSLog(@"Abrindo site...");
    NSString *url = self.contato.site;
    [self abrirUrl:url];
}

- (void) enviarEmail
{
    NSLog(@"Enviando Email...");
    TBMailServiceControl *mail = [[TBMailServiceControl alloc] initWithView : self.tableView ];
    if([mail enviarPara:self.contato.email comAssunto:@"Caelum" comMensagem:@"Seus dados de contato (Teste)"]) {
        [self.tableView presentViewController:mail.enviador animated:YES completion:nil];
    }else {
        [[[UIAlertView alloc] initWithTitle:@"Notificação"
                                    message:@"Você precisa ter um e-mail configurado no seu telefone."
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil] show];
    }
    
}

- (void) mostrarMapa
{
    NSLog(@"Mostrando Mapa...");
    NSString *endereco = [[NSString stringWithFormat:@"http://maps.google.com/maps?q=%@", self.contato.endereco] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [self abrirUrl:endereco];
}

- (void) excluir
{
    NSLog(@"Excluindo...");
}


- (void) abrirUrl : (NSString *) url
{
    UIApplication *boss = [UIApplication sharedApplication];
    [boss openURL: [NSURL URLWithString:url]];
}

@end
