//
//  Level.m
//  AdditionalTable
//
//  Created by Serhii K on 7/4/18.
//  Copyright © 2018 Serhii K. All rights reserved.
//

#import "Level.h"
#import "Element.h"

@implementation Level


- (instancetype)initWithTitle:(NSString *)title
                         data:(NSMutableArray<TableSourceItem *> *)data
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
    NSString *result = [NSString stringWithFormat:(@"%@ -> %@"), self.title, self.data];
    return result;
}


- (NSUInteger)numberOfCheckedElementsWithTotal:(NSUInteger *)total {
    // There is place for performance improvements
    // can be computaed only if changes occures
    // instead of computating each time
    NSInteger result = 0;
    
    for (TableSourceItem *object in self.data) {
        if ([object isKindOfClass:Level.class]) {
            result+=[((Level *)object) numberOfCheckedElementsWithTotal:total];
        } else if ([object isKindOfClass:Element.class]) {
            if (((Element *)object).checked) {
                result++;
            }
            *total = *total + 1;
        } else {
            NSLog(@"Unknown object type received for counting");
        }
    }
    
    return result;
}


#pragma mark - <CheckInOutAvailable>

- (void)checkIn {
    for (TableSourceItem *object in self.data) {
        [object checkIn];
    }
}


- (void)checkOut {
    for (TableSourceItem *object in self.data) {
        [object checkOut];
    }
}


@end
