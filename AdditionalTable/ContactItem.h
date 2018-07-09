//
//  ContactItem.h
//  AdditionalTable
//
//  Created by Serhii K on 7/4/18.
//  Copyright © 2018 Serhii K. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SKTitleProvider.h"

@interface ContactItem : NSObject<SKTitleProvider>

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *dataObject;

- (instancetype)initWithTitle:(NSString *)title email:(NSString *)email;

@end
