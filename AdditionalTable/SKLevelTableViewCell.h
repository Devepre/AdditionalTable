//
//  SKLevelTableViewCell.h
//  AdditionalTable
//
//  Created by Serhii K on 7/4/18.
//  Copyright © 2018 Serhii K. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SKLevelTableViewCellDelegate;

@interface SKLevelTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *mainTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *additionalInfoTextLabel;
@property (weak, nonatomic) IBOutlet UIButton *additionalButton;

@property (weak, nonatomic) id <SKLevelTableViewCellDelegate> delegate;

- (IBAction)additionalButtonAction:(UIButton *)sender;

@end


@protocol SKLevelTableViewCellDelegate <NSObject>

@optional
- (void)actionForLevelTableViewCell:(SKLevelTableViewCell *)levelTableViewCell;

@end
