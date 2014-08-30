//
//  TBMinhaLinhaTableViewCell.h
//  Contatos
//
//  Created by ios4584 on 23/08/14.
//  Copyright (c) 2014 Tiarê Balbi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TBMinhaLinhaTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nomeLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;

@property (weak, nonatomic) IBOutlet UIImageView *avatarIV;

@end
