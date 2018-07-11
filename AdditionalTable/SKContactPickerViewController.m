//
//  SKContactPickerViewController.m
//  AdditionalTable
//
//  Created by Limitation on 7/10/18.
//  Copyright © 2018 Serhii K. All rights reserved.
//

#import "SKContactPickerViewController.h"

@implementation SKContactPickerViewController

@dynamic delegate;


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    SEL selector = @selector(contactPicker:viewWillDisappear:);
    if ([self.delegate respondsToSelector:selector]) {
        [self.delegate contactPicker:self
                   viewWillDisappear:animated];
    }
}


- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    SEL selector = @selector(contactPicker:viewDidDisappear:);
    if ([self.delegate respondsToSelector:selector]) {
        [self.delegate contactPicker:self
                    viewDidDisappear:animated];
    }
}


@end
