//
//  SKCheckInOutAvailable.h
//  AdditionalTable
//
//  Created by Limitation on 7/8/18.
//  Copyright © 2018 Serhii K. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SKCheckInOutAvailable <NSObject>

@required

- (void)checkIn;
- (void)checkOut;

@end
