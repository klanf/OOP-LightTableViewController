//
//  ArrayDataSource.h
//  RTLS
//
//  Created by jaime on 2019/3/2.
//  Copyright © 2019 foxconn.ios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@protocol ModelConfigProtocol;
NS_ASSUME_NONNULL_BEGIN

@protocol ArrayDataSourceDelegate <NSObject>

@required
- (void)configureCell:(id)cell withItem:(id<ModelConfigProtocol>)item;

@end

@interface ArrayDataSource : NSObject<UITableViewDataSource>

@property (nonatomic,strong) NSMutableArray *items;
@property (nonatomic ,weak) id<ArrayDataSourceDelegate> delegate;


- (id)itemAtIndexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
