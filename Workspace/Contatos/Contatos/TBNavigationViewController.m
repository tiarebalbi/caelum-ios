//
//  TBNavigationViewController.m
//  Contatos
//
//  Created by Tiarê Balbi on 9/4/14.
//  Copyright (c) 2014 Tiarê Balbi. All rights reserved.
//

#import "TBNavigationViewController.h"
#import "JASidePanelController.h"
#import "TBListaContatosViewController.h"
#import "UIViewController+JASidePanel.h"

@interface TBNavigationViewController ()

@property (nonatomic, weak) UILabel *label;
@property (nonatomic, weak) UIButton *hide;
@property (nonatomic, weak) UIButton *show;

@end

@implementation TBNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	self.view.backgroundColor = [UIColor blueColor];
	
	UILabel *label  = [[UILabel alloc] init];
    label.font = [UIFont boldSystemFontOfSize:20.0f];
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor clearColor];
	label.text = @"Fechar";
	[label sizeToFit];
	label.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin;
    [self.view addSubview:label];
    self.label = label;
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.label.center = CGPointMake(floorf(self.sidePanelController.leftVisibleWidth/2.0f), 25.0f);
}

#pragma mark - Button Actions

- (void)_hideTapped:(id)sender {
    [self.sidePanelController setCenterPanelHidden:YES animated:YES duration:0.2f];
    self.hide.hidden = YES;
    self.show.hidden = NO;
}

- (void)_showTapped:(id)sender {
    [self.sidePanelController setCenterPanelHidden:NO animated:YES duration:0.2f];
    self.hide.hidden = NO;
    self.show.hidden = YES;
}

@end
