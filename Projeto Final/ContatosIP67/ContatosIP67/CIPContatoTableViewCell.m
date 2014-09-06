//
//  CIPContatoTableViewCell.m
//  ContatosIP67
//
//  Created by ios4584 on 06/09/14.
//  Copyright (c) 2014 Osni Oliveira. All rights reserved.
//

#import "CIPContatoTableViewCell.h"
#import "CIPContato.h"

@implementation CIPContatoTableViewCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) configuraComContato : (CIPContato *) contato
{
    self.nome.text = contato.nome;
    self.email.text = contato.email;
    self.telefone.text = contato.telefone;
}

@end
