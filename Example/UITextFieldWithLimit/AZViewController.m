//
//  AZViewController.m
//  UITextFieldWithLimit
//
//  Created by azu on 08/14/2014.
//  Copyright (c) 2014 azu. All rights reserved.
//

#import "AZViewController.h"

@interface AZViewController ()
@property(weak, nonatomic) IBOutlet UITextFieldWithLimit *limitedTextField;
@end

@implementation AZViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    self.limitedTextField.maxLength = @15;
    // optional delegate
    self.limitedTextField.limitDelegate = self;
}

- (void)textFieldLimit:(UITextFieldWithLimit *) textFieldLimit didReachLimitWithLastEnteredText:(NSString *) text inRange:(NSRange) range {
    NSLog(@"%s", sel_getName(_cmd));
}

- (void)textFieldLimit:(UITextFieldWithLimit *) textFieldLimit didWentOverLimitWithDisallowedText:(NSString *) text inDisallowedRange:(NSRange) range {
    NSLog(@"%s", sel_getName(_cmd));
}


@end
