//
//  ArrayDataSource.m
//  RTLS
//
//  Created by jaime on 2019/3/2.
//  Copyright © 2019 foxconn.ios. All rights reserved.
//

#import "ArrayDataSource.h"
#import "ModelConfigProtocol.h"

@interface ArrayDataSource()

@end

@implementation ArrayDataSource

- (id)itemAtIndexPath:(NSIndexPath *)indexPath {
    
    return self.items[(NSUInteger) indexPath.row];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    id<ModelConfigProtocol> item = [self itemAtIndexPath:indexPath];
    
    id cell = [tableView dequeueReusableCellWithIdentifier:[item cellReuseIdentifier] forIndexPath:indexPath];
    
    if ([self.delegate respondsToSelector:@selector(configureCell:withItem:)]) {
        [self.delegate configureCell:cell withItem:item];
    }
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.items.count;
}

@end

