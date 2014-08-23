//
//  TBMailServiceControl.h
//  Contatos
//
//  Created by ios4584 on 23/08/14.
//  Copyright (c) 2014 Tiarê Balbi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MessageUI/MessageUI.h>

@interface TBMailServiceControl : NSObject<MFMailComposeViewControllerDelegate>

@property (weak, nonatomic) UITableViewController *tableView;
@property  (strong, nonatomic, readonly) MFMailComposeViewController *enviador;

- (id) initWithView : (UITableViewController *) tableView;
- (BOOL) enviarPara : (NSString *) email comAssunto : (NSString *) assunto comMensagem :(NSString *) mensagem;


@end
