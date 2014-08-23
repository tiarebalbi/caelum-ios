//
//  TBMailServiceControl.m
//  Contatos
//
//  Created by ios4584 on 23/08/14.
//  Copyright (c) 2014 Tiarê Balbi. All rights reserved.
//

#import "TBMailServiceControl.h"
#import <MessageUI/MessageUI.h>


@implementation TBMailServiceControl

-(id) initWithView:(UITableViewController *)tableView
{
    
    return self;
}

- (BOOL) enviarPara : (NSString *) email comAssunto : (NSString *) assunto comMensagem :(NSString *) mensagem
{
    if([MFMailComposeViewController canSendMail]) {
        _enviador = [[MFMailComposeViewController alloc] init];
        _enviador.mailComposeDelegate = self;
        
        [_enviador setToRecipients:@[email]];
        [_enviador setSubject:assunto];
        [_enviador setMessageBody:mensagem isHTML:true];
        
        return YES;
    }
    
    return NO;
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    [self.tableView dismissViewControllerAnimated:TRUE completion:nil];
}

@end
