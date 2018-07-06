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
    
    // Adding new item
    if (self.datasourceLevel.isAddOptionEnabled) {
        UIBarButtonItem *addButton = [[UIBarButtonItem alloc]
                                      initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                      target:self action:@selector(insertNewObject)];
        self.navigationItem.rightBarButtonItem = addButton;
    }
}


#pragma mark - Adding From Contacts

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
    Element *newEmailElement = [[Element alloc]
                                initWithTitle:addedEmail
                                checked:YES];
    [self.datasourceLevel.data addObject:newEmailElement];

    NSIndexPath *indexPathToInsert = [NSIndexPath indexPathForRow:self.datasourceLevel.data.count - 1 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPathToInsert]
                          withRowAnimation:UITableViewRowAnimationAutomatic];
}

@end
