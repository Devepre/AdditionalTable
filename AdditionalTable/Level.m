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
                         dataArray:(NSMutableArray<TableSourceItem *> *)dataArray
             addOptionEnabled:(BOOL)addOptionEnabled {
    self = [super init];
    if (self) {
        _title = title;
        _dataArray = dataArray;
        _addOpitonEnabled = addOptionEnabled;
    }

    return self;
}


- (instancetype)init {
    NSAssert(NO, @"Allowed to use initWithTitle:data:addOptionEnabled: initializer only");
    return nil;
}


- (NSString *)description {
    NSMutableString *mutableString = [[NSMutableString alloc] init];
    for (TableSourceItem *object in self.dataArray) {
        [mutableString appendFormat:@"%@\n", [object description]];
    }
//    NSString *result = [NSString stringWithFormat:(@"%@ -> %@"), self.title, self.dataArray];
    NSString *result = [NSString stringWithFormat:(@"%@ ->\n%@"), self.title, mutableString];

    return result;
}


- (NSUInteger)numberOfCheckedElementsWithTotal:(NSUInteger *)total {
    // There is place for performance improvements
    // can be computaed only if changes occures
    // instead of computating each time
    NSInteger result = 0;
    
    for (TableSourceItem *object in self.dataArray) {
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
    for (TableSourceItem *object in self.dataArray) {
        [object checkIn];
    }
}


- (void)checkOut {
    for (TableSourceItem *object in self.dataArray) {
        [object checkOut];
    }
}


@end
