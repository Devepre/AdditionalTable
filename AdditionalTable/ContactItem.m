//
//  ContactItem.m
//  AdditionalTable
//
//  Created by Serhii K on 7/4/18.
//  Copyright © 2018 Serhii K. All rights reserved.
//

#import "ContactItem.h"

@implementation ContactItem


- (instancetype)initWithTitle:(NSString *)title email:(NSString *)email{
    self = [super init];
    if (self) {
        _title = title;
        _dataObject = email;
    }
    return self;
}

- (NSString *)description {
    return self.title;
}


@end
