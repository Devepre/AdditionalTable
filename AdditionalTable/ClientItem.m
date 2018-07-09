//
//  Client.m
//  AdditionalTable
//
//  Created by Serhii K on 7/4/18.
//  Copyright © 2018 Serhii K. All rights reserved.
//

#import "ClientItem.h"

@implementation ClientItem


- (instancetype)initWithTitle:(NSString *)title dataObject:(nonnull id)dataObject {
    self = [super init];
    if (self) {
        _title = title;
        _dataObject = dataObject;
    }
    return self;
}


- (NSString *)description {
    return self.title;
}


@end
