//
//  SKSelfNavigableTableViewProxy.h
//  AdditionalTable
//
//  Created by Serhii K on 7/5/18.
//  Copyright © 2018 Serhii K. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "SKTableViewCellsMarkable.h"
#import "SKLevelTableViewCell.h"
#import "SKTitleProvider.h"
#import "SKLevel.h"

#import "SKSelfNavigableTableViewController.h"

@interface SKSelfNavigableTableViewProxy : NSObject <UITableViewDelegate, UITableViewDataSource, SKTableViewCellsMarkable, SKLevelTableViewCellDelegate>

@property (strong, nonatomic) SKLevel *datasourceLevel;
@property (weak, nonatomic) SKSelfNavigableTableViewController *tableViewControllerDelegate;

- (instancetype)initWithDatasource:(SKLevel *)datasourceLevel
                      forTableView:(UITableView *)table NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;

- (void)markAllCellsForLevel:(SKLevel *)currentLevel;

@end
