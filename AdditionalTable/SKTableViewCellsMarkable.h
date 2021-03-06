//
//  SKTableViewCellsMarkable.h
//  AdditionalTable
//
//  Created by Serhii K on 7/10/18.
//  Copyright © 2018 Serhii K. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SKLevel;

@protocol SKTableViewCellsMarkable <NSObject>

- (void)markAllCellsForLevel:(SKLevel *)selectedLevel;

@end
