//
//  TBBMainViewController.m
//  CalcCaelum
//
//  Created by Tiarê Balbi Bonamini on 8/10/14.
//  Copyright (c) 2014 Tiarê Balbi. All rights reserved.
//

#import "TBBMainViewController.h"

@interface TBBMainViewController ()

@end

@implementation TBBMainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    return self;
}
- (IBAction)nextField:(id)sender {
    [self.num2 becomeFirstResponder];
}
- (IBAction)closeKeyboard:(id)sender {
    [self.view endEditing:true];
    [self processarCalculo];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.num1.keyboardType = UIKeyboardTypeDecimalPad;
    self.num2.keyboardType = UIKeyboardTypeDecimalPad;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)calcular:(id)sender {
    [self processarCalculo];
}

-(void) processarCalculo
{
    float valor1 = [self.num1.text floatValue];
    float valor2 = [self.num2.text floatValue];
    self.resultado.text = [NSString stringWithFormat:@" %.2f", valor1+valor2];
}
@end
