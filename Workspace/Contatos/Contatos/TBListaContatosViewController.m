//
//  TBListaContatosViewController.m
//  Contatos
//
//  Created by ios4584 on 16/08/14.
//  Copyright (c) 2014 Tiarê Balbi. All rights reserved.
//

#import "TBListaContatosViewController.h"
#import "TBFormularioViewController.h"
#import "TBAppDelegate.h"
#import "TBContato.h"
#import "TBMinhaLinhaTableViewCell.h"
#import "TBMapaViewController.h"

#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@implementation TBListaContatosViewController

-(id) init
{
    if(self = [super init]) {
        self.title = @"Contatos";
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemAdd target:self action:@selector(addContato)];
        self.navigationItem.leftBarButtonItem = self.editButtonItem;
        
        UITabBarItem *tabItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemContacts tag:0 ];
        tabItem.title = @"Contatos";
        self.tabBarItem = tabItem;
        
        self.actionControl = [[TBDefaultActionControl alloc] initWithView:self];
        self.tableView.rowHeight = 60;

    }
    
    return self;
}
// Quantidade de sessões, cada sessão pode ter uma ou mais row's
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(editingStyle == UITableViewCellEditingStyleDelete) {
        [self.contatos removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TBContato *contato = self.contatos[indexPath.row];
    
    TBFormularioViewController *formVC = [[TBFormularioViewController alloc] initWithContato: contato];
    formVC.delegate = self;
    
    UINavigationController *barrinha = [[UINavigationController alloc] initWithRootViewController:formVC];
    [self presentViewController:barrinha animated:YES completion:nil];
    
}

// Lembrar caso seja possível apresentar custom table cell row
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    long quantidade = [self.contatos count];
    return quantidade;
}

- (UITableViewCell *) tableView : (UITableView *) table cellForRowAtIndexPath:(NSIndexPath *)path
{
    
    static NSString *apelido = @"maroto";
    
    TBMinhaLinhaTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier: apelido];
    
    if(!cell) {
        // cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier: apelido ];
        cell = [[TBMinhaLinhaTableViewCell alloc]  initWithStyle:UITableViewCellStyleDefault reuseIdentifier:apelido];
    }
    
    TBContato *linha = self.contatos[path.row];
    cell.nomeLabel.text = linha.nome;
    cell.emailLabel.text = linha.email;
    
    if(linha.imagem) {
        cell.imageView.image = linha.imagem;
    } else {
        cell.imageView.image = [UIImage imageNamed:@"Avatar"];
    }
    return cell;
}

- (void) exibirAcoes: (UIGestureRecognizer *) orelha
{
    if(orelha.state == UIGestureRecognizerStateBegan) {
        CGPoint p = [orelha locationInView:self.tableView];
        NSIndexPath *l = [self.tableView indexPathForRowAtPoint:p];
        
        TBContato *contato = self.contatos[l.row];
        self.contatoSelecionado = contato;
        self.actionControl.contato = contato;
        
        UIActionSheet *opcoes = [[UIActionSheet alloc] initWithTitle: [NSString stringWithFormat:@"Contato: %@", contato.nome]
                                                            delegate:self.actionControl
                                                   cancelButtonTitle:@"Cancelar"
                                              destructiveButtonTitle: @"Excluir ?" // Botão em destaque
                                                   otherButtonTitles:@"Ligar",@"Enviar E-Mail", @"Visualizar site", @"Abrir Mapa", nil];
        
        [opcoes showInView:self.view];

    }

}



-(void) viewDidLoad
{
    
    // Registro da cell customizada
    [self.tableView registerNib:[UINib nibWithNibName:@"TBMinhaLinhaTableViewCell" bundle:nil] forCellReuseIdentifier:@"maroto"];
    
    // Evento de gesto
    UILongPressGestureRecognizer *orelha = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(exibirAcoes:)];
    [self.tableView addGestureRecognizer:orelha];
    
    // Pull Request Refresh
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.backgroundColor = UIColorFromRGB(0x207E9A);
    self.refreshControl.tintColor = [UIColor whiteColor];
    [self.refreshControl addTarget:self
                            action:@selector(reloadData)
                  forControlEvents:UIControlEventValueChanged];

    // Mapa View Controller
    // TBMapaViewController *mapa = self.tabBarController.viewControllers[1];
    // [mapa addFavorito];
    
    // Exemplo de como acessar o AppDelegate de qualquer parte da aplicação
//    UIApplication *boss = [UIApplication sharedApplication];
//    TBAppDelegate *del = [boss delegate];
//    self.contatos = del.contatos;
    
}

- (void) reloadData
{
    // Reload table data
    [self.tableView reloadData];
    
    // End the refreshing
    if (self.refreshControl) {
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"dd/MM/yyyy, HH:mm"];
        NSString *title = [NSString stringWithFormat:@"Última Atualização: %@", [formatter stringFromDate:[NSDate date]]];
        NSDictionary *attrsDictionary = [NSDictionary dictionaryWithObject:[UIColor whiteColor]
                                                                    forKey:NSForegroundColorAttributeName];
        NSAttributedString *attributedTitle = [[NSAttributedString alloc] initWithString:title attributes:attrsDictionary];
        self.refreshControl.attributedTitle = attributedTitle;
        
        [self.refreshControl endRefreshing];
    }
}

- (void) viewWillAppear:(BOOL)animated
{
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center postNotificationName:@"mapa:favoritos" object:nil];
    
    [self.tableView reloadData];
    if(self.linhaDestaque && [self.contatos count] > 0) {
        NSIndexPath *path = [NSIndexPath indexPathForRow:[self.linhaDestaque intValue] inSection:0];
        
        [self.tableView selectRowAtIndexPath:path animated:true scrollPosition:UITableViewScrollPositionNone];
        [self.tableView scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionNone animated:true];
        self.linhaDestaque = nil;
    }

}

- (void) contatoAdicionado:(TBContato *)contato
{
    [self.contatos addObject:contato];
    
    long linha = [self.contatos indexOfObject:contato];
    self.linhaDestaque = [NSNumber numberWithLong:linha];
    
    NSLog(@"Contato Adicionado: %ld", linha);
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void) contatoAtualizado:(TBContato *)contato
{
    long linha = [self.contatos indexOfObject:contato];
    self.linhaDestaque = [NSNumber numberWithLong:linha];
    
    NSLog(@"Contato Atualizado: %ld", linha);
}

- (void) addContato
{
    TBFormularioViewController *formVC = [[TBFormularioViewController alloc] init];
    formVC.delegate = self;
    [self.navigationController pushViewController:formVC animated:YES];
}

@end
