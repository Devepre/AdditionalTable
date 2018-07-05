//
//  Element.m
//  AdditionalTable
//
//  Created by Serhii K on 7/4/18.
//  Copyright © 2018 Serhii K. All rights reserved.
//

#import "Element.h"

@implementation Element


- (instancetype)initWithTitle:(NSString *)title
             checked:(BOOL)checked {
    self = [super init];
    if (self) {
        _title = title;
        _checked = checked;
    }
    
    return self;
}


- (instancetype)init {
    NSAssert(NO, @"Allowed to use initWithTitle:checked: initializer only");
    
    return nil;
}


- (NSString *)description {
    return self.title;
}


@end
