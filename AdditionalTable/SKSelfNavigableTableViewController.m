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
#import "NSString+SKEmailValidation.h"

@interface SKSelfNavigableTableViewController () {
    NSString *kAddFromcontactsString;
    NSString *kAddManuallyString;
    NSString *kCancelString;
    NSString *kSkipString;
    NSString *kAddString;
    NSString *kAddManuallyTitleString;
    NSString *kEmailPlaceHolder;
    NSString *kDuplicateString;
    NSString *kAlreadyPresentString;
}

@property (strong, nonatomic) NSMutableArray<UIBarButtonItem *> *rightBarButtonItems;
@property (strong, nonatomic) UIAlertController                 *addManuallyAlertController;
@property (strong, nonatomic) NSString                          *contactPickerUserInputString;
@property (strong, nonatomic) SKSelfNavigableTableViewProxy     *selfNavigableTableViewProxy;
@property (strong, nonatomic) NSMutableSet<NSString *>          *emailIDs;

@end

@implementation SKSelfNavigableTableViewController


#pragma mark - Initializers

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDefaults];
    [self attachTableViewProxy];
    [self attachRightBarButtons];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // Reloading data after pushing VC back from stack
    // Need to be optimized to execute only if pushed back
    // but not just created
    [self.tableView reloadData];
}


- (void)initDefaults {
    // TODO Can be moved to instance variables in order to be initialized only once
    kAddFromcontactsString =     @"Add email from Contacts";
    kAddManuallyString =         @"Enter email manually";
    kCancelString =              @"Cancel";
    kSkipString =                @"Skip";
    kAddString =                 @"Add";
    kAddManuallyTitleString =    @"Enter the email address";
    kEmailPlaceHolder =          @"example@domain.com";
    kDuplicateString =           @"Duplicate entry";
    kAlreadyPresentString =      @"This email is already present in the sender's list";
    
    // Storage for already added emails from device Contacts
    // Allows to track if email is already added
    self.emailIDs = [[NSMutableSet alloc] init];
}


- (void)attachTableViewProxy {
    self.selfNavigableTableViewProxy = [[SKSelfNavigableTableViewProxy alloc] initWithDatasource:self.datasourceLevel
                                                                                    forTableView:self.tableView
                                                                                  storybaordname:@"Main"
                                                                    selfViewControllerIdentifier:@"MagicViewController"];
    // Delegation used to callback when Model is changing
    // in order to change checkAllButton title accordingly
    self.selfNavigableTableViewProxy.tableViewControllerDelegate = self;
    
    self.tableView.delegate = self.selfNavigableTableViewProxy;
    self.tableView.dataSource = self.selfNavigableTableViewProxy;
}


- (void)attachRightBarButtons {
    self.rightBarButtonItems = [[NSMutableArray alloc] init];
    
    // Add New Button item
    if (self.datasourceLevel.isAddOptionEnabled) {
        UIBarButtonItem *addButton = [[UIBarButtonItem alloc]
                                      initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                      target:self action:@selector(addNewObject:)];
        [self.rightBarButtonItems addObject:addButton];
    }
    
    // Check All Button item
    // Depends on first object type - mixes are not allowed for now
    if ([[self.datasourceLevel.dataArray firstObject] isKindOfClass:SKElement.class]) {
        NSString *buttonTitle = [self.datasourceLevel getTitleForCheckInOut];
        self.checkAllButton = [[UIBarButtonItem alloc]
                               initWithTitle:buttonTitle
                               style:UIBarButtonItemStylePlain
                               target:self
                               action:@selector(markAllCells)];
        [self.rightBarButtonItems addObject:self.checkAllButton];
    }
    
    [self.navigationItem setRightBarButtonItems:self.rightBarButtonItems];
}


#pragma mark - Alert Controllers

- (void)addNewObject:(UIBarButtonItem *)sender {
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:nil
                                          message:nil
                                          preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *addFromContactsAction = [UIAlertAction
                                            actionWithTitle:kAddFromcontactsString
                                            style:UIAlertActionStyleDefault
                                            handler:^(UIAlertAction * _Nonnull action) {
                                                [self addFromContacts];
                                            }];
    
    UIAlertAction *manualAddAction = [UIAlertAction
                                      actionWithTitle:kAddManuallyString
                                      style:UIAlertActionStyleDefault
                                      handler:^(UIAlertAction * _Nonnull action) {
                                          [self addManually];
                                      }];
    
    UIAlertAction *cancelAction = [UIAlertAction
                                   actionWithTitle:kCancelString
                                   style:UIAlertActionStyleCancel
                                   handler:nil];
    
    [alertController addAction:addFromContactsAction];
    [alertController addAction:manualAddAction];
    [alertController addAction:cancelAction];
    
    // Handling presentation for iPads
    [alertController setModalPresentationStyle:UIModalPresentationPopover];
    alertController.popoverPresentationController.barButtonItem = sender;
    [self presentViewController:alertController
                       animated:YES
                     completion:nil];
}


- (void)addManually {
    self.addManuallyAlertController = [UIAlertController
                                       alertControllerWithTitle:kAddManuallyTitleString
                                       message:nil
                                       preferredStyle:UIAlertControllerStyleAlert];
    
    __weak typeof(self) weakSelf = self;
    NSString *kEmailPlaceHolderWeakString = [kEmailPlaceHolder copy];
    
    [self.addManuallyAlertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = kEmailPlaceHolderWeakString;
        textField.keyboardType = UIKeyboardTypeEmailAddress;
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        textField.borderStyle = UITextBorderStyleNone;
        
        // Notification to handle changes for input text
        // Need to be present in order to allow check of user input text
        [[NSNotificationCenter defaultCenter] addObserver:weakSelf
                                                 selector:@selector(handleTextFieldTextDidChangeNotification:)
                                                     name:UITextFieldTextDidChangeNotification
                                                   object:textField];
    }];
    
    UIAlertAction *addAction = [UIAlertAction
                                actionWithTitle:kAddString
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction *action) {
                                    UITextField *inputField = self.addManuallyAlertController.textFields[0];
                                    NSString *userInputString = inputField.text;
                                    [self removeTextFieldObserver];
                                    [self tableAddItem:userInputString];
                                }];
    addAction.enabled = NO;
    
    UIAlertAction *cancelAction = [UIAlertAction
                                   actionWithTitle:kCancelString
                                   style:UIAlertActionStyleCancel
                                   handler:^(UIAlertAction * _Nonnull action) {
                                       [self removeTextFieldObserver];
                                   }];
    
    [self.addManuallyAlertController addAction:addAction];
    [self.addManuallyAlertController addAction:cancelAction];
    
    [self presentViewController:self.addManuallyAlertController
                       animated:YES
                     completion:nil];
}


- (void)displayDuplicateElementAlert {
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:kDuplicateString
                                          message:kAlreadyPresentString
                                          preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction
                                   actionWithTitle:kSkipString
                                   style:UIAlertActionStyleCancel
                                   handler:nil];
    
    [alertController addAction:cancelAction];
    [self presentViewController:alertController
                       animated:YES
                     completion:nil];
}


#pragma mark - Additional Methods

- (void)addFromContacts {
    SKContactPickerViewController *contactPicker = [[SKContactPickerViewController alloc] init];
    contactPicker.delegate = self;
    contactPicker.displayedPropertyKeys = @[CNContactEmailAddressesKey];
    contactPicker.predicateForEnablingContact = [NSPredicate
                                                 predicateWithFormat:
                                                 @"(emailAddresses.@count > 0) AND (NOT ALL emailAddresses.identifier IN %@)",
                                                 self.emailIDs];
    // In order to enable selection of contact only if one email address is present
    contactPicker.predicateForSelectionOfContact = [NSPredicate predicateWithFormat:@"emailAddresses.@count == 1"];
    
    [self presentViewController:contactPicker
                       animated:YES
                     completion:nil];
}


- (void)tableAddItem:(NSString *)addedEmail {
    SKElement *newEmailElement = [[SKElement alloc]
                                  initWithTitle:addedEmail
                                  dataObject:addedEmail
                                  checked:YES];
    
    BOOL isElementAdded = [self.datasourceLevel addItem:newEmailElement];
    if (isElementAdded) {
        // Assume only one section is present
        NSIndexPath *indexPathToInsert = [NSIndexPath
                                          indexPathForRow:self.datasourceLevel.dataArray.count - 1
                                          inSection:0];
        [self.tableView insertRowsAtIndexPaths:@[indexPathToInsert]
                              withRowAnimation:UITableViewRowAnimationAutomatic];
    } else {
        [self displayDuplicateElementAlert];
    }
}


- (void)markAllCells {
    [self.selfNavigableTableViewProxy markAllCellsForLevel:self.datasourceLevel];
    // For every model change need to update title for button
    self.checkAllButton.title = [self.datasourceLevel getTitleForCheckInOut];
}


#pragma mark - <SKContactPickerDelegate>

- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContact:(CNContact *)contact {
    CNLabeledValue<NSString *> *contactEmailValue = [contact.emailAddresses firstObject];
    self.contactPickerUserInputString = contactEmailValue.value;
    
    // Storing email ID for further comparison if it's present
    NSString *propertyID = contactEmailValue.identifier;
    [self.emailIDs addObject:propertyID];
}


- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContactProperty:(CNContactProperty *)contactProperty {
    NSString *propertyID = contactProperty.identifier;
    [self.emailIDs addObject:propertyID];
    self.contactPickerUserInputString = contactProperty.value;
}


- (void)contactPicker:(SKContactPickerViewController *)picker viewDidDisappear:(BOOL)animated {
    // Handling user input string from Contacts UI
    if (self.contactPickerUserInputString) {
        [self tableAddItem:self.contactPickerUserInputString];
        self.contactPickerUserInputString = nil;
    }
}


#pragma mark - Notifications for textField

- (void)removeTextFieldObserver {
    [NSNotificationCenter.defaultCenter
     removeObserver:self
     name:UITextFieldTextDidChangeNotification
     object:self.addManuallyAlertController.textFields[0]];
}


- (void)handleTextFieldTextDidChangeNotification:(NSNotification *)notification {
    UITextField *inputField = self.addManuallyAlertController.textFields[0];
    NSString *userInputString = inputField.text;
    // Enable/Disable Add button
    self.addManuallyAlertController.actions[0].enabled = [userInputString isValidEmail];
}


@end
