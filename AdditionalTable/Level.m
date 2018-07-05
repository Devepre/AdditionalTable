//
//  Level.m
//  AdditionalTable
//
//  Created by Serhii K on 7/4/18.
//  Copyright © 2018 Serhii K. All rights reserved.
//

#import "Level.h"

@implementation Level


- (instancetype)initWithTitle:(NSString *)title
                         data:(NSArray<id<TitleProvider>> *)data
             addOptionEnabled:(BOOL)addOptionEnabled {
    self = [super init];
    if (self) {
        _title = title;
        _data = data;
        _addOpitonEnabled = addOptionEnabled;
    }

    return self;
}


- (instancetype)init {
    NSAssert(NO, @"Allowed to use initWithTitle:data:addOptionEnabled: initializer only");

    return nil;
}


- (NSString *)description {
    return self.title;
}


@end
