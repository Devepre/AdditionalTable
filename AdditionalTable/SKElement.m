//
//  SKElement.m
//  AdditionalTable
//
//  Created by Serhii K on 7/4/18.
//  Copyright © 2018 Serhii K. All rights reserved.
//

#import "SKElement.h"

@implementation SKElement


- (instancetype)initWithTitle:(NSString *)title
                   dataObject:(nonnull id)dataObject
                      checked:(BOOL)checked {
    self = [super init];
    if (self) {
        _title = title;
        _checked = checked;
        _dataObject = dataObject;
    }
    
    return self;
}


- (instancetype)init {
    NSAssert(NO, @"Allowed to use initWithTitle:checked: initializer only");
    return nil;
}


- (NSString *)description {
    NSString *result = [NSString stringWithFormat:(@"%@ [%@] -> %@"),
                        self.title,
                        self.dataObject,
                        self.checked ? @"YES" : @"NO"];
    return result;
}


#pragma mark - Equality

- (BOOL)isEqual:(id)other {
    if (other == self) {
        return YES;
    }
    if (!other || ![other isKindOfClass:[self class]]) {
        return NO;
    }
    // Comparting by dataObject property
    if ([self.dataObject isEqual:((SKElement *)other).dataObject]) {
        return YES;
    }
    
    return NO;
}


- (NSUInteger)hash {
    NSUInteger result = self.dataObject.hash;
    return result;
}


#pragma mark - <CheckInOutAvailable>

- (void)checkIn {
    self.checked = YES;
}


- (void)checkOut {
    self.checked = NO;
}

@end
