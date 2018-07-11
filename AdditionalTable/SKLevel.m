//
//  SKLevel.m
//  AdditionalTable
//
//  Created by Serhii K on 7/4/18.
//  Copyright © 2018 Serhii K. All rights reserved.
//

#import "SKLevel.h"
#import "SKElement.h"

@interface SKLevel() {
    NSString *kLevelCellCheckAll;
    NSString *kLevelCellCheckNone;
}

@end

@implementation SKLevel


- (instancetype)initWithTitle:(NSString *)title
                    dataArray:(NSMutableArray <SKTableSourceItem *> *)dataArray
             addOptionEnabled:(BOOL)addOptionEnabled {
    self = [super init];
    if (self) {
        _title = title;
        _dataArray = dataArray;
        _addOpitonEnabled = addOptionEnabled;
        
        kLevelCellCheckAll =  @"Check All";
        kLevelCellCheckNone = @"Check None";
    }

    return self;
}


- (instancetype)init {
    NSAssert(NO, @"Allowed to use initWithTitle:data:addOptionEnabled: initializer only");
    return nil;
}


- (NSString *)description {
    NSMutableString *mutableString = [[NSMutableString alloc] init];
    for (SKTableSourceItem *object in self.dataArray) {
        [mutableString appendFormat:@"%@\n", object.description];
    }
    NSString *result = [NSString stringWithFormat:(@"%@ ->\n%@"), self.title, mutableString];

    return result;
}


- (NSUInteger)numberOfCheckedElementsWithTotal:(NSUInteger *)total {
    // There is place for performance improvements
    // can be computed only if changes occures
    // instead of computating each time
    NSInteger result = 0;
    
    for (SKTableSourceItem *object in self.dataArray) {
        if ([object isKindOfClass:SKLevel.class]) {
            result+=[((SKLevel *)object) numberOfCheckedElementsWithTotal:total];
        } else if ([object isKindOfClass:SKElement.class]) {
            if (((SKElement *)object).checked) {
                result++;
            }
            *total = *total + 1;
        } else {
            NSLog(@"Unknown object type received for counting");
        }
    }
    
    return result;
}


- (BOOL)addItem:(nonnull SKTableSourceItem *)item {
    BOOL result = YES;
    if ([self.dataArray containsObject:item]) {
        result = NO;
        NSLog(@"Object %@ is already present in %@", item, self);
    } else {
        [self.dataArray addObject:item];
        result = YES;
    }
    
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
    // Comparing by dataArray and title properties
    if ([self.dataArray isEqual:((SKLevel *)other).dataArray] &&
        [self.title isEqual:((SKLevel *)other).title]) {
        return YES;
    }
    
    return NO;
}


- (NSUInteger)hash {
    NSUInteger result = self.dataArray.hash ^ self.title.hash;
    return result;
}


#pragma mark - <CheckInOutAvailable>

- (void)checkIn {
    for (SKTableSourceItem *object in self.dataArray) {
        [object checkIn];
    }
}


- (void)checkOut {
    for (SKTableSourceItem *object in self.dataArray) {
        [object checkOut];
    }
}


- (BOOL)isAnyCheckedIn {
    BOOL result = NO;
    for (SKTableSourceItem *object in self.dataArray) {
        if ([object isKindOfClass:SKLevel.class]) {
            result = [object isAnyCheckedIn];
        } else if ([object isKindOfClass:SKElement.class]) {
            if (((SKElement *)object).checked) {
                result = YES;
                break;
            }
        }
    }
    
    return result;
}


- (NSString *)getTitleForCheckInOut {
    NSString *result = [self isAnyCheckedIn] ? kLevelCellCheckNone : kLevelCellCheckAll;
    return result;
}


@end
