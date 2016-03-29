//
//  ViewController.h
//  PHAVR
//
//  Created by Abir Chatterjee on 27/03/16.
//  Copyright © 2016 Abir Chatterjee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ServerConnection : NSObject

@property (strong, nonatomic) NSDictionary *rawDataSet;
@property (nonatomic, strong)UIActivityIndicatorView *activityIndicator;
+ (id) sharedManager;

-(void)startAPIWithParameters:(NSDictionary*)parameters withURL:(NSString*)prefixUrl WithTypePOST:(BOOL)isPOST withloader:(BOOL)isLoader withCallerObj:(id)callObj;

@end
