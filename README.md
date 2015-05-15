# TestVisual_format_language
再也不用担心，如何做适配了。
使用苹果官方提供的适配方案当然是最正宗的，比第三房框架可控。
可以适配各种屏幕尺寸，以及横竖屏，欢迎有独特简介的极客们，提出宝贵意见

开发过程中，时常会遇到cell自适应高度与横屏下的宽度，传统的做法要么是手动计算frame，要么就是使用xib。
第一种方式，工作量是巨大的（相信很多人深有体会）。
第二种方式，对于协同开发和有些不用xib公司来说，有些可望不可及。
第三种方式，手写constraints。手写过的猿猿们一定体会到会有多少行代码。
其实还有一种看起来不是很友好的方式，那就是使用苹果官方提供的vsl。官方文档地址https://developer.apple.com/library/ios/documentation/UserExperience/Conceptual/AutolayoutPG/VisualFormatLanguage/VisualFormatLanguage.html#//apple_ref/doc/uid/TP40010853-CH3-SW1

网上对于这种方式的demo少之又少，官方提供的解释更是简洁不明了。于是花了半天时间研究一番，并写一个demo，便于共同学习。有不同看法的猿猿们，欢迎提出。

下面进入正题：
管理tableview的controller里，只用这样写
_tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.translatesAutoresizingMaskIntoConstraints = NO;
    _tableView.estimatedRowHeight = 44;
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_tableView]-0-|" options:0 metrics:0 views:@{@"_tableView":_tableView}]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_tableView]-|" options:0 metrics:0 views:@{@"_tableView":_tableView}]];
    
    
    tableview的datasource 和delegate只需要实现两个方法，
    #pragma mark - tableview delegate datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _rows.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[CustomTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.model = self.rows[indexPath.row];
    return cell;
}

是不是少了很多代码。

那么核心的cell里应该怎么写呢？
只需这样//add constraints
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[_leftImageView(==width)]" options:0 metrics:@{@"width":@imageView_size} views:@{@"_leftImageView":_leftImageView}]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[_leftImageView(==height)]" options:0 metrics:@{@"height":@imageView_size} views:@{@"_leftImageView":_leftImageView}]];

爽不爽，不用写很多frame了吧，这就是全部的布局，对，就是这么简单！
