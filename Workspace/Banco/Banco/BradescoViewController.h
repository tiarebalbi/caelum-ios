//
//  BradescoViewController.h
//  Banco
//
//  Created by ios4584 on 09/08/14.
//  Copyright (c) 2014 Tiarê Balbi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Conta.h"


@interface BradescoViewController : UIViewController

@property (strong, nonatomic) Conta *cc;
@property (strong, nonatomic) Conta *cp;

@property (weak, nonatomic) IBOutlet UITextField *campo;
@property (weak, nonatomic) IBOutlet UILabel *texto;
@property (weak, nonatomic) IBOutlet UILabel *textoCp;

@property (weak, nonatomic) IBOutlet UILabel *notificacao;

@end
