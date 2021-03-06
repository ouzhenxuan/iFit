//
//  ZXBottomMultiPurposeView.m
//  TopHot
//
//  Created by Liushannoon on 16/4/12.
//  Copyright © 2016年 Liushannoon. All rights reserved.
//

#define itemCountInOneScreen 4

#import "ZXBottomMultiPurposeView.h"
#import "ZXBottomMultiPurposeViewItem.h"
#import "ZXBottomMultiPurposeViewCollectionCell.h"

@interface ZXBottomMultiPurposeView () <UICollectionViewDataSource , UICollectionViewDelegate>
/**
 *  代理
 */
@property (nonatomic , weak) id <ZXBottomMultiPurposeViewDelegate> delegate;
/**
 *  取消label,添加取消手势
 */
@property (weak, nonatomic) IBOutlet UILabel *cancelLabel;
/**
 *  最上面的title
 */
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
/**
 *  上半部的黑色view
 */
@property (weak, nonatomic) IBOutlet UIView *blackView;
/**
 *  底部栏的容器view,单行模式的时候,要隐藏
 */
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIView *baseView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *baseViewHeightConstraint;
@property (weak, nonatomic) IBOutlet UIView *separateView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *baseViewBottomConstraint;
/**
 *  上半部collectionView
 */
@property (weak, nonatomic) IBOutlet UICollectionView *topCollectionView;
/**
 *  下半部collectionView
 */
@property (weak, nonatomic) IBOutlet UICollectionView *bottomCollectionView;

/**
 *  顶部数据源
 */
@property (nonatomic , strong) NSMutableArray *topDatas;
/**
 *  底部数据源
 */
@property (nonatomic , strong) NSMutableArray *bottomDatas;


@end

/**
 *  cell的重用ID
 */
static NSString *const cellID = @"ZXBottomMultiPurposeViewCollectionCellID";
static NSString *const cellIDbottom = @"ZXBottomMultiPurposeViewCollectionCellIDbottom";

@implementation ZXBottomMultiPurposeView

- (NSMutableArray *)topDatas
{
    if (_topDatas == nil) {
        _topDatas = [NSMutableArray array];
    }
    
    return _topDatas;
}

- (NSMutableArray *)bottomDatas
{
    if (_bottomDatas == nil) {
        _bottomDatas = [NSMutableArray array];
    }
    
    return _bottomDatas;
}

- (void)awakeFromNib
{
    [self initial];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initial];
    }
    return self;
}

/**
 *  初始化
 */
- (void)initial
{
    // 流水布局对象,设置cell的尺寸和位置
    UICollectionViewFlowLayout *layout  = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    CGFloat cellXMargin = 130 / 3.0 * zx_autoSizeScaleX;
    CGSize itemSize = CGSizeMake((ZXScreenW - (130 * 3 + 90 * 2) / 3.0 * zx_autoSizeScaleX ) / itemCountInOneScreen, self.topCollectionView.zx_height - 22 - 10 );
    UIEdgeInsets inset = UIEdgeInsetsMake(19 , 30 * zx_autoSizeScaleX, 10,0);
    layout.itemSize = itemSize;
    layout.sectionInset = inset;
    layout.minimumLineSpacing = cellXMargin;
    self.topCollectionView.collectionViewLayout = layout;
    self.topCollectionView.delegate = self;
    self.topCollectionView.dataSource = self;
    self.topCollectionView.backgroundColor = [UIColor clearColor];
    self.topCollectionView.showsHorizontalScrollIndicator = YES;
    self.topCollectionView.showsVerticalScrollIndicator = NO;
    [self.topCollectionView registerNib:[UINib nibWithNibName:NSStringFromClass([ZXBottomMultiPurposeViewCollectionCell class]) bundle:nil] forCellWithReuseIdentifier:cellID];

    // 流水布局对象,设置cell的尺寸和位置
    UICollectionViewFlowLayout *layoutBottom  = [[UICollectionViewFlowLayout alloc] init];
    layoutBottom.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layoutBottom.itemSize = itemSize;
    layoutBottom.sectionInset = inset;
    layoutBottom.minimumLineSpacing = cellXMargin; // item间距
    self.bottomCollectionView.collectionViewLayout = layoutBottom;
    self.bottomCollectionView.backgroundColor = [UIColor clearColor];
    self.bottomCollectionView.delegate = self;
    self.bottomCollectionView.dataSource = self;
    [self.bottomCollectionView registerNib:[UINib nibWithNibName:NSStringFromClass([ZXBottomMultiPurposeViewCollectionCell class]) bundle:nil] forCellWithReuseIdentifier:cellIDbottom];
    
    self.cancelLabel.userInteractionEnabled = YES;
    [self.cancelLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickCancel)]];
    [self.blackView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickCancel)]];

    self.frame = ZXKeyWindow.bounds;
    self.cancelLabel.font = S3;
    self.cancelLabel.textColor = C2;
    self.separateView.backgroundColor = C10;
    
    self.cancelLabel.text = NSLocalizedString(@"取消", nil);
    
}
/**
 *  点击取消
 */
- (void)clickCancel
{
    if ([self.delegate respondsToSelector:@selector(bottomMultiPurposeViewClickCancelButton)]) {
        [self.delegate bottomMultiPurposeViewClickCancelButton];
    }
    [self removeSelfFromSuperView];
}

/**
 *  从父控件移除
 */
- (void)removeSelfFromSuperView
{
    self.baseViewBottomConstraint.constant = - self.baseView.zx_height;
    [UIView animateWithDuration:0.25 animations:^{
        self.blackView.alpha = 0.0;
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
#pragma mark    -   给外界使用的方法

/**
 *  提供了几种常用的样式
 *
 *  @param type 样式
 */
- (void)showBottomMultiPurposeViewWithType:(ZXBottomMultiPurposeViewType)type
{
    
}

/**
 *  提供数据,展示视图
 *
 *  @param topImages        顶部图片数组
 *  @param topHighImages    顶部栏点击状态的图片数组
 *  @param topTexts         顶部栏文字数组
 *  @param bottomImages     底部栏的图片数组
 *  @param bottomHighImages 底部栏的点击状态图片数组
 *  @param bottomTexts      顶部栏的文字数组
 *  @param title            顶部的title
 *  @param delegate         代理
 */
+ (void)showBottomMultiPurposeViewWithTopItemsImageArray:(NSArray *)topImages topHighImageArray:(NSArray *)topHighImages topItemsTextArray:(NSArray *)topTexts bottomItemsImageArray:(NSArray *)bottomImages bottomHighImageArray:(NSArray *)bottomHighImages bottomItemsTextArray:(NSArray *)bottomTexts  delegate:(id <ZXBottomMultiPurposeViewDelegate>)delegate topTitleLabelText:(NSString *)title;
{
    ZXBottomMultiPurposeView *view = [self zx_viewFromXib];
    view.delegate = delegate;
    [view showBottomMultiPurposeViewWithTopItemsImageArray:topImages topHighImageArray:topHighImages topItemsTextArray:topTexts bottomItemsImageArray:bottomImages bottomHighImageArray:bottomHighImages bottomItemsTextArray:bottomTexts topTitleLabelText:title];
}

/**
 *  提供数据,展示视图
 *
 *  @param topImages        顶部图片数组
 *  @param topHighImages    顶部栏点击状态的图片数组
 *  @param topTexts         顶部栏文字数组
 *  @param bottomImages     底部栏的图片数组
 *  @param bottomHighImages 底部栏的点击状态图片数组
 *  @param bottomTexts      顶部栏的文字数组
 *  @param title            顶部的title
 */
- (void)showBottomMultiPurposeViewWithTopItemsImageArray:(NSArray *)topImages topHighImageArray:(NSArray *)topHighImages topItemsTextArray:(NSArray *)topTexts bottomItemsImageArray:(NSArray *)bottomImages bottomHighImageArray:(NSArray *)bottomHighImages bottomItemsTextArray:(NSArray *)bottomTexts topTitleLabelText:(NSString *)title
{
    [self.topDatas removeAllObjects];
    [self.bottomDatas removeAllObjects];
    if (topImages.count != topTexts.count) {
        return ;
    } else {
        for (int i = 0; i < topImages.count; i ++) {
            ZXBottomMultiPurposeViewItem *item = [[ZXBottomMultiPurposeViewItem alloc] initWithImage:topImages[i] highImage:topHighImages[i] title:topTexts[i]];
            [self.topDatas addObject:item];
        }
    }
    
    if (bottomImages.count != bottomTexts.count) {
        return ;
    } else {
        for (int i = 0; i < bottomImages.count; i ++) {
            ZXBottomMultiPurposeViewItem *item = [[ZXBottomMultiPurposeViewItem alloc] initWithImage:bottomImages[i] highImage:bottomHighImages[i] title:bottomTexts[i]];
            [self.bottomDatas addObject:item];
        }
    }
    
    if (self.bottomDatas.count == 0) {
        self.baseViewHeightConstraint.constant = 261 - 111;
        self.bottomView.hidden = YES;
        // 9.3.2 移除后,就不会包约束冲突的异常了
        [self.bottomView removeFromSuperview];
    } else {
        self.baseViewHeightConstraint.constant = 261;
        self.bottomView.hidden = NO;
    }
    self.baseViewBottomConstraint.constant = -self.baseViewHeightConstraint.constant;
    
    self.titleLabel.text = title;
    
    [self.bottomCollectionView reloadData];
    [self.topCollectionView reloadData];
    [ZXKeyWindow addSubview:self];
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
    
    [self showBottomMutilPurposeView];
}

- (void)showBottomMutilPurposeView
{
    self.baseViewBottomConstraint.constant = 0;
    
    [UIView animateWithDuration:0.25 animations:^{
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        
    }];
//    //创建一个弹簧动画对象
//    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
//    //设定开始时间
//    anim.beginTime = CACurrentMediaTime();
//    //这两个一起用来设置弹簧效果
//    anim.springBounciness = 4;
//    anim.springSpeed = 20;
//    //动画针对：从哪个值改成哪个值    (可以没有fromValue)
//    anim.fromValue = [NSValue valueWithCGPoint:CGPointMake(100, 100)];
//    anim.toValue = [NSValue valueWithCGPoint:CGPointMake(200, 200)];
//    //完成动画回调这个block
//    anim.completionBlock = ^(POPAnimation *anim, BOOL finished){
//        XMGLog(@"-----动画结束");
//    };
//    //添加动画到某个对象上面
//    [self.sloganView pop_addAnimation:anim forKey:nil];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (collectionView == self.topCollectionView) {
        return self.topDatas.count;
    } else if (collectionView == self.bottomCollectionView) {
        return self.bottomDatas.count;
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (collectionView == self.topCollectionView) {
        ZXBottomMultiPurposeViewCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
        cell.item = self.topDatas[indexPath.row];
        return cell;
    } else if (collectionView == self.bottomCollectionView) {
        ZXBottomMultiPurposeViewCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIDbottom forIndexPath:indexPath];
        cell.item = self.bottomDatas[indexPath.row];
        return cell;
    }
    return nil;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView == self.topCollectionView) {
        if ([self.delegate respondsToSelector:@selector(bottomMultiPurposeView:clickTopItemIndex:)]) {
            [self.delegate bottomMultiPurposeView:self clickTopItemIndex:indexPath.row];
        }
    } else if (collectionView == self.bottomCollectionView) {
        if ([self.delegate respondsToSelector:@selector(bottomMultiPurposeView:clickBottomItemIndex:)]) {
            [self.delegate bottomMultiPurposeView:self clickBottomItemIndex:indexPath.row];
        }
    }
}

@end
