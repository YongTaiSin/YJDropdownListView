# YJDropdownListView
文本输入框下拉列表

<img src="https://github.com/mcyj1314/YJDropdownListView-master/blob/master/screenshots/screenshots1.png" width="30%" height="30%">

## Contents
* Comment API
	* [YJDropdownListView.h](#YJDropdownListView.h)

## <a id="How to use YJDropdownListView"></a>How to use YJDropdownListView
* Manual import：
    * Drag All files in the `YJDropdownListView` folder to project
    * Import the main file：`#import "YJDropdownListView.h"`
    
## Fluent style
* 采用链式布局，可以根据自己的具体需求将不同方法自由组合，使用更灵活，可定制性高：
```objc
YJDropdownListView *listView = [YJDropdownListView dropDownListView];
    NSArray *arr = @[@"haha",@"hehe",@"heoheo"];
    listView.numberOfRowsInSection(^NSInteger(NSInteger section) {
        return arr.count;
    }).cellForRowAtIndexPath(^UITableViewCell *(UITableView *tableView, NSIndexPath *indexPath, UITableViewCell *cell) {
        cell.textLabel.textColor = [UIColor redColor];
        cell.textLabel.text = arr[indexPath.row];
        return cell;
    }).heightForRowAtIndexPath(^CGFloat(NSIndexPath *indexPath) {
        return 50.f;
    }).showOnSuperview(self.accountTF).didSelectRowAtIndexPath(^void (UITableView *tableView,NSIndexPath *indexPath)
                                                               {
                                                                   NSLog(@"哈哈");
                                                               });
```

## Remind
* ARC
* iOS>=7.0
* iPhone \ iPad screen anyway
