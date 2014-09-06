//
//  CIPContatosNoMapaViewController.h
//  ContatosIP67
//
//  Created by Osni Oliveira on 10/12/12.
//  Copyright (c) 2012 Osni Oliveira. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface CIPContatosNoMapaViewController : UIViewController <MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapa;

@property (weak) NSArray *contatos;

@end
