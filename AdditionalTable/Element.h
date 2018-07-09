//
//  Element.h
//  AdditionalTable
//
//  Created by Serhii K on 7/4/18.
//  Copyright © 2018 Serhii K. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TableSourceItem.h"

@interface Element : TableSourceItem

@property (strong, nonatomic) NSString *title;
@property (assign, nonatomic, getter=isChecked) BOOL checked;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithTitle:(NSString *)title
                      checked:(BOOL)checked NS_DESIGNATED_INITIALIZER;

@end
