//
//  YJDropdownListView.m
//  YJDropdownListExample
//
//  Created by Mac on 2017/6/7.
//  Copyright © 2017年 Jeremiah. All rights reserved.
//

#import "YJDropdownListView.h"
#define kWeakSelf     __weak typeof(self) weakSelf = self;
#define KScreenWidth  [[UIScreen mainScreen] bounds].size.width
#define KScreenHeight [[UIScreen mainScreen] bounds].size.height
#define kWindow       [UIApplication sharedApplication].delegate.window

@interface YJDropdownListView()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, weak) UITableView *tableView;
//弹出下拉列表的控件
@property (nonatomic, weak) UIView  *superView;
@property (nonatomic, copy) DropdownItemsBlock itemsBlock;
@property (nonatomic, copy) DropdownRowsNumBlock rowsNumBlock;
@property (nonatomic, copy) DropdownRowHeightBlock rowHeightBlock;
@property (nonatomic, copy) DropdownCellBlock cellBlock;
@property (nonatomic, copy) DropdownSelectRowBlock selectBlock;
@end
@implementation YJDropdownListView
#pragma mark - init
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}
+ (instancetype)dropDownListView
{
    return [[self alloc]init];
}
#pragma mark - setup
- (void)setup{
    self.backgroundColor = [UIColor clearColor];
    [self setFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight)];
    // tableView
    UITableView *tableView = [[UITableView alloc]initWithFrame:self.bounds style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.backgroundColor = [UIColor clearColor];
    tableView.bounces = NO;
    [self addSubview:tableView];
    self.tableView = tableView;
}

#pragma mark - getter
- (DropdownListItems)items
{
    kWeakSelf
    return ^YJDropdownListView *(DropdownItemsBlock itemsBlock) {
        weakSelf.itemsBlock = itemsBlock;
        return weakSelf;
    };
}
- (DropdownRowsNumberInSection)numberOfRowsInSection
{
    kWeakSelf
    return ^YJDropdownListView *(DropdownRowsNumBlock rowsNumBlock) {
        weakSelf.rowsNumBlock = rowsNumBlock;
        return weakSelf;
    };
}
- (DropdownRowHeightAtIndexPath)heightForRowAtIndexPath
{
    kWeakSelf
    return ^YJDropdownListView *(DropdownRowHeightBlock rowHeightBlock) {
        weakSelf.rowHeightBlock = rowHeightBlock;
        return weakSelf;
    };
}
- (DropdownConfigureCell)cellForRowAtIndexPath
{
    kWeakSelf
    return ^YJDropdownListView *(DropdownCellBlock cellBlock) {
        weakSelf.cellBlock = cellBlock;
        return weakSelf;
    };
}
- (DropdowndSelectRowAtIndexPath)didSelectRowAtIndexPath
{
    kWeakSelf
    return ^YJDropdownListView *(DropdownSelectRowBlock selectBlock) {
        weakSelf.selectBlock = selectBlock;
        return weakSelf;
    };
}
- (DropdownListShow)showOnSuperview
{
    kWeakSelf
    return ^YJDropdownListView *(UIView *superView) {
        weakSelf.superView = superView;
        [weakSelf show];
        return weakSelf;
    };
}
- (void)show {
    //校验合法性
    [self validateProcess];
    [kWindow endEditing:YES];
    [kWindow addSubview:self];
    CGRect rect = [self.superView convertRect:self.superView.bounds toView:kWindow];
    self.tableView.frame = CGRectMake(CGRectGetMinX(rect),
                                          CGRectGetMaxY(rect),
                                          CGRectGetWidth(rect),
                                          0);
    [UIView animateWithDuration:0.2
                     animations:^{
                         self.tableView.frame = CGRectMake(CGRectGetMinX(rect),
                                                               CGRectGetMaxY(rect),
                                                               CGRectGetWidth(rect),
                                                               [self figureTableHeight]);
                     }];

}
- (void)dismiss {
    CGRect rect = [self.superView convertRect:self.superView.bounds toView:kWindow];
    kWeakSelf
    [UIView animateWithDuration:0.2
                     animations:^{
                         _tableView.frame = CGRectMake(CGRectGetMinX(_tableView.frame),
                                                       CGRectGetMaxY(rect),
                                                       CGRectGetWidth(_tableView.frame),
                                                       0);
                     } completion:^(BOOL finished) {
                         [weakSelf removeFromSuperview];
                     }];
}
- (void)validateProcess {
    
    NSMutableArray *faildReason = [[NSMutableArray alloc]init];
    
    //规则：不指定superView时，不能执行showOnSuperview()
    if (!self.superView) {
        [faildReason addObject:@"未指定列表需要展示在哪个视图下不能执行showOnSuperview()"];
    }
    //规则：不执行items()或者numberOfRowsInSection()时，不能执行showOnSuperview()
    if (!self.itemsBlock&&!self.rowsNumBlock) {
        [faildReason addObject:@"未执行items()或者numberOfRowsInSection()不能执行showOnSuperview()"];
    }

    //抛出异常
    if ([faildReason lastObject]) {
        NSException *e = [NSException exceptionWithName:@"YJDropdownListView usage exception" reason:[faildReason lastObject]  userInfo:nil];
        @throw e;
    }
    
}
- (YJDropdownListView *) and {
    return self;
}
- (YJDropdownListView *) then {
    return self;
}
- (YJDropdownListView *) with {
    return self;
}
/**
 *
 *  计算 table 的高度 (上限200)
 */
- (CGFloat)figureTableHeight {
    CGFloat maxHeight = 200.;
    NSInteger number = 0;
    if (self.rowsNumBlock) {
        number = self.rowsNumBlock(0);
    }else if(self.itemsBlock)
    {
        number = self.itemsBlock().count;
    }
    __block CGFloat height = 0.0f;
    for (NSInteger i = 0; i < number; i ++) {
        CGFloat h = [self tableView:self.tableView heightForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        height = height + h;
    }
    if (height>maxHeight) {
        height=maxHeight;
        self.tableView.scrollEnabled = YES;
    }else
    {
        self.tableView.scrollEnabled = NO;
    }
    return height;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.rowsNumBlock) {
        return self.rowsNumBlock(section);
    }else if (self.itemsBlock)
    {
        return self.itemsBlock().count;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"itemCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    if (self.itemsBlock) {
        cell.textLabel.text = self.itemsBlock()[indexPath.row];
    }
    return  self.cellBlock?self.cellBlock(tableView,indexPath,cell):cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.rowHeightBlock?self.rowHeightBlock(indexPath):44.f;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self dismiss];
    if (self.selectBlock) {
        self.selectBlock(tableView, indexPath);
    }
}
#pragma mark - layout
- (void)layoutSubviews{
    [super layoutSubviews];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self dismiss];
}
@end
