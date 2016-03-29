//
//  ViewController.m
//  PHAVR
//
//  Created by Abir Chatterjee on 27/03/16.
//  Copyright © 2016 Abir Chatterjee. All rights reserved.
// Changes

#import "ViewController.h"
#import "ServerConnection.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.parameters setValue:@"197" forKey:@"userid"];
    [self.connection startAPIWithParameters:self.parameters withURL:@"iphone/getPrivacy" WithTypePOST:YES withloader:YES withCallerObj:self];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
