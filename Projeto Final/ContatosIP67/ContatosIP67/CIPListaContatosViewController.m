//
//  CIPListaContatosViewController.m
//  ContatosIP67
//
//  Created by Osni Oliveira on 28/11/12.
//  Copyright (c) 2012 Osni Oliveira. All rights reserved.
//

#import "CIPListaContatosViewController.h"
#import "CIPFormularioContatoViewController.h"
#import "CIPContatoTableViewCell.h"
#import "CIPContato.h"

@implementation CIPListaContatosViewController

- (id)init {
    self = [super init];
    
    if (self) {
        UIImage *imagemTabItem = [UIImage imageNamed:@"lista-contatos.png"];
        UITabBarItem *tabItem = [[UITabBarItem alloc] initWithTitle:@"Contatos" image:imagemTabItem tag:0];
        self.tabBarItem = tabItem;
        
        self.navigationItem.title = @"Contatos";
        
        UIBarButtonItem *botaoExibirFormulario = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(exibeFormulario)];
        self.navigationItem.rightBarButtonItem = botaoExibirFormulario;
        self.navigationItem.leftBarButtonItem = self.editButtonItem;
        
        self.linhaDestaque = -1;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(exibeMaisAcoes:)];
    [self.tableView addGestureRecognizer:lpgr];
    
    
    [self.tableView registerNib:[UINib nibWithNibName:@"CIPContatoTableViewCell" bundle:nil]
                               forCellReuseIdentifier:@"marto"];
    self.tableView.rowHeight = 60;
}

- (void)viewWillAppear:(BOOL)animated {
    [self.tableView reloadData];
}

- (void)viewDidAppear:(BOOL)animated {
    if (self.linhaDestaque >= 0) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.linhaDestaque inSection:0];
        [self.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionBottom];
        [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionNone animated:YES];
        self.linhaDestaque = -1;
    }
}

- (void)exibeFormulario {
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Exibir Formulário" message:@"Isso é um UIAlertView" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
//    [alert show];
    
    CIPFormularioContatoViewController *form = [[CIPFormularioContatoViewController alloc] init];
    form.delegate = self;
    form.contexto = self.contexto;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:form];
    
    // Deprecado no iOS 6
//    [self presentModalViewController:form animated:YES];
    [self presentViewController:nav animated:YES completion:nil];
}

#pragma mark -
#pragma mark UITableView messages

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.contatos count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CIPContato *contato = [self.contatos objectAtIndex:indexPath.row];
    
    CIPContatoTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"marto"];
    [cell configuraComContato:contato];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.contatos removeObjectAtIndex:indexPath.row];
        NSArray *indexPaths = [NSArray arrayWithObject:indexPath];
        [tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
    }
}

//- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
//    CIPContato *contato = [self.contatos objectAtIndex:sourceIndexPath.row];
//    [self.contatos removeObjectAtIndex:sourceIndexPath.row];
//    [self.contatos insertObject:contato atIndex:destinationIndexPath.row];
//}
//

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CIPContato *contato = [self.contatos objectAtIndex:indexPath.row];
    
    CIPFormularioContatoViewController *form = [[CIPFormularioContatoViewController alloc] initWithContato:contato];
    form.delegate = self;
    
    [self.navigationController pushViewController:form animated:YES];
}

#pragma mark -
#pragma mark CIPListaConatosProtocol implementation

- (void)contatoAdicionado:(CIPContato *)contato {
    [self.contatos addObject:contato];
    
    // Ordenação
//    NSSortDescriptor *sd = [NSSortDescriptor sortDescriptorWithKey:@"nome" ascending:YES];
//    [self.contatos sortUsingDescriptors:[NSArray arrayWithObject:sd]];
    [self.contatos sortUsingComparator:^NSComparisonResult(id obj1, id obj2){
        CIPContato *contato1 = obj1;
        CIPContato *contato2 = obj2;
        return [contato1.nome compare:contato2.nome];
    }];
    
    self.linhaDestaque = [self.contatos indexOfObject:contato];
    [self.tableView reloadData];
}

- (void)contatoAtualizado:(CIPContato *)contato {
    self.linhaDestaque = [self.contatos indexOfObject:contato];
}

#pragma mark -
#pragma mark Gesture Recognizer

- (void)exibeMaisAcoes:(UIGestureRecognizer *)gestureRecognizer {
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        CGPoint ponto = [gestureRecognizer locationInView:self.tableView];
        NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:ponto];
        CIPContato *contato = [self.contatos objectAtIndex:indexPath.row];
        
        contatoSelecionado = contato;
        
        UIActionSheet *opcoes = [[UIActionSheet alloc] initWithTitle:contato.nome delegate:self cancelButtonTitle:@"Cancelar" destructiveButtonTitle:nil otherButtonTitles:@"Ligar", @"Enviar Email", @"Visualizar Site", @"Abrir Mapa", nil];
        
//        [opcoes showInView:self.view];
        [opcoes showFromTabBar:self.tabBarController.tabBar];
    }
}

#pragma mark -
#pragma mark UIActionSheetDelegate

- (void)abrirAplicativoComURL:(NSString *)url {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}

- (void)ligar {
    UIDevice *device = [UIDevice currentDevice];
    if ([device.model isEqualToString:@"iPhone"]) {
        NSString *numero = [NSString stringWithFormat:@"tel:%@", contatoSelecionado.telefone];
        [self abrirAplicativoComURL:numero];
    }
    else {
        [[[UIAlertView alloc] initWithTitle:@"Impossível fazer ligação" message:@"Seu dispositivo não é um iPhone" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
    }
}

- (void)enviarEmail {
    if ([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController *enviadorEmail = [[MFMailComposeViewController alloc] init];
        enviadorEmail.mailComposeDelegate = self;
        
        [enviadorEmail setToRecipients:[NSArray arrayWithObject:contatoSelecionado.email]];
        [enviadorEmail setSubject:@"Caelum"];
        
        [self presentViewController:enviadorEmail animated:YES completion:nil];
    }
    else {
        [[[UIAlertView alloc] initWithTitle:@"Oops..." message:@"You cannot send an email" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
    }
}

- (void)abrirSite {
    NSString *url = contatoSelecionado.site;
    [self abrirAplicativoComURL:url];
}

- (void)mostrarMapa {
    NSString *url = [[NSString stringWithFormat:@"http://maps.google.com/maps?q=%@", contatoSelecionado.endereco] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [self abrirAplicativoComURL:url];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        case 0:
            [self ligar];
            break;
            
        case 1:
            [self enviarEmail];
            break;
            
        case 2:
            [self abrirSite];
            break;
            
        case 3:
            [self mostrarMapa];
            break;
            
        default:
            break;
    }
}

#pragma mark -
#pragma mark MFMailComposeViewControllerDelegate

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
