//
//  Level.h
//  AdditionalTable
//
//  Created by Serhii K on 7/4/18.
//  Copyright © 2018 Serhii K. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TitleProvider.h"

@interface Level : NSObject<TitleProvider>

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSArray<id<TitleProvider>> *data;
@property (assign, nonatomic, getter=isAddOptionEnabled) BOOL addOpitonEnabled;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithTitle:(NSString *)title data:(NSArray<id<TitleProvider>> *)data addOptionEnabled:(BOOL)addOptionEnabled NS_DESIGNATED_INITIALIZER;

@end
