//
//  YJDropdownListView.h
//  CanYin
//
//  Created by Mac on 2017/6/7.
//  Copyright © 2017年 Zhongao. All rights reserved.
//
//  下拉列表

#import <UIKit/UIKit.h>
@class YJDropdownListView;

typedef NSArray<NSString *> *(^DropdownItemsBlock)();
typedef NSInteger(^DropdownRowsNumBlock)(NSInteger section);
typedef CGFloat(^DropdownRowHeightBlock)(NSIndexPath *indexPath);
typedef UITableViewCell *(^DropdownCellBlock)(UITableView *tableView,NSIndexPath *indexPath,UITableViewCell *cell);
typedef void (^DropdownSelectRowBlock)(UITableView *tableView,NSIndexPath *indexPath);

typedef YJDropdownListView *(^DropdownListItems)(DropdownItemsBlock itemsBlock);
typedef YJDropdownListView *(^DropdownRowsNumberInSection)(DropdownRowsNumBlock rowsNumBlock);
typedef YJDropdownListView *(^DropdownRowHeightAtIndexPath)(DropdownRowHeightBlock rowHeightBlock);
typedef YJDropdownListView *(^DropdownConfigureCell)(DropdownCellBlock cellBlock);
typedef YJDropdownListView *(^DropdowndSelectRowAtIndexPath)(DropdownSelectRowBlock selectBlock);
typedef YJDropdownListView *(^DropdownListShow)(UIView *superView);
@interface YJDropdownListView : UIView
///列表items数据源
@property (nonatomic, copy ,readonly) DropdownListItems items;
///列表行数
@property (nonatomic, copy ,readonly) DropdownRowsNumberInSection numberOfRowsInSection;
///行高
@property (nonatomic, copy ,readonly) DropdownRowHeightAtIndexPath heightForRowAtIndexPath;
///自己构造cell数据源
@property (nonatomic, copy ,readonly) DropdownConfigureCell cellForRowAtIndexPath;
///cell选中
@property (nonatomic, copy ,readonly) DropdowndSelectRowAtIndexPath didSelectRowAtIndexPath;
///show
@property (nonatomic, copy ,readonly) DropdownListShow showOnSuperview;
/**
 谓词，返回self
 */
- (YJDropdownListView *) and;
/**
 谓词，返回self
 */
- (YJDropdownListView *) then;
/**
 谓词，返回self
 */
- (YJDropdownListView *) with;
+ (instancetype)dropDownListView;
- (void)show;
- (void)dismiss;
@end
