//
//  TRAViewController.m
//  AdditionalTable
//
//  Created by Serhii K on 7/5/18.
//  Copyright © 2018 Serhii K. All rights reserved.
//

#import "TRAViewController.h"
#import "SelfNavigableTableViewProxy.h"

#import "Client.h"
#import "EMail.h"
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
    self.selfNavigableTableProxy = [[SelfNavigableTableViewProxy alloc] initWithDatasource:self.rootLevel];
    
    self.tableView.delegate = self.selfNavigableTableProxy;
    self.tableView.dataSource = self.selfNavigableTableProxy;
}


- (Level *)createLevelHierarchy {
    _checkedByDefaults = YES;
    
    Client *clientBuilding = [[Client alloc] initWithTitle:@"Building"];
    Client *clientHospital = [[Client alloc] initWithTitle:@"Hospital"];
    Client *clientDepartment = [[Client alloc] initWithTitle:@"Department"];
    
    EMail *emailOne = [[EMail alloc] initWithTitle:@"one@dot.com"];
    EMail *emailTwo = [[EMail alloc] initWithTitle:@"two@dot.com"];
    EMail *emailThree = [[EMail alloc] initWithTitle:@"three@dot.com"];
    EMail *emailFour = [[EMail alloc] initWithTitle:@"four@dot.com"];
    EMail *emailFive = [[EMail alloc] initWithTitle:@"five@dot.com"];
    
    clientBuilding.emails = [@[emailOne, emailTwo] mutableCopy];
    clientHospital.emails = [@[emailThree, emailFour] mutableCopy];
    clientDepartment.emails = [@[emailFive] mutableCopy];
    
    // Elements for Buildings
    Element *element_building_0 = [[Element alloc] initWithTitle:clientBuilding.emails[0].title
                                                         checked:_checkedByDefaults];
    Element *element_building_1 = [[Element alloc] initWithTitle:clientBuilding.emails[1].title
                                                         checked:_checkedByDefaults];
    // Buildings Level
    Level *level_building = [[Level alloc] initWithTitle:@"Buildings"
                                                    data:@[element_building_0, element_building_1]
                                        addOptionEnabled:YES];
    
    // Elements for Hospitals
    Element *element_hospital_0 = [[Element alloc] initWithTitle:clientHospital.emails[0].title
                                                         checked:_checkedByDefaults];
    Element *element_hospital_1 = [[Element alloc] initWithTitle:clientHospital.emails[1].title
                                                         checked:_checkedByDefaults];
    // Hospital Level
    Level *level_hospital = [[Level alloc] initWithTitle:@"Hospitals"
                                                    data:@[element_hospital_0, element_hospital_1]
                                        addOptionEnabled:YES];
    
    /////////////////////////////
    Element *element_department_0 = [[Element alloc] initWithTitle:@"hard_0@coded.org"
                                                           checked:_checkedByDefaults];
    Element *element_department_1 = [[Element alloc] initWithTitle:@"hard_1@coded.org"
                                                           checked:_checkedByDefaults];
    Element *element_department_1_0 = [[Element alloc] initWithTitle:@"hard_2@coded.org"
                                                             checked:_checkedByDefaults];
    Element *element_department_1_1 = [[Element alloc] initWithTitle:@"hard_3@coded.org"
                                                             checked:_checkedByDefaults];
    
    
    Level *level_department_0 = [[Level alloc] initWithTitle:@"Sub Departments"
                                                        data:@[element_department_0, element_department_1]
                                            addOptionEnabled:YES];
    
    Level *level_department_1 = [[Level alloc] initWithTitle:@"Sub Departments"
                                                        data:@[element_department_1_0, element_department_1_1]
                                            addOptionEnabled:YES];
    
    // Department Level
    Level *level_department = [[Level alloc] initWithTitle:@"Departments"
                                                      data:@[level_department_0, level_department_1]
                                          addOptionEnabled:YES];
    
    
    Level *levelRoot = [[Level alloc] initWithTitle:@"Root Table"
                                               data:@[level_building, level_hospital, level_department]
                                   addOptionEnabled:NO];
    
    return levelRoot;
}


- (IBAction)awesomeButtonAction:(UIButton *)sender {
    NSLog(@"%@", self.rootLevel);
}


@end
