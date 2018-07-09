//
//  NSString+SKEmailValidation.m
//  AdditionalTable
//
//  Created by Serhii K on 7/9/18.
//  Copyright © 2018 Serhii K. All rights reserved.
//

#import "NSString+SKEmailValidation.h"

@implementation NSString (SKEmailValidation)


- (BOOL)isValidEmail {
    NSString *emailRegex = @"^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

@end
