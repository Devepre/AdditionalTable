//
//  SKTitleProvider.h
//  AdditionalTable
//
//  Created by Serhii K on 7/4/18.
//  Copyright © 2018 Serhii K. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SKTitleProvider <NSObject>

@required
- (NSString *)title;
- (NSObject *)dataObject;

@end
