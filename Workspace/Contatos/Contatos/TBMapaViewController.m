//
//  TBMapaViewController.m
//  Contatos
//
//  Created by ios4584 on 30/08/14.
//  Copyright (c) 2014 Tiarê Balbi. All rights reserved.
//

#import "TBMapaViewController.h"
#import "TBFormularioViewController.h"
#import "TBContato.h"

#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface TBMapaViewController ()

@end

@implementation TBMapaViewController

- (id) init {
    if(self = [super init]) {
        self.title = @"Mapa";
        UIImage *icone = [UIImage imageNamed:@"Shape.png"];
        
        UITabBarItem *tabItem = [[UITabBarItem alloc] initWithTitle:@"Mapa" image:icone tag:0];
        self.tabBarItem = tabItem;
        
        NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
        [center addObserver:self selector:@selector(carregarFavorito:) name:@"mapa:favoritos" object:nil];
        
    }
    
    return self;
}

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
    [super viewDidLoad];
    
    MKUserTrackingBarButtonItem *button = [[MKUserTrackingBarButtonItem alloc] initWithMapView:self.mapa];
    self.navigationItem.leftBarButtonItem = button;
    
    self.mapa.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.mapa addAnnotations:self.contatos];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [self.mapa removeAnnotations:self.contatos];
}


-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) carregarFavorito : (id) sender
{
    NSLog(@"Recebeu o evento!!");
}

// MKAnnotationView = Pin no mapa;
- (MKAnnotationView *) mapView : (MKMapView *) map viewForAnnotation:(id<MKAnnotation>)annotation
{
    
    if([annotation isKindOfClass:[TBContato class]]){
       
        static NSString *key = @"pino";
        TBContato *contato = (TBContato *) annotation;
    
        MKPinAnnotationView *pino = (MKPinAnnotationView *)[map dequeueReusableAnnotationViewWithIdentifier:key];
        if(!pino) {
            pino = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:key];
            pino.pinColor = MKPinAnnotationColorPurple;
        }else{
            pino.annotation = contato;
        }
        
        pino.canShowCallout = YES;
    
        if(contato.imagem) {
            NSLog(@"PossuiFoto");
            UIImageView *imagemContato = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 32, 32) ];
            imagemContato.image = contato.imagem;
            pino.leftCalloutAccessoryView = imagemContato;

            // Inseri uma imagem no pino
            // pino.image = contato.imagem;
            pino.rightCalloutAccessoryView =[ UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        }
        return pino;
    }
    
    
    return nil;
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    TBContato *contato = (TBContato *) view.annotation;
    TBFormularioViewController *formController = [[TBFormularioViewController alloc] initWithContato:contato];
    
    UINavigationController *barrinha = [[UINavigationController alloc] initWithRootViewController:formController];
    //barrinha.navigationItem.leftBarButtonItem = [UI]
    [self presentViewController:barrinha animated:YES completion:nil];
}

@end
