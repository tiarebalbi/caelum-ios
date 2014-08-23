//
//  UIDevice+Phone.m
//  Contatos
//
//  Created by ios4584 on 23/08/14.
//  Copyright (c) 2014 Tiarê Balbi. All rights reserved.
//

#import "UIDevice+Phone.h"

@implementation UIDevice (Phone)

+(BOOL) isIPhone
{
    UIDevice *device = [UIDevice currentDevice];
    if([device.model  isEqualToString:@"iPhone"]) {
        return YES;
    }
    
    return NO;
}

@end
