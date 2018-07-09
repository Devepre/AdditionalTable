//
//  SKLevel.h
//  AdditionalTable
//
//  Created by Serhii K on 7/4/18.
//  Copyright © 2018 Serhii K. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SKTableSourceItem.h"

@interface SKLevel : SKTableSourceItem

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSMutableArray<SKTableSourceItem *> *dataArray;
@property (assign, nonatomic, getter=isAddOptionEnabled) BOOL addOpitonEnabled;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithTitle:(NSString *)title
                         dataArray:(NSMutableArray<SKTableSourceItem *> *)dataArray
             addOptionEnabled:(BOOL)addOptionEnabled NS_DESIGNATED_INITIALIZER;

- (NSUInteger)numberOfCheckedElementsWithTotal:(NSUInteger *)total;

- (void)checkIn;
- (BOOL)addItem:(nonnull SKTableSourceItem *)item;

@end
