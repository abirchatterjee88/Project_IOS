//
//  RootClass.h
//  PHAVR
//
//  Created by Abir Chatterjee on 29/03/16.
//  Copyright © 2016 Abir Chatterjee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "ServerConnection.h"

@interface RootClass : UIViewController

@property (strong, nonatomic) AppDelegate *appDel;
@property (strong, nonatomic) ServerConnection *connection;
@property (strong, nonatomic) NSMutableDictionary *parameters;
@property (strong, nonatomic) NSString *apiCallType;

-(void)succesfull;
-(void)failure;

@end
