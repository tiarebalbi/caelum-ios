//
//  CIPFormularioContatoViewController.m
//  ContatosIP67
//
//  Created by Osni Oliveira on 28/11/12.
//  Copyright (c) 2012 Osni Oliveira. All rights reserved.
//

#import "CIPFormularioContatoViewController.h"
#import "CIPContato.h"
#import <CoreLocation/CoreLocation.h>

@interface CIPFormularioContatoViewController ()

- (CIPContato *)pegaDadosDoFormulario;
- (void)escondeFormulario;
- (void)criaContato;
- (void)atualizaContato;

@end

@implementation CIPFormularioContatoViewController

- (id)init {
    self = [super init];
    
    if (self) {
        self.navigationItem.title = @"Cadastro";
        
        UIBarButtonItem *cancela = [[UIBarButtonItem alloc] initWithTitle:@"Cancela" style:UIBarButtonItemStylePlain target:self action:@selector(escondeFormulario)];
        self.navigationItem.leftBarButtonItem = cancela;
        
        UIBarButtonItem *adiciona = [[UIBarButtonItem alloc] initWithTitle:@"Adiciona" style:UIBarButtonItemStylePlain target:self action:@selector(criaContato)];
        self.navigationItem.rightBarButtonItem = adiciona;
    }
    
    return self;
}

- (id)initWithContato:(CIPContato *)contato {
    self = [super init];
    
    if (self) {
        self.contato = contato;
        
        self.navigationItem.title = @"Alteração";
        
        UIBarButtonItem *confirmar = [[UIBarButtonItem alloc] initWithTitle:@"Confirmar" style:UIBarButtonItemStylePlain target:self action:@selector(atualizaContato)];
        self.navigationItem.rightBarButtonItem = confirmar;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIScrollView *scrollView = (UIScrollView *)self.view;
    scrollView.contentSize = self.view.frame.size;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tecladoApareceu:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tecladoSumiu:) name:UIKeyboardWillHideNotification object:nil];
    
    if (self.contato) {
        self.nome.text = self.contato.nome;
        self.telefone.text = self.contato.telefone;
        self.email.text = self.contato.email;
        self.latitude.text = [self.contato.latitude stringValue];
        self.longitude.text = [self.contato.longitude stringValue];
        self.endereco.text = self.contato.endereco;
        self.site.text = self.contato.site;
        
        if (self.contato.foto) {
            [self.botaoFoto setImage:self.contato.foto forState:UIControlStateNormal];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    // http://stackoverflow.com/questions/12603336/ios6-viewdidunload-deprecated
    //    if (self.view.window) {
    //        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    //        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    //    }
}

- (void)dealloc {
    // http://stackoverflow.com/questions/12603336/ios6-viewdidunload-deprecated
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark -
#pragma mark Helper methods

- (CIPContato *)pegaDadosDoFormulario {
    if (!self.contato) {
        self.contato = [NSEntityDescription insertNewObjectForEntityForName:@"Contato" inManagedObjectContext:self.contexto];
    }
    
    self.contato.nome = self.nome.text;
    self.contato.telefone = self.telefone.text;
    self.contato.email = self.email.text;
    self.contato.latitude = [NSNumber numberWithFloat:[self.latitude.text floatValue]];
    self.contato.longitude = [NSNumber numberWithFloat:[self.longitude.text floatValue]];
    self.contato.endereco = self.endereco.text;
    self.contato.site = self.site.text;
    
    if (self.botaoFoto.imageView.image) {
        self.contato.foto = self.botaoFoto.imageView.image;
    }
    
    return self.contato;
}

#pragma mark -
#pragma mark UIBarButtonItem actions

- (void)escondeFormulario {
    // Deprecado no iOS 6
    //    [self dismissModalViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)criaContato {
    CIPContato *contato = [self pegaDadosDoFormulario];
    
    if (self.delegate) {
        [self.delegate contatoAdicionado:contato];
    }
    
    // Deprecado no iOS 6
    //    [self dismissModalViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)atualizaContato {
    CIPContato *contato = [self pegaDadosDoFormulario];
    
    if (self.delegate) {
        [self.delegate contatoAtualizado:contato];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark NSNotificationCenter events

- (void)tecladoApareceu:(NSNotification *)notification {
    NSDictionary *info = [notification userInfo];
    
    // Acessando o tamanho do teclado e sua altura
    CGRect areaDoTeclado = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    CGSize tamanhoDoTeclado = areaDoTeclado.size;
    
    // Fazendo cast da propriedade ::view:: para uma ::UIScrollView::
    // Podemos fazer isso, pois alteramos a Custom Class da ::view:: pelo ::Interface Builder::
    UIScrollView *scrollView = (UIScrollView *)self.view;
    
    // Calculando margem extra que daremos para o scroll
    // Precisamos descontar o espaço ocupado pela Tab Bar, pois não há conteúdo sob ela
    UIEdgeInsets contentInset = UIEdgeInsetsMake(0.0, 0.0, tamanhoDoTeclado.height - self.tabBarController.tabBar.frame.size.height, 0.0);
    scrollView.contentInset = contentInset;
    scrollView.scrollIndicatorInsets = contentInset;
    
    if (self.campoAtual) {
        // Calculando a área visível da tela
        // O frame já desconsidera Status Bar, Navigation Bar e Tab Bar
        CGRect areaVisivel = self.view.frame;
        areaVisivel.size.height -= tamanhoDoTeclado.height;
        
        // ATENÇÃO: Pegadinha do Mallandro!!!
        // Quando a view é exibida direto, sem um Navigation Controller,
        // o ponto de origem self.view.frame.origin.y é 20 (abaixo da Status Bar)
        // Quando a view é exibida dentro de um Navigation Controller,
        // o ponto de origem self.view.frame.origin.y é... 0!
        // Isso afeta diretamente o cálculo da Área Visível acima
        // O Tab Bar Controller não afeta esse cálculo, pois não interfere na origem (0,0).
        
        // Validando se o teclado escondeu o campo ou não
        BOOL campoAtualSumiu = !CGRectContainsPoint(areaVisivel, self.campoAtual.frame.origin);
        
        if (campoAtualSumiu) {
            // Caso o teclado tenha escondido o campo, vamos subtrair
            // o tamanho do teclado ao "y" do ponto de origem do campo
            // Obs: o ponto de origem do campo já considera a Status Bar,
            // mas não considera a Navigation Bar, por isso adicionamos sua altura
            CGPoint pontoVisivel = CGPointMake(0.0f, self.campoAtual.frame.origin.y + self.navigationController.navigationBar.frame.size.height - tamanhoDoTeclado.height);
            [scrollView setContentOffset:pontoVisivel animated:YES];
        }
    }
}

- (void)tecladoSumiu:(NSNotification *)notification {
    UIScrollView *scrollView = (UIScrollView *)self.view;
    scrollView.contentInset = UIEdgeInsetsZero;
    scrollView.scrollIndicatorInsets = UIEdgeInsetsZero;
    [scrollView setContentOffset:CGPointZero animated:YES];
}

#pragma mark -
#pragma mark UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *imagemSelecionada = [info valueForKey:UIImagePickerControllerEditedImage];
    [self.botaoFoto setImage:imagemSelecionada forState:UIControlStateNormal];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -
#pragma mark UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 2) return; // Cancela
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    
    switch (buttonIndex) {
        case 0:
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            break;
            
        case 1:
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            break;
            
        default:
            break;
    }
    
    [self presentViewController:picker animated:YES completion:nil];
}

#pragma mark -
#pragma mark UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    self.campoAtual = textField;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    self.campoAtual = nil;
}

#pragma mark -
#pragma mark IBAction

- (IBAction)proximoElemento:(UITextField *)textField {
    NSInteger proximaTag = textField.tag + 1;
    UIResponder *proximoComponente = [self.view viewWithTag:proximaTag];
    
    if (proximoComponente) {
        [proximoComponente becomeFirstResponder];
    }
    else {
        [textField resignFirstResponder];
    }
}

- (IBAction)selecionaFoto:(id)sender {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        // Câmera disponível
        UIActionSheet *opcoes = [[UIActionSheet alloc] initWithTitle:@"Escolha a foto do contato" delegate:self cancelButtonTitle:@"Cancelar" destructiveButtonTitle:nil otherButtonTitles:@"Tirar foto", @"Escolher da biblioteca", nil];
        
        if (self.contato) {
            [opcoes showFromTabBar:self.tabBarController.tabBar];
        }
        else {
            [opcoes showInView:self.view];
        }
    }
    else {
        // Usar a biblioteca
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        picker.allowsEditing = YES;
        picker.delegate = self;
        [self presentViewController:picker animated:YES completion:nil];
    }
}

- (IBAction)buscarCoordenadas:(UIButton *)buscarCoordenadasButton {
    buscarCoordenadasButton.hidden = YES;
    [self.loading startAnimating];
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder geocodeAddressString:self.endereco.text completionHandler:^(NSArray *resultados, NSError *error) {
        if (error == nil && [resultados count] > 0) {
            CLPlacemark *resultado = [resultados objectAtIndex:0];
            CLLocationCoordinate2D coordenada = resultado.location.coordinate;
            self.latitude.text = [NSString stringWithFormat:@"%f", coordenada.latitude];
            self.longitude.text = [NSString stringWithFormat:@"%f", coordenada.longitude];
        }
        [self.loading stopAnimating];
        buscarCoordenadasButton.hidden = NO;
    }];
}

@end
