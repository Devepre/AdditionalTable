//
//  MagicViewController.m
//  AdditionalTable
//
//  Created by Serhii K on 7/4/18.
//  Copyright © 2018 Serhii K. All rights reserved.
//

#import "MagicViewController.h"
#import "SelfNavigableTableViewProxy.h"
#import "LevelTableViewCell.h"
#import "Level.h"
#import "Element.h"

@interface MagicViewController ()

@property (strong, nonatomic) SelfNavigableTableViewProxy *selfNavigableTableProxy;

@end

@implementation MagicViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    self.selfNavigableTableProxy = [[SelfNavigableTableViewProxy alloc] initWithDatasource:self.datasourceLevel];
    
    self.tableView.delegate = self.selfNavigableTableProxy;
    self.tableView.dataSource = self.selfNavigableTableProxy;
}


@end
