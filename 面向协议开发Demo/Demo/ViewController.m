//
//  ViewController.m
//  面向协议开发Demo
//
//  Created by jaime on 2019/9/20.
//  Copyright © 2019 qinghua.ios. All rights reserved.
//

#import "ViewController.h"
#import "ModelConfigProtocol.h"
#import "ArrayDataSource.h"
#import "BaseModel.h"
#import "BaseCell.h"

@interface ViewController ()<ArrayDataSourceDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) ArrayDataSource *arrayDataSource;
@property (nonatomic,strong) NSMutableArray *dataArray;

@end

@implementation ViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.arrayDataSource.items = self.dataArray;
    self.tableView.dataSource = self.arrayDataSource;
}

#pragma mark - ArrayDataSourceDelegate
- (void)configureCell:(id)cell withItem:(id<ModelConfigProtocol>)item {
    
    //设置cell的属性
    if ([[item cellType] isEqualToString:@"BaseCell"]) {
        [((BaseCell *)cell) setModel:item];
    }
}

#pragma mark - getter
- (ArrayDataSource *)arrayDataSource {
    
    if (!_arrayDataSource) {
        _arrayDataSource = [[ArrayDataSource alloc] init];
        _arrayDataSource.delegate = self;
    }
    
    return _arrayDataSource;
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        
        _dataArray = [NSMutableArray array];
        
        //模拟数据
        NSMutableArray *tmpArray = [NSMutableArray array];
        for (int i = 0; i<7; i++) {
            BaseModel *baseModel = [[BaseModel alloc] init];
            baseModel.text = [NSString stringWithFormat:@"%d",i];
            [tmpArray addObject:baseModel];
        }
        _dataArray = tmpArray;
    }
    return _dataArray;
}

@end
