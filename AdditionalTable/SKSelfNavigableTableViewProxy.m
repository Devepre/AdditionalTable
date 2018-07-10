//
//  SKSelfNavigableTableViewProxy.m
//  AdditionalTable
//
//  Created by Serhii K on 7/5/18.
//  Copyright © 2018 Serhii K. All rights reserved.
//

#import "SKSelfNavigableTableViewProxy.h"
#import "SKSelfNavigableTableViewController.h"
#import "SKLevel.h"
#import "SKElement.h"

@interface SKSelfNavigableTableViewProxy () {
    NSString *kLevelCellNibName;
    NSString *kElementCellNibName;
    NSString *kLevelCellIdentifier;
    NSString *kElementCellIdentifier;
}

@property (weak, nonatomic) UITableView *tableView;
@property (weak, nonatomic) id <SKLevelTableViewCellDelegate> delegate;

@end

@implementation SKSelfNavigableTableViewProxy


- (instancetype)initWithDatasource:(SKLevel *)datasourceLevel
                      forTableView:(UITableView *)tableView {
    self = [super init];
    if (self) {
        _datasourceLevel = datasourceLevel;
        _tableView = tableView;
        [self initDefaults];
    }
    return self;
}


- (void)initDefaults {
    NSLog(@"%s", __func__);
    
    // TODO Can be moved to instance variables in order to be initialized only once
    kLevelCellIdentifier =      @"LevelCell";
    kElementCellIdentifier =    @"ElementCell";
    kLevelCellNibName =         @"SKLevelTableViewCell";
    kElementCellNibName =       @"SKElementTableViewCell";
    
    NSLog(@"%@", self.datasourceLevel);
}


#pragma mark - <UITableViewDataSource, UITableViewDelegate>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datasourceLevel.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // Getting correct cell identifier and nib name
    NSString *cellIdentifier = @"defaultCellIdentifier";
    NSString *nibName = @"defaultNibName";
    if ([[self.datasourceLevel.dataArray firstObject] isKindOfClass:SKLevel.class]) {
        cellIdentifier = kLevelCellIdentifier;
        nibName = kLevelCellNibName;
    } else if ([[self.datasourceLevel.dataArray firstObject] isKindOfClass:SKElement.class]) {
        cellIdentifier = kElementCellIdentifier;
        nibName = kElementCellNibName;
    }

    // Creating cell
    SKLevelTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        [tableView registerNib:[UINib nibWithNibName:nibName bundle:nil] forCellReuseIdentifier:cellIdentifier];
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    }
    
    // Populating cell with data according to the Protocol
    id<SKTitleProvider> currentObject = [self.datasourceLevel.dataArray objectAtIndex:indexPath.row];
    cell.mainTextLabel.text = [currentObject title];
    
    // Setting checkmarks according to the model state
    if ([cellIdentifier isEqualToString:kElementCellIdentifier]) {
        SKElement *currentElement = (SKElement *)[self.datasourceLevel.dataArray objectAtIndex:indexPath.row];
        cell.accessoryType = currentElement.checked ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
    } else {
        // Setting delegate in order to receive info from Cell
        cell.delegate = self;
        
        // Setting title for the Button
        [self setTitleForLevelTableViewCellAdditionalButton:cell
                                                atIndexPath:indexPath];
        
        // Setting counters
        NSUInteger total = 0;
        NSUInteger numberOfCheckedElements = [((SKLevel *)[self.datasourceLevel.dataArray objectAtIndex:indexPath.row]) numberOfCheckedElementsWithTotal:&total];
        NSString *counterString = [NSString stringWithFormat:@"%lu//%lu selected", (unsigned long)numberOfCheckedElements, (unsigned long)total];
        cell.additionalInfoTextLabel.text = counterString;
    }
    
    // Updating Title for the Navigation button
    // Should be updated if model is changed only
    // but not for every cell getting - can be optimized
    self.tableViewControllerDelegate.checkAllButton.title = [self.datasourceLevel getTitleForCheckInOut];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%s", __func__);
    
    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    
    if ([selectedCell.reuseIdentifier isEqualToString:kLevelCellIdentifier]) {
        [self pushTableViewForRowAtIndexPath:indexPath];
    } else if ([selectedCell.reuseIdentifier isEqualToString:kElementCellIdentifier]) {
        [self markSelectedCell:selectedCell
                  forIndexPath:indexPath
                     tableView:tableView];
    }
    
}


#pragma mark - Additional Methods

- (void)markSelectedCell:(UITableViewCell *)selectedCell
            forIndexPath:(NSIndexPath * _Nonnull)indexPath
               tableView:(UITableView * _Nonnull)tableView {
    NSLog(@"%s", __func__);
    
    BOOL isCellSelected = (selectedCell.accessoryType == UITableViewCellAccessoryCheckmark);
    
    // Handling datasource item
    SKTableSourceItem *currentObject = [self.datasourceLevel.dataArray objectAtIndex:indexPath.row];
    isCellSelected ? [currentObject checkOut] : [currentObject checkIn];

    // Hadnling table UI changes manually instead of reloading data
    selectedCell.accessoryType = isCellSelected ? UITableViewCellAccessoryNone : UITableViewCellAccessoryCheckmark;
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    // Updating Title for the Navigation button
    self.tableViewControllerDelegate.checkAllButton.title = [self.datasourceLevel getTitleForCheckInOut];
}


- (void)pushTableViewForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%s", __func__);
    
    UIStoryboard *currentStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    SKSelfNavigableTableViewController *nextController = [currentStoryBoard instantiateViewControllerWithIdentifier:@"MagicViewController"];
    nextController.datasourceLevel = (SKLevel *)[self.datasourceLevel.dataArray objectAtIndex:indexPath.row];
    
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    if ([rootViewController isKindOfClass:UINavigationController.class]) {
        UINavigationController *currentNavigationController = (UINavigationController *)rootViewController;
        [currentNavigationController pushViewController:nextController animated:YES];
    } else {
        NSLog(@"Root view controller should be UINavigationController in order to push new VC instance");
    }
}

- (void)markAllCellsForLevel:(SKLevel *)selectedLevel {
    [selectedLevel isAnyCheckedIn] ? [selectedLevel checkOut] : [selectedLevel checkIn];
    [self.tableView reloadData];
}


#pragma mark - <SKLevelTableViewCellDelegate>

- (void)actionForLevelTableViewCell:(SKLevelTableViewCell *)levelTableViewCell {
    NSIndexPath *selectedIndexPath = [self.tableView indexPathForCell:levelTableViewCell];
    SKLevel *selectedLevel = (SKLevel *)[self.datasourceLevel.dataArray objectAtIndex:selectedIndexPath.row];

    [self setTitleForLevelTableViewCellAdditionalButton:levelTableViewCell
                                            atIndexPath:nil];

    [self markAllCellsForLevel:selectedLevel];
}


- (void)setTitleForLevelTableViewCellAdditionalButton:(SKLevelTableViewCell *)cell
                                          atIndexPath:(NSIndexPath *)indexPath {
    // If indexPath is unknown need to get it
    // but need to path indexPath explicitly
    // from method tableView:cellForRowAtIndexPath:
    if (!indexPath) {
        indexPath = [self.tableView indexPathForCell:cell];
    }
    SKLevel *selectedLevel = (SKLevel *)[self.datasourceLevel.dataArray objectAtIndex:indexPath.row];
    NSString *buttonNewTitle = [selectedLevel getTitleForCheckInOut];
    [cell.additionalButton setTitle:buttonNewTitle
                           forState:UIControlStateNormal];
}

@end
