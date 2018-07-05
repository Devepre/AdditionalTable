//
//  EMail.h
//  AdditionalTable
//
//  Created by Serhii K on 7/4/18.
//  Copyright © 2018 Serhii K. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TitleProvider.h"

@interface EMail : NSObject<TitleProvider>

@property (strong, nonatomic) NSString *title;

- (instancetype)initWithTitle:(NSString *)title;

@end
