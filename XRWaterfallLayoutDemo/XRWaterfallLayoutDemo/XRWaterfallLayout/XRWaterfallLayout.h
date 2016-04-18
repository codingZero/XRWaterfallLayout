//
//  XRWaterfallLayout.h
//
//  Created by 肖睿 on 16/3/29.
//  Copyright © 2016年 XR. All rights reserved.
//


#import <UIKit/UIKit.h>
@class XRWaterfallLayout;

@protocol XRWaterfallLayoutDelegate <NSObject>

@required
//计算item高度的代理方法，将item的高度与indexPath传递给外界
- (CGFloat)waterfallLayout:(XRWaterfallLayout *)waterfallLayout itemHeightForWidth:(CGFloat)itemWidth atIndexPath:(NSIndexPath *)indexPath;

@end



/**
 *实现了瀑布流功能，但是不能添加头部和底部视图，如项目中有添加头部或底部视图的需求，请慎用！！！
 */
@interface XRWaterfallLayout : UICollectionViewLayout

#pragma mark- 属性
//总共多少列，默认是2
@property (nonatomic, assign) NSInteger columnCount;

//列间距，默认是0
@property (nonatomic, assign) NSInteger columnSpacing;

//行间距，默认是0
@property (nonatomic, assign) NSInteger rowSpacing;

//section与collectionView的间距，默认是（0，0，0，0）
@property (nonatomic, assign) UIEdgeInsets sectionInset;

//同时设置列间距，行间距，sectionInset
- (void)setColumnSpacing:(NSInteger)columnSpacing rowSpacing:(NSInteger)rowSepacing sectionInset:(UIEdgeInsets)sectionInset;

/**
 以下代理属性与block属性二选一，用来设置每一个item的高度
 会将item的宽度与indexPath传递给外界
 如果两个都设置，block的优先级高，即代理无效
 */

//代理，用来计算item的高度
@property (nonatomic, weak) id<XRWaterfallLayoutDelegate> delegate;

//计算item高度的block，将item的高度与indexPath传递给外界
@property (nonatomic, strong) CGFloat(^itemHeightBlock)(CGFloat itemHeight,NSIndexPath *indexPath);


#pragma mark- 构造方法
+ (instancetype)waterFallLayoutWithColumnCount:(NSInteger)columnCount;
- (instancetype)initWithColumnCount:(NSInteger)columnCount;
@end
