//
//  MagicViewController.h
//  AdditionalTable
//
//  Created by Serhii K on 7/4/18.
//  Copyright © 2018 Serhii K. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TitleProvider.h"
#import "Level.h"

@interface MagicViewController : UIViewController

@property (strong, nonatomic) Level *datasourceLevel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
