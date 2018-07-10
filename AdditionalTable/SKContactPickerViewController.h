//
//  SKContactPickerViewController.h
//  AdditionalTable
//
//  Created by Limitation on 7/10/18.
//  Copyright © 2018 Serhii K. All rights reserved.
//

#import <ContactsUI/ContactsUI.h>

@protocol SKContactPickerDelegate;

@interface SKContactPickerViewController : CNContactPickerViewController

@property (weak, nonatomic, nullable) id <CNContactPickerDelegate, SKContactPickerDelegate> delegate;

@end


@protocol SKContactPickerDelegate <CNContactPickerDelegate>

@required
- (void)contactPicker:(SKContactPickerViewController *)picker viewDidDisappear:(BOOL)animated;

@optional
- (void)contactPicker:(SKContactPickerViewController *)picker viewWillDisappear:(BOOL)animated;

@end
