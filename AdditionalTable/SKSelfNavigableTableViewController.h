//
//  SKSelfNavigableTableViewController.h
//  AdditionalTable
//
//  Created by Serhii K on 7/4/18.
//  Copyright © 2018 Serhii K. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ContactsUI/ContactsUI.h>
#import <Contacts/Contacts.h>

#import "SKContactPickerViewController.h"
#import "SKLevel.h"
#import "SKTitleProvider.h"

@interface SKSelfNavigableTableViewController : UIViewController <SKContactPickerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) SKLevel            *datasourceLevel;
@property (strong, nonatomic) UIBarButtonItem    *checkAllButton;

@end
