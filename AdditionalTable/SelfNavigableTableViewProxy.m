//
//  BobikTableViewDelegate.m
//  AdditionalTable
//
//  Created by Serhii K on 7/5/18.
//  Copyright © 2018 Serhii K. All rights reserved.
//

#import "SelfNavigableTableViewProxy.h"
#import "MagicViewController.h"
#import "LevelTableViewCell.h"
#import "Level.h"
#import "Element.h"

@interface SelfNavigableTableViewProxy () {
    NSString *kLevelCellNibName;
    NSString *kElementCellNibName;
    NSString *kLevelCellIdentifier;
    NSString *kElementCellIdentifier;
}

@end

@implementation SelfNavigableTableViewProxy


- (instancetype)initWithDatasource:(Level *)datasourceLevel {
    self = [super init];
    if (self) {
        _datasourceLevel = datasourceLevel;
        [self initDefaults];
    }
    return self;
}


- (void)initDefaults {
    NSLog(@"%s", __func__);
    
    kLevelCellIdentifier =      @"LevelCell";
    kElementCellIdentifier =    @"ElementCell";
    kLevelCellNibName =         @"LevelTableViewCell";
    kElementCellNibName =       @"ElementTableViewCell";
    
    NSLog(@"%@", self.datasourceLevel);
}


#pragma mark - <UITableViewDataSource, UITableViewDelegate>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datasourceLevel.data.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = nil;
    NSString *nibName = nil;
    if ([[self.datasourceLevel.data firstObject] isKindOfClass:Level.class]) {
        cellIdentifier = kLevelCellIdentifier;
        nibName = kLevelCellNibName;
    } else if ([[self.datasourceLevel.data firstObject] isKindOfClass:Element.class]) {
        cellIdentifier = kElementCellIdentifier;
        nibName = kElementCellNibName;
    }
    
    LevelTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        [tableView registerNib:[UINib nibWithNibName:nibName bundle:nil] forCellReuseIdentifier:cellIdentifier];
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    }
    
    id<TitleProvider> currentObject = [self.datasourceLevel.data objectAtIndex:indexPath.row];
    cell.textLabel.text = [currentObject title];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%s", __func__);
    
    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    
    if ([selectedCell.reuseIdentifier isEqualToString:kLevelCellIdentifier]) {
        [self pushTableViewForRowAtIndexPath:indexPath];
    } else if ([selectedCell.reuseIdentifier isEqualToString:kElementCellIdentifier]) {
        [self markSelectedCell:selectedCell forIndexPath:indexPath tableView:tableView];
    }
    
}


#pragma mark - Additional Methods

- (void)markSelectedCell:(UITableViewCell *)selectedCell
            forIndexPath:(NSIndexPath * _Nonnull)indexPath
               tableView:(UITableView * _Nonnull)tableView {
    NSLog(@"%s", __func__);
    
    BOOL isSelected = (selectedCell.accessoryType == UITableViewCellAccessoryCheckmark);
    if (isSelected) {
        selectedCell.accessoryType = UITableViewCellAccessoryNone;
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    } else {
        selectedCell.accessoryType = UITableViewCellAccessoryCheckmark;
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}


- (void)pushTableViewForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%s", __func__);
    
    UIStoryboard *currentStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    MagicViewController *nextController = [currentStoryBoard instantiateViewControllerWithIdentifier:@"MagicViewController"];
    nextController.datasourceLevel = [self.datasourceLevel.data objectAtIndex:indexPath.row];
    
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    if ([rootViewController isKindOfClass:UINavigationController.class]) {
        UINavigationController *currentNavigationController = (UINavigationController *)rootViewController;
        [currentNavigationController pushViewController:nextController animated:YES];
    } else {
        NSLog(@"Root view controller should be UINavigationController in order to push new VC instance");
    }
}


@end
