//
//  SKContactPickerViewController.m
//  AdditionalTable
//
//  Created by Limitation on 7/10/18.
//  Copyright © 2018 Serhii K. All rights reserved.
//

#import "SKContactPickerViewController.h"

@interface SKContactPickerViewController ()

@end

@implementation SKContactPickerViewController


- (void)viewWillDisappear:(BOOL)animated {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    SEL selector = @selector(contactPicker:viewWillDisappear:);
    if ([self.delegate respondsToSelector:selector]) {
        [self.delegate performSelector:selector
                            withObject:self
                            withObject:[NSNumber numberWithBool:animated]];
#pragma clang diagnostic pop
    }
}


- (void)viewDidDisappear:(BOOL)animated {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    SEL selector = @selector(contactPicker:viewDidDisappear:);
    if ([self.delegate respondsToSelector:selector]) {
        [self.delegate performSelector:selector
                            withObject:self
                            withObject:[NSNumber numberWithBool:animated]];
#pragma clang diagnostic pop
    }
}


@end
