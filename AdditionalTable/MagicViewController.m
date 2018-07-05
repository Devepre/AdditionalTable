//
//  MagicViewController.m
//  AdditionalTable
//
//  Created by Serhii K on 7/4/18.
//  Copyright © 2018 Serhii K. All rights reserved.
//

#import "MagicViewController.h"
#import "LevelTableViewCell.h"
#import "Level.h"
#import "Element.h"

@interface MagicViewController () {
    NSString *kLevelCellNibName;
    NSString *kElementCellNibName;
    NSString *kLevelCellIdentifier;
    NSString *kElementCellIdentifier;
}

@end

@implementation MagicViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    [self initDefaults];
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
    
    MagicViewController *nextController = [self.storyboard instantiateViewControllerWithIdentifier:@"MagicViewController"];
//    nextController.datasourceArray_ = [self.datasourceArray_ objectAtIndex:indexPath.row];
//    nextController.datasourceArray = [self.datasourceArray objectAtIndex:indexPath.row];
    nextController.datasourceLevel = [self.datasourceLevel.data objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:nextController animated:YES];
}


@end
