//
//  SKLevelTableViewCell.h
//  AdditionalTable
//
//  Created by Serhii K on 7/4/18.
//  Copyright © 2018 Serhii K. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SKLevelTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *mainTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *additionalInfoTextLabel;

@end