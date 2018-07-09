//
//  TRAViewController.m
//  AdditionalTable
//
//  Created by Serhii K on 7/5/18.
//  Copyright © 2018 Serhii K. All rights reserved.
//

#import "TRAViewController.h"
#import "SelfNavigableTableViewProxy.h"
#import "ClientItem.h"
#import "ContactItem.h"
#import "Element.h"

@interface TRAViewController () {
    BOOL _checkedByDefaults;
}

@property (strong, nonatomic) SelfNavigableTableViewProxy *selfNavigableTableProxy;

@end

@implementation TRAViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.rootLevel = [self createLevelHierarchy];
    self.selfNavigableTableProxy = [[SelfNavigableTableViewProxy alloc]
                                    initWithDatasource:self.rootLevel
                                    forTableView:self.tableView];
    
    self.tableView.delegate = self.selfNavigableTableProxy;
    self.tableView.dataSource = self.selfNavigableTableProxy;
    
    self.emailsAddedManually = [[NSMutableArray alloc] init];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // Reloading data after pushing VC back from stack
    // Need to be optimized to execute only if pushed back
    // but not just created
    [self.tableView reloadData];
}


- (Level *)createLevelHierarchy {
    _checkedByDefaults = NO;
    
    ClientItem *clientBuilding = [[ClientItem alloc] initWithTitle:@"Building" dataObject:@"BuildingValue"];
    ClientItem *clientHospital = [[ClientItem alloc] initWithTitle:@"Hospital" dataObject:@"HospitalValue"];
    ClientItem *clientDepartment = [[ClientItem alloc] initWithTitle:@"Department" dataObject:@"DepartmentValue"];
    
    ContactItem *emailOne = [[ContactItem alloc] initWithTitle:@"one@dot.com" email:@"one@dot.com"];
    ContactItem *emailTwo = [[ContactItem alloc] initWithTitle:@"two@dot.com" email:@"two@dot.com"];
    ContactItem *emailThree = [[ContactItem alloc] initWithTitle:@"three@dot.com" email:@"three@dot.com"];
    ContactItem *emailFour = [[ContactItem alloc] initWithTitle:@"four@dot.com" email:@"four@dot.com"];
    ContactItem *emailFive = [[ContactItem alloc] initWithTitle:@"five@dot.com" email:@"five@dot.com"];
    
    // For departments
    ContactItem *email1 = [[ContactItem alloc] initWithTitle:@"DepOne" email:@"hard@dot.com"];
    ContactItem *email2 = [[ContactItem alloc] initWithTitle:@"DepTwo" email:@"hard2@dot.com"];
    ContactItem *email3 = [[ContactItem alloc] initWithTitle:@"DepThree" email:@"hard3@dot.com"];
    ContactItem *email4 = [[ContactItem alloc] initWithTitle:@"DepFour" email:@"hard4@dot.com"];
    
    clientBuilding.emails = [@[emailOne, emailTwo] mutableCopy];
    clientHospital.emails = [@[emailThree, emailFour] mutableCopy];
    clientDepartment.emails = [@[emailFive] mutableCopy];
    
    // Elements for Buildings
    Element *element_building_0 = [[Element alloc] initWithTitle:clientBuilding.emails[0].title
                                                      dataObject:clientBuilding.emails[0].dataObject
                                                         checked:_checkedByDefaults];
    Element *element_building_1 = [[Element alloc] initWithTitle:clientBuilding.emails[1].title
                                                      dataObject:clientBuilding.emails[1].dataObject
                                                         checked:_checkedByDefaults];
    // Buildings Level
    Level *level_building = [[Level alloc] initWithTitle:@"Buildings"
                                                    dataArray:[@[element_building_0, element_building_1] mutableCopy]
                                        addOptionEnabled:NO];
    
    // Elements for Hospitals
    Element *element_hospital_0 = [[Element alloc] initWithTitle:clientHospital.emails[0].title
                                                      dataObject:clientHospital.emails[0].dataObject
                                   checked:_checkedByDefaults];
    Element *element_hospital_1 = [[Element alloc] initWithTitle:clientHospital.emails[1].title
                                                      dataObject:clientHospital.emails[1].dataObject
                                   checked:_checkedByDefaults];
    // Hospital Level
    Level *level_hospital = [[Level alloc] initWithTitle:@"Hospitals"
                                                    dataArray:[@[element_hospital_0, element_hospital_1] mutableCopy]
                                        addOptionEnabled:NO];
    
    /////////////////////////////
    Element *element_department_0 = [[Element alloc] initWithTitle:email1.title
                                                        dataObject:email1.dataObject
                                                           checked:_checkedByDefaults];
    Element *element_department_1 = [[Element alloc] initWithTitle:email2.title
                                                        dataObject:email2.dataObject
                                                           checked:_checkedByDefaults];
    Element *element_department_1_0 = [[Element alloc] initWithTitle:email3.title
                                                          dataObject:email3.dataObject
                                                             checked:_checkedByDefaults];
    Element *element_department_1_1 = [[Element alloc] initWithTitle:email4.title
                                                          dataObject:email4.dataObject
                                                             checked:_checkedByDefaults];
    
    
    Level *level_department_0 = [[Level alloc] initWithTitle:@"Sub Departments"
                                                        dataArray:[@[element_department_0, element_department_1] mutableCopy]
                                            addOptionEnabled:YES];
    
    Level *level_department_1 = [[Level alloc] initWithTitle:@"Sub Departments"
                                                        dataArray:[@[element_department_1_0, element_department_1_1] mutableCopy]
                                            addOptionEnabled:YES];
    
    // Department Level
    Level *level_department = [[Level alloc] initWithTitle:@"Departments"
                                                      dataArray:[@[level_department_0, level_department_1] mutableCopy]
                                          addOptionEnabled:NO];
    
    
    Level *levelRoot = [[Level alloc] initWithTitle:@"Root Table"
                                               dataArray:[@[level_building, level_hospital, level_department] mutableCopy]
                                   addOptionEnabled:NO];
    
    return levelRoot;
}


- (IBAction)awesomeButtonAction:(UIButton *)sender {
    NSLog(@"%@", self.rootLevel);
    
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:@"Your Data"
                                          message:[self.rootLevel description]
                                          preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Ok"
                                                       style:UIAlertActionStyleCancel
                                                     handler:nil];
    [alertController addAction:okAction];
    [self presentViewController:alertController
                       animated:YES
                     completion:nil];
    
//    NSLog(@"Contacts are:\n%@", self.emailsAddedManually);
}


- (IBAction)addFromContacts:(UIButton *)sender {
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
    [self.emailsAddedManually addObject:[contact.emailAddresses firstObject].value];
}


- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContactProperty:(CNContactProperty *)contactProperty {
    [self.emailsAddedManually addObject:contactProperty.value];
}


@end
