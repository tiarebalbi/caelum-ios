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
    
    
    //UIButton *botao = [[UIButton alloc] initWithFrame:CGRectMake(50, 50, 50, 15)];
    //botao.backgroundColor = [UIColor redColor];
    //[self.view addSubview:botao];
    
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
    
    picker.delegate = self;
    picker.allowsEditing = YES;
    
    [self presentViewController:picker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *imagemSelecionada = [info valueForKey: UIImagePickerControllerEditedImage];
    [self.foto setImage:imagemSelecionada forState:UIControlStateNormal];
    [picker dismissViewControllerAnimated:true completion:nil];
}



@end
