//
//  YJDropdownListView.h
//  YJDropdownListExample
//
//  Created by Jeremiah on 2017/6/7.
//  Copyright © 2017年 Jeremiah. All rights reserved.
//
//  文本框下拉列表

#import <UIKit/UIKit.h>
@class YJDropdownListView;
typedef NS_OPTIONS(NSInteger, YJListViewBorder) {
    YJListViewBorderAll    = 1 << 0, ///< 四周画线
    YJListViewBorderTop    = 1 << 1, ///< 顶部画线
    YJListViewBorderLeft   = 1 << 2, ///< 左边画线
    YJListViewBorderBottom = 1 << 3, ///< 底部画线
    YJListViewBorderRight  = 1 << 4, ///< 右边画线
};

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
/// 列表items数据源
@property (nonatomic, copy ,readonly) DropdownListItems items;
/// 列表行数
@property (nonatomic, copy ,readonly) DropdownRowsNumberInSection numberOfRowsInSection;
/// 行高
@property (nonatomic, copy ,readonly) DropdownRowHeightAtIndexPath heightForRowAtIndexPath;
/// 自己构造cell数据源
@property (nonatomic, copy ,readonly) DropdownConfigureCell cellForRowAtIndexPath;
/// cell选中
@property (nonatomic, copy ,readonly) DropdowndSelectRowAtIndexPath didSelectRowAtIndexPath;
/// show
@property (nonatomic, copy ,readonly) DropdownListShow showOnSuperview;
/// 边框颜色
@property (nonatomic, strong) UIColor *borderColor;
/// 边框宽度
@property (nonatomic, assign) CGFloat borderWidth;
/// 边框位置
@property (nonatomic, assign) YJListViewBorder borderPosition;
/// 最大高度 默认200
@property (nonatomic, assign) CGFloat maxHeight;
/// 相对于父视图在y轴的偏移量 默认为0
@property (nonatomic, assign) CGFloat offsetY;
/// 是否显示分割线 默认不显示
@property (nonatomic, assign) BOOL showSeparatorLine;
/// 分割线颜色
@property (nonatomic, strong) UIColor *separatorColor;
/// 分割线缩进
@property (nonatomic, assign) UIEdgeInsets separatorInset;

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

@interface UIView (Border)

@property (nonatomic, assign) YJListViewBorder borderPosition;

@end
