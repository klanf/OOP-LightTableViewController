//
//  ModelConfigProtocol.h
//  面向协议开发Demo
//
//  Created by jaime on 2019/9/20.
//  Copyright © 2019 qinghua.ios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@protocol ModelConfigProtocol <NSObject>

@required
/**
 
 获取 cell 的复用标识
 
 @return 复用标识
 
 */

- (nullable NSString*)cellReuseIdentifier;

/**
 
 获取 cell 的类型
 
 @return cell 的类型
 
 */

- (NSString *)cellType;


@optional

/**
 
 获取 cell 的高度
 
 @param indexPath indexPath
 
 @return 高度
 
 */

- (CGFloat)cellHeightWithindexPath:(NSIndexPath*)indexPath;

/**
 
 cell 点击
 
 @param indexPath indexPath
 
 @param other 其它对象
 
 */

- (void)cellDidSelectRowAtIndexPath:(NSIndexPath*)indexPath other:(_Nullable id)other;



@end

NS_ASSUME_NONNULL_END
