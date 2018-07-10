//
//  SKLevelTableViewCell.m
//  AdditionalTable
//
//  Created by Serhii K on 7/4/18.
//  Copyright © 2018 Serhii K. All rights reserved.
//

#import "SKLevelTableViewCell.h"

@implementation SKLevelTableViewCell


- (IBAction)additionalButtonAction:(UIButton *)sender {
    [self.delegate actionForLevelTableViewCell:self];
}


@end
