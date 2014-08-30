//
//  TBMapaViewController.h
//  Contatos
//
//  Created by ios4584 on 30/08/14.
//  Copyright (c) 2014 Tiarê Balbi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface TBMapaViewController : UIViewController

@property (nonatomic, weak) IBOutlet MKMapView *mapa;
@property (nonatomic, weak) NSMutableArray *contatos;

@end