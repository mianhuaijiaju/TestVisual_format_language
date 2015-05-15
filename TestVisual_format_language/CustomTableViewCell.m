 

#import "CustomTableViewCell.h"

@interface CustomTableViewCell ()
@property (strong, nonatomic) UIImageView *leftImageView;
@property (strong, nonatomic) UILabel     *topLabel;
@property (strong, nonatomic) UILabel     *bottomLabel;
@end

@implementation CustomTableViewCell

#define imageView_size 40

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews
{
    //init subviews
    _leftImageView                                           = [UIImageView new];
    _leftImageView.backgroundColor                           = [UIColor redColor];
    _leftImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:_leftImageView];

    _topLabel                                                = [UILabel new];
    _topLabel.numberOfLines                                  = 0;
    _topLabel.backgroundColor                                = [UIColor cyanColor];
    _topLabel.translatesAutoresizingMaskIntoConstraints      = NO;
    [self.contentView addSubview:_topLabel];

    _bottomLabel                                             = [UILabel new];
    _bottomLabel.font = [UIFont systemFontOfSize:15.0];
    _bottomLabel.numberOfLines                               = 0;
    _bottomLabel.backgroundColor                             = [UIColor yellowColor];
    _bottomLabel.translatesAutoresizingMaskIntoConstraints   = NO;
    [self.contentView addSubview:_bottomLabel];
    
    //add constraints
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[_leftImageView(==width)]" options:0 metrics:@{@"width":@imageView_size} views:@{@"_leftImageView":_leftImageView}]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[_leftImageView(==height)]" options:0 metrics:@{@"height":@imageView_size} views:@{@"_leftImageView":_leftImageView}]];

    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_leftImageView]-[_topLabel]-20-|" options:0 metrics:nil views:@{@"_leftImageView":_leftImageView,@"_topLabel":_topLabel}]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_leftImageView]-(inset_y)-[_topLabel(>=20)]" options:0 metrics:@{@"inset_y":@(-imageView_size)} views:@{@"_leftImageView":_leftImageView,@"_topLabel":_topLabel}]];

    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[_bottomLabel]-20-|" options:0 metrics:nil views:@{@"_bottomLabel":_bottomLabel}]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_leftImageView]-[_bottomLabel(>=20)]"options:0 metrics:nil views:@{@"_leftImageView":_leftImageView,@"_bottomLabel":_bottomLabel}]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_bottomLabel]-|" options:0 metrics:nil views:@{@"_bottomLabel":_bottomLabel}]];
}

- (void)setModel:(CustomModel *)model
{
    _model = model;
    _topLabel.text = model.title;
    _bottomLabel.text = model.detail;
}

@end
