//
//  BaseCell.m
//  面向协议开发Demo
//
//  Created by jaime on 2019/9/20.
//  Copyright © 2019 qinghua.ios. All rights reserved.
//

#import "BaseCell.h"
#import "BaseModel.h"

@implementation BaseCell

- (void)setModel:(id)model {
    
    BaseModel *baseModel = model;
    self.textLabel.text = baseModel.text;
}

@end
