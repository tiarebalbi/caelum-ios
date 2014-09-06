//
//  CIPContatosNoMapaViewController.m
//  ContatosIP67
//
//  Created by Osni Oliveira on 10/12/12.
//  Copyright (c) 2012 Osni Oliveira. All rights reserved.
//

#import "CIPContatosNoMapaViewController.h"
#import "CIPContato.h"

@interface CIPContatosNoMapaViewController ()

@end

@implementation CIPContatosNoMapaViewController

- (id)init {
    self = [super init];
    if (self) {
        UIImage *imagemTabItem = [UIImage imageNamed:@"mapa-contatos.png"];
        UITabBarItem *tabItem = [[UITabBarItem alloc] initWithTitle:@"Mapa" image:imagemTabItem tag:1];
        self.tabBarItem = tabItem;
        
        self.navigationItem.title = @"Localização";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    MKUserTrackingBarButtonItem *botaoLocalizacao = [[MKUserTrackingBarButtonItem alloc] initWithMapView:self.mapa];
    self.navigationItem.leftBarButtonItem = botaoLocalizacao;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.mapa addAnnotations:self.contatos];
}

- (void)viewDidDisappear:(BOOL)animated {
    [self.mapa removeAnnotations:self.contatos];
    [super viewDidDisappear:animated];
}

#pragma mark -
#pragma mark MKMapViewDelegate

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    
    static NSString * identifier = @"pino";
    MKPinAnnotationView *pino = (MKPinAnnotationView *)[self.mapa dequeueReusableAnnotationViewWithIdentifier:identifier];
    if (!pino) {
        pino = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
    }
    else {
        pino.annotation = annotation;
    }
    
    CIPContato *contato = (CIPContato *)annotation;
    pino.pinColor = MKPinAnnotationColorRed;
    pino.canShowCallout = YES;

    if (contato.foto) {
        UIImageView *imagemContato = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 32.0f, 32.0f)];
        imagemContato.image = contato.foto;
        pino.leftCalloutAccessoryView = imagemContato;
    }

    return pino;
}

@end
