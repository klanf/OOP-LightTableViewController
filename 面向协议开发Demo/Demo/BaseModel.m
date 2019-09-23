//
//  BaseModel.m
//  面向协议开发Demo
//
//  Created by jaime on 2019/9/20.
//  Copyright © 2019 qinghua.ios. All rights reserved.
//

#import "BaseModel.h"
#import "ModelConfigProtocol.h"

@implementation BaseModel

//实现协议方法

- (nullable NSString*)cellReuseIdentifier {
    
    return @"reuseIdentifier";
}

- (NSString *)cellType {
    
    return @"BaseCell";
}


@end
