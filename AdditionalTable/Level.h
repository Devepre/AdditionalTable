//
//  Level.h
//  AdditionalTable
//
//  Created by Serhii K on 7/4/18.
//  Copyright © 2018 Serhii K. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TableSourceItem.h"

@interface Level : TableSourceItem

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSMutableArray<TableSourceItem *> *data;
@property (assign, nonatomic, getter=isAddOptionEnabled) BOOL addOpitonEnabled;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithTitle:(NSString *)title
                         data:(NSMutableArray<TableSourceItem *> *)data
             addOptionEnabled:(BOOL)addOptionEnabled NS_DESIGNATED_INITIALIZER;
- (NSUInteger)numberOfCheckedElementsWithTotal:(NSUInteger *)total;

- (void)checkIn;

@end
