//
//  ViewController.h
//  PHAVR
//
//  Created by Abir Chatterjee on 27/03/16.
//  Copyright © 2016 Abir Chatterjee. All rights reserved.
//
#define kAPIURL @"https://flagworlds.com/"
#import "ServerConnection.h"

@implementation ServerConnection
static ServerConnection *singletonObject = nil;
+ (id)sharedManager {
    static ServerConnection *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}
- (id)init {
    if (self = [super init]) {
        //NSLog(@"enter");
        _activityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    }
    return self;
}

-(void)startAPIWithParameters:(NSDictionary*)parameters withURL:(NSString*)prefixUrl WithTypePOST:(BOOL)isPOST withloader:(BOOL)isLoader withCallerObj:(id)callObj{
    
    UIViewController *controller = (UIViewController*)callObj;
    if (isLoader) {
        [self addLoaderViewin:controller.view];
    }
    [controller.view setUserInteractionEnabled:NO];
    
    NSURLSessionConfiguration* connection = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:connection delegate:nil delegateQueue:nil];
    NSURL *url = [NSURL URLWithString: [kAPIURL stringByAppendingString:prefixUrl]];
    NSLog(@"URL==%@",url);
    NSLog(@"Parameters==%@",parameters);
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:60.0];

    NSString *boundary = @"---------------------------14737809831466499882746641449";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    if (isPOST) {
        [request setHTTPMethod:@"POST"];
        NSMutableData *body = [NSMutableData data];
        for (NSString *param in parameters) {
            [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", param] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"%@\r\n", [parameters objectForKey:param]] dataUsingEncoding:NSUTF8StringEncoding]];
        }
        [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [request setHTTPBody:body];
    }else{
        [request setHTTPMethod:@"GET"];
    }
    NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        _rawDataSet=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        SEL selector;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.activityIndicator stopAnimating];
            [self.activityIndicator removeFromSuperview];
        });
        
        [controller.view setUserInteractionEnabled:YES];
        if (_rawDataSet!=nil) {
            selector = NSSelectorFromString(@"succesfull");
            if ([callObj respondsToSelector:selector]) {
                ((void (*)(id, SEL))[callObj methodForSelector:selector])(callObj, selector);
            }
        }else{
            selector = NSSelectorFromString(@"failure");
            if ([callObj respondsToSelector:selector]) {
                ((void (*)(id, SEL))[callObj methodForSelector:selector])(callObj, selector);
            }
        }
        NSLog(@"jsonObject is %@",_rawDataSet);
    }];
    [postDataTask resume];
}
#pragma mark - Loader Activity
- (void)addLoaderViewin :(UIView*)loaderView {
    [self.activityIndicator setTranslatesAutoresizingMaskIntoConstraints:NO];
    self.activityIndicator.alpha = 1.0;
    [self.activityIndicator startAnimating];
    [self.activityIndicator setColor:[UIColor blackColor]];
    [self.activityIndicator hidesWhenStopped];
    [loaderView addSubview:self.activityIndicator];
    self.activityIndicator.tag=-121;
    
    NSLayoutConstraint *aiCenterX = [NSLayoutConstraint constraintWithItem:self.activityIndicator
                                                                 attribute:NSLayoutAttributeCenterX
                                                                 relatedBy:0
                                                                    toItem:loaderView
                                                                 attribute:NSLayoutAttributeCenterX
                                                                multiplier:1 constant:1];
    NSLayoutConstraint *aiCenterY = [NSLayoutConstraint constraintWithItem:self.activityIndicator
                                                                 attribute:NSLayoutAttributeCenterY
                                                                 relatedBy:0
                                                                    toItem:loaderView
                                                                 attribute:NSLayoutAttributeCenterY
                                                                multiplier:1 constant:1];
    [loaderView addConstraints:@[aiCenterX, aiCenterY]];
}

@end
