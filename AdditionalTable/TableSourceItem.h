//
//  TableSourceItem.h
//  AdditionalTable
//
//  Created by Limitation on 7/8/18.
//  Copyright © 2018 Serhii K. All rights reserved.

#import <Foundation/Foundation.h>
#import "TitleProvider.h"
#import "CheckInOutAvailable.h"

/*
 It's base abstract class
 all protocol methods should be present in descenders
 */
@interface TableSourceItem : NSObject <TitleProvider, CheckInOutAvailable>

@end
