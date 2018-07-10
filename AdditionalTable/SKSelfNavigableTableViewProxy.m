//
//  SKSelfNavigableTableViewProxy.m
//  AdditionalTable
//
//  Created by Serhii K on 7/5/18.
//  Copyright © 2018 Serhii K. All rights reserved.
//

#import "SKSelfNavigableTableViewProxy.h"
#import "SKSelfNavigableTableViewController.h"
#import "SKLevelTableViewCell.h"
#import "SKLevel.h"
#import "SKElement.h"

@interface SKSelfNavigableTableViewProxy () {
    NSString *kLevelCellNibName;
    NSString *kElementCellNibName;
    NSString *kLevelCellIdentifier;
    NSString *kElementCellIdentifier;
}

@property (weak, nonatomic) UITableView *tableView;

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
        // Setting counters
        NSUInteger total = 0;
        NSUInteger numberOfCheckedElements = [((SKLevel *)[self.datasourceLevel.dataArray objectAtIndex:indexPath.row]) numberOfCheckedElementsWithTotal:&total];
        NSString *counterString = [NSString stringWithFormat:@"%lu//%lu", (unsigned long)numberOfCheckedElements, (unsigned long)total];
        cell.additionalInfoTextLabel.text = counterString;
    }
    
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

- (void)markAllCells {
    [self.datasourceLevel isAnyCheckedIn] ? [self.datasourceLevel checkOut] : [self.datasourceLevel checkIn];
    [self.tableView reloadData];
}


@end
