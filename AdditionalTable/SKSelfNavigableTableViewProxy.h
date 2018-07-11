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

@property (strong, nonatomic) SKLevel                          *datasourceLevel;
@property (weak, nonatomic) SKSelfNavigableTableViewController *tableViewControllerDelegate;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithDatasource:(SKLevel *)datasourceLevel
                      forTableView:(UITableView *)tableView
                    storybaordname:(NSString *)storyboardName
      selfViewControllerIdentifier:(NSString *)SelfViewControllerIdentifier NS_DESIGNATED_INITIALIZER;

- (void)markAllCellsForLevel:(SKLevel *)currentLevel;

@end
