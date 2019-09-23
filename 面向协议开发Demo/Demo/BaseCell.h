//
//  BaseCell.h
//  面向协议开发Demo
//
//  Created by jaime on 2019/9/20.
//  Copyright © 2019 qinghua.ios. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ModelConfigProtocol;

NS_ASSUME_NONNULL_BEGIN

@interface BaseCell : UITableViewCell

@property (nonatomic, strong) id<ModelConfigProtocol> model;


@end

NS_ASSUME_NONNULL_END
