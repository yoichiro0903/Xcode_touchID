//
//  ViewController.m
//  touchID
//
//  Created by WatanabeYoichiro on 2014/11/16.
//  Copyright (c) 2014年 YoichiroWatanabe. All rights reserved.
//

#import "ViewController.h"
@import LocalAuthentication;

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self authentication];
}

- (void)authentication{
    LAContext *context = [[LAContext alloc] init];
    NSError *error;
    BOOL success;
    //whether device is supported by touchID or not, this return BOOL
    //"LAPolicyDeviceOwnerAuthenticationWithBiometrics" means fingerprints authentication
    success = [context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error];
    if (success) {
        NSLog(@"Supported");
        [self evaluatePolicy];
        } else {
        NSLog(@"Not Supported");
        return;
        }
}

- (void)evaluatePolicy
{
    LAContext *context = [[LAContext alloc] init];
    //Show TouchID dialogue
    [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:@"Release Lock" reply:^(BOOL success, NSError *authenticationError)
     {
         if (success) {
             NSLog(@"TouchID OK");
             UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"FingerPrints authentication" message:@"Successed" preferredStyle:UIAlertControllerStyleAlert];
             [alert addAction:[UIAlertAction actionWithTitle:@"Okey" style:UIAlertActionStyleDefault handler:nil]];
             [self presentViewController:alert animated:YES completion:nil];
         } else {
             //selected passcode or failed 3 times in touchIDs
             NSLog(@"passcode please");
             UIAlertController *errorAlert = [UIAlertController alertControllerWithTitle:@"FingerPrints authentication" message:@"failed" preferredStyle:UIAlertControllerStyleAlert];
             [self presentViewController:errorAlert animated:YES completion:nil];
         }
     }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end