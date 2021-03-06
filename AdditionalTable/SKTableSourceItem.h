//
//  SKTableSourceItem.h
//  AdditionalTable
//
//  Created by Limitation on 7/8/18.
//  Copyright © 2018 Serhii K. All rights reserved.

#import <Foundation/Foundation.h>
#import "SKTitleProvider.h"
#import "SKCheckInOutAvailable.h"

/*
 It's base abstract class
 all protocol methods should be present in descenders
 */
@interface SKTableSourceItem : NSObject <SKTitleProvider, SKCheckInOutAvailable>

@end
