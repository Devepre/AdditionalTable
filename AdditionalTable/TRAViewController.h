//
//  TRAViewController.h
//  AdditionalTable
//
//  Created by Serhii K on 7/5/18.
//  Copyright © 2018 Serhii K. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ContactsUI/ContactsUI.h>
#import <Contacts/Contacts.h>
@class Level;

@interface TRAViewController : UIViewController <CNContactPickerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) Level *rootLevel;
// For internal use only
@property (strong, nonatomic) NSMutableArray<NSString *> *emailsAddedManually;

- (IBAction)awesomeButtonAction:(UIButton *)sender;
- (IBAction)addFromContacts:(UIButton *)sender;

@end
