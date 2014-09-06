//
//  TBFormularioViewController.m
//  Contatos
//
//  Created by ios4584 on 09/08/14.
//  Copyright (c) 2014 Tiarê Balbi. All rights reserved.
//

#import "TBFormularioViewController.h"
#import "TBContato.h"
#import "TPKeyboardAvoidingScrollView.h"


#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface TBFormularioViewController (ComPersistencia)

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
    
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName,nil]];
    
    self.campos = @[self.nome, self.telefone, self.email, self.endereco, self.site];
    
    self.telefone.keyboardType = UIKeyboardTypeNumberPad;
    self.email.keyboardType = UIKeyboardTypeEmailAddress;
    self.site.keyboardType = UIKeyboardTypeURL;
    
    if(self.selecionado)   {
        self.nome.text = self.selecionado.nome;
        self.email.text = self.selecionado.email;
        self.site.text = self.selecionado.site;
        self.endereco.text = self.selecionado.endereco;
        self.telefone.text = self.selecionado.telefone;
        self.longitude.text = [NSString stringWithFormat:@"%@", [self.selecionado.longitude stringValue]];
        self.latitude.text = [NSString stringWithFormat:@"%@", [self.selecionado.latitude stringValue]];
        
        
        if(self.selecionado.imagem) {
            [self.foto setImage:self.selecionado.imagem forState:UIControlStateNormal];
        }
    }
    
    NSLog(@"Tudo OK! %@",[TPKeyboardAvoidingScrollView class]);
    
    // Content Size
    self.fundo = (UIScrollView *) self.view;
    self.fundo.contentSize = self.fundo.frame.size;
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (IBAction)change:(UITextField *)sender {
    long posicao = [self.campos indexOfObject:sender];
    if(posicao == [self.campos count] -1) {
        [self.view endEditing:true];
    }else if(posicao < [self.campos count] -1) {
        UITextField *proximo = self.campos[posicao+1];
        [proximo becomeFirstResponder];
    }

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
    c.latitude = [NSNumber numberWithFloat:[self.latitude.text floatValue ]];
    c.longitude = [NSNumber numberWithFloat:[self.longitude.text floatValue ]];
    
    if(self.foto.imageView.image) {
        c.imagem = self.foto.imageView.image;
    }
    
}

-(void) atualizar
{ 
    [self pegaDadosDoFormEColocaNo:self.selecionado];
    [_delegate contatoAtualizado:self.selecionado];
    
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];

}

-(void) cadastrar {
    
    TBContato *contato = [TBContato new];
    
    [self pegaDadosDoFormEColocaNo:contato];
    [_delegate contatoAdicionado:contato];
    
    [self.view endEditing:YES];
    
    // Volta a view utilizando o modelo de transição
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (IBAction)selecionarImagem:(id)sender
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        NSLog(@"Camera");
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
    } else {
        NSLog(@"PhotoLibrary");
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    picker.allowsEditing = YES;
    picker.delegate = self;

    
    [self presentViewController:picker animated:YES completion:^ {
        NSLog(@"Abriu selec Image");
    }];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *imagemSelecionada = [info valueForKey: UIImagePickerControllerEditedImage];
    [self.foto setImage:imagemSelecionada forState:UIControlStateNormal];
    [picker dismissViewControllerAnimated:true completion:nil];
}



- (IBAction)carregarLocalizacao:(UIButton *) button {
    CLGeocoder *coder = [CLGeocoder new];
    NSLog(@"Iniciando solicitação de carregar ponto");
    
    button.hidden = YES;
    [self.indicator startAnimating];
    
    
    [coder geocodeAddressString:self.endereco.text completionHandler:^(NSArray *locations, NSError *error){
        NSLog(@"Pontos: %@", locations);
        
        if(locations) {
            CLPlacemark *local = locations[0];
            CLLocationCoordinate2D coordenada = local.location.coordinate;
            
            self.latitude.text = [NSString stringWithFormat:@"%f", coordenada.latitude];
            self.longitude.text = [NSString stringWithFormat:@"%f", coordenada.longitude];
        } else {
            [[[UIAlertView alloc] initWithTitle:@"Notificação"
                                        message:@"Não foi possível localizar as coordenadas do seu endereço."
                                       delegate:nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil] show];
        }
        
        [self.indicator stopAnimating];
        button.hidden = NO;
    }];
}
@end
