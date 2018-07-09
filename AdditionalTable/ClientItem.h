//
//  Client.h
//  AdditionalTable
//
//  Created by Serhii K on 7/4/18.
//  Copyright © 2018 Serhii K. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TitleProvider.h"

@interface ClientItem : NSObject <TitleProvider>

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSObject *dataObject;
@property (strong, nonatomic) NSMutableArray<id<TitleProvider>> *emails;

- (instancetype)initWithTitle:(NSString *)title dataObject:(nonnull id)dataObject;

@end
