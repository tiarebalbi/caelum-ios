//
//  TBBMainViewController.h
//  CalcCaelum
//
//  Created by Tiarê Balbi Bonamini on 8/10/14.
//  Copyright (c) 2014 Tiarê Balbi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TBBMainViewController : UIViewController

@property (weak, nonatomic) IBOutlet UINavigationBar *nav;
@property (weak, nonatomic) IBOutlet UITextField *num1;
@property (weak, nonatomic) IBOutlet UITextField *num2;
@property (weak, nonatomic) IBOutlet UILabel *resultado;
@property (weak, nonatomic) IBOutlet UIButton *buttonCalcular;


- (IBAction)calcular:(id)sender;

@end
