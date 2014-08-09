//
//  BancoViewController.h
//  Banco
//
//  Created by ios4584 on 09/08/14.
//  Copyright (c) 2014 Tiarê Balbi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BancoViewController : UIViewController

@property IBOutlet UILabel *saldo;
@property IBOutlet UITextField *input;

@property float saldoAtual;

@end
