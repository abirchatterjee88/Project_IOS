//
//  RootClass.m
//  PHAVR
//
//  Created by Abir Chatterjee on 29/03/16.
//  Copyright © 2016 Abir Chatterjee. All rights reserved.
//

#import "RootClass.h"

@interface RootClass ()

@end

@implementation RootClass

- (void)viewDidLoad {
    [super viewDidLoad];
    _parameters = [[NSMutableDictionary alloc] init];
    _appDel = [[UIApplication sharedApplication] delegate];
    _connection = [ServerConnection sharedManager];
       // Do any additional setup after loading the view.
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)succesfull{
    
}
-(void)failure{
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
