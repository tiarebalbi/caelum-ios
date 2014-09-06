//
//  CIPContatoTableViewCell.h
//  ContatosIP67
//
//  Created by ios4584 on 06/09/14.
//  Copyright (c) 2014 Osni Oliveira. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CIPContato.h"

@interface CIPContatoTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *email;
@property (weak, nonatomic) IBOutlet UILabel *telefone;
@property (weak, nonatomic) IBOutlet UIImageView *imagem;
@property (weak, nonatomic) IBOutlet UILabel *nome;

- (void) configuraComContato : (CIPContato *) contato;
@end
