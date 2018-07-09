//
//  SKSelfNavigableTableViewProxy.h
//  AdditionalTable
//
//  Created by Serhii K on 7/5/18.
//  Copyright © 2018 Serhii K. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "SKTitleProvider.h"
#import "SKLevel.h"

@interface SKSelfNavigableTableViewProxy : NSObject <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) SKLevel *datasourceLevel;
@property (strong, nonatomic) NSMutableArray<NSString *> *emailsAddedManually;

- (instancetype)initWithDatasource:(SKLevel *)datasourceLevel
                      forTableView:(UITableView *)table  NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;

- (void)markAllCellsChecked; //TODO protocol

@end