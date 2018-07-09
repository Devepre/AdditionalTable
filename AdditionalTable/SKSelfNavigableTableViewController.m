//
//  SKSelfNavigableTableViewController.m
//  AdditionalTable
//
//  Created by Serhii K on 7/4/18.
//  Copyright © 2018 Serhii K. All rights reserved.
//

#import "SKSelfNavigableTableViewController.h"
#import "SKSelfNavigableTableViewProxy.h"
#import "SKLevelTableViewCell.h"
#import "SKLevel.h"
#import "SKElement.h"

@interface SKSelfNavigableTableViewController ()

@property (strong, nonatomic) SKSelfNavigableTableViewProxy *selfNavigableTableProxy;
@property (strong, nonatomic) NSMutableArray<UIBarButtonItem *> *rightBarButtonItems;

@end

@implementation SKSelfNavigableTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    self.selfNavigableTableProxy = [[SKSelfNavigableTableViewProxy alloc]
                                    initWithDatasource:self.datasourceLevel
                                    forTableView:self.tableView];
    
    self.tableView.delegate = self.selfNavigableTableProxy;
    self.tableView.dataSource = self.selfNavigableTableProxy;
    
    self.rightBarButtonItems = [[NSMutableArray alloc] init];
    
    // Check All Button item
//    if ([[self.datasourceLevel.data firstObject] isKindOfClass:Element.class]) {
        UIBarButtonItem *checkAllButton = [[UIBarButtonItem alloc]
                                           initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
                                           target:self action:@selector(markAllCellsChecked)];
        [self.rightBarButtonItems addObject:checkAllButton];
//    }

    // Add New Button item
    if (self.datasourceLevel.isAddOptionEnabled) {
        UIBarButtonItem *addButton = [[UIBarButtonItem alloc]
                                      initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                      target:self action:@selector(insertNewObject)];
        [self.rightBarButtonItems addObject:addButton];
    }
    
    [self.navigationItem setRightBarButtonItems:self.rightBarButtonItems];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // Reloading data after pushing VC back from stack
    // Need to be optimized to execute only if pushed back
    // but not just created
    [self.tableView reloadData];
}


#pragma mark - Additional Methods

- (void)insertNewObject {
    [self addFromContacts];
}


- (void)addFromContacts {
    CNContactPickerViewController *contactPicker = [[CNContactPickerViewController alloc] init];
    contactPicker.displayedPropertyKeys = @[CNContactEmailAddressesKey];
    contactPicker.predicateForEnablingContact = [NSPredicate predicateWithFormat:@"emailAddresses.@count > 0"];

    // In order to enable selection of contact only if one e-mail addres is present
    contactPicker.predicateForSelectionOfContact = [NSPredicate predicateWithFormat:@"emailAddresses.@count == 1"];
    contactPicker.delegate = self;

    [self presentViewController:contactPicker animated:YES completion:nil];
}


- (void)markAllCellsChecked {
    [self.selfNavigableTableProxy markAllCellsChecked];
}

#pragma mark - <CNContactPickerDelegate>

- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContact:(CNContact *)contact {
    NSString *addedEmail = [contact.emailAddresses firstObject].value;
    [self tableAddItem:addedEmail];
}


- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContactProperty:(CNContactProperty *)contactProperty {
    NSString *addedEmail = contactProperty.value;
    [self tableAddItem:addedEmail];
}


- (void)tableAddItem:(NSString *)addedEmail {
    SKElement *newEmailElement = [[SKElement alloc]
                                initWithTitle:addedEmail
                                dataObject:addedEmail
                                checked:YES];
    [self.datasourceLevel.dataArray addObject:newEmailElement];

    NSIndexPath *indexPathToInsert = [NSIndexPath indexPathForRow:self.datasourceLevel.dataArray.count - 1 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPathToInsert]
                          withRowAnimation:UITableViewRowAnimationAutomatic];
}

@end