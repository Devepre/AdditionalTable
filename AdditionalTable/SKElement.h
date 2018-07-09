//
//  SKElement.h
//  AdditionalTable
//
//  Created by Serhii K on 7/4/18.
//  Copyright © 2018 Serhii K. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SKTableSourceItem.h"

@interface SKElement : SKTableSourceItem

@property (strong, nonatomic) NSString *title;
@property (weak, nonatomic) NSObject *dataObject;
@property (assign, nonatomic, getter=isChecked) BOOL checked;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithTitle:(NSString *)title
                   dataObject:(nonnull id)dataObject
                      checked:(BOOL)checked NS_DESIGNATED_INITIALIZER;

@end
