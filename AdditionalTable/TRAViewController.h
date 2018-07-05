//
//  TRAViewController.h
//  AdditionalTable
//
//  Created by Serhii K on 7/5/18.
//  Copyright © 2018 Serhii K. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Level;

@interface TRAViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) Level *rootLevel;

- (IBAction)awesomeButtonAction:(UIButton *)sender;

@end
