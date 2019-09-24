# OOP-LightTableViewController
基于面向协议编程写一个更轻量化的ViewController

  相信我们都写过很多又臭又长的 UITableViewDataSource 代码，而如果把 UITableViewDataSource 的代码提取出来放到一个单独的类中不失为一种简化代码的
  手段，如将下面的代码
```
# pragma mark Pragma

- (Photo*)photoAtIndexPath:(NSIndexPath*)indexPath {
    return photos[(NSUInteger)indexPath.row];
}

- (NSInteger)tableView:(UITableView*)tableView
 numberOfRowsInSection:(NSInteger)section {
    return photos.count;
}

- (UITableViewCell*)tableView:(UITableView*)tableView
        cellForRowAtIndexPath:(NSIndexPath*)indexPath {
    PhotoCell* cell = [tableView dequeueReusableCellWithIdentifier:PhotoCellIdentifier forIndexPath:indexPath];
    Photo* photo = [self photoAtIndexPath:indexPath];
    cell.label.text = photo.name;
    return cell;
}
```
  作为一个arrayDataSource的模块提取出来，ViewController就可以减少一大部分的代码了，在ViewController调用的代码就变为下面这个样子的
```
self.tableView.dataSource = self.arrayDataSource;
```
  当然，为了这部分代码可以复用，可以对这部分代码进行一个改动
```
@implementation ArrayDataSource

- (id)itemAtIndexPath:(NSIndexPath*)indexPath {
    return items[(NSUInteger)indexPath.row];
}

- (NSInteger)tableView:(UITableView*)tableView
 numberOfRowsInSection:(NSInteger)section {
    return items.count;
}

- (UITableViewCell*)tableView:(UITableView*)tableView
        cellForRowAtIndexPath:(NSIndexPath*)indexPath {
    id cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    id item = [self itemAtIndexPath:indexPath];
    if ([self.delegate respondsToSelector:@selector(configureCell:withItem:)]) {
        [self.delegate configureCell:cell withItem:item];
    }
    return cell;
}

@end
```
  这里使用了代理，把需要给cell赋值的代码放到了ViewController中，在 ViewController 里赋值的代码可以这样写
```
#pragma mark - ArrayDataSourceDelegate
- (void)configureCell:(PhotoCell*)cell withItem:(Photo*)item {
    
    //设置cell的属性
    cell.label.text = item.xxx;
    ...
}
```
  在不复杂的业务里面，data source可能确实看上去只是一个数组而已，每次你想把这个数组显示到一个 table view 中时，你都可以复用这些代码。

  不过，在存在多个cell的情况下，免不了写大量的 if-else 判断代码，在此引入一个面向协议编程的方法，即根据model来对应cell，cell面向model开发<br>
  
  先定义一个 ModelConfigProtocol 协议接口
  ```
@protocol ModelConfigProtocol <NSObject>

@required
 
 获取 cell 的复用标识
 
- (nullable NSString*)cellReuseIdentifier;
 
 获取 cell 的类型
 
- (NSString *)cellType;


@optional
 
 获取 cell 的高度
 
 @return 高度

- (CGFloat)cellHeightWithindexPath:(NSIndexPath*)indexPath;

@end
  ```
  然后定义一个准守该协议的BaseModel,并实现该协议的方法
  ```
  @implementation BaseModel

//实现协议方法

- (nullable NSString*)cellReuseIdentifier {
    
    return @"reuseIdentifier";
}

- (NSString *)cellType {
    
    return @"BaseCell";
}
  
  ```
  然后对 ArrayDataSource 的 tableView:cellForRowAtIndexPath: 方法做点改动
  ```
  - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    id<ModelConfigProtocol> item = [self itemAtIndexPath:indexPath];
    
    id cell = [tableView dequeueReusableCellWithIdentifier:[item cellReuseIdentifier] forIndexPath:indexPath];
    
    if ([self.delegate respondsToSelector:@selector(configureCell:withItem:)]) {
        [self.delegate configureCell:cell withItem:item];
    }
    
    return cell;
}
  ```
 
   在 cell 中定义 id<ModelConfigProtocol> model 属性接收数据，接收数据可以这么写
```
- (void)setModel:(id)model {
    
    BaseModel *baseModel = model;
    self.textLabel.text = baseModel.text;
}

```
 
  在 ViewController 里赋值的代码可以这样写
```
#pragma mark - ArrayDataSourceDelegate
- (void)configureCell:(id)cell withItem:(id<ModelConfigProtocol>)item {
    
    //设置cell的属性
    if ([[item cellType] isEqualToString:@"BaseCell"]) {
        [((BaseCell *)cell) setModel:item];
    } else if ([[item cellType] isEqualToString:@"BaseCell2"]) {
        [((BaseCell2 *)cell) setModel:item];
    }
}
```
  以上就完成来基于面向协议编程写一个更轻量化的ViewController的代码
  
  参考：
  [简书：iOS多种类型的cell处理方案](https://www.jianshu.com/p/1d027d45565d)
  [Objc-中国 更轻量的 View Controllers](https://objccn.io/issue-1-1/)







