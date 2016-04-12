//
//  XRWaterfallLayout.m
//
//  Created by 肖睿 on 16/3/29.
//  Copyright © 2016年 XR. All rights reserved.
//

#import "XRWaterfallLayout.h"
@interface XRWaterfallLayout()
//用来记录每一列的最大y值
@property (nonatomic, strong) NSMutableDictionary *maxYDic;
//保存每一个item的attributes
@property (nonatomic, strong) NSMutableArray *attributesArray;
@end

@implementation XRWaterfallLayout

#pragma mark- 懒加载
- (NSMutableDictionary *)maxYDic {
    if (!_maxYDic) {
        _maxYDic = [[NSMutableDictionary alloc] init];
    }
    return _maxYDic;
}

- (NSMutableArray *)attributesArray {
    if (!_attributesArray) {
        _attributesArray = [NSMutableArray array];
    }
    return _attributesArray;
}

#pragma mark- 构造方法
- (instancetype)init {
    if (self = [super init]) {
        self.columnCount = 2;
    }
    return self;
}

- (instancetype)initWithColumnCount:(NSInteger)columnCount {
    if (self = [super init]) {
        self.columnCount = columnCount;
    }
    return self;
}

+ (instancetype)waterFallLayoutWithColumnCount:(NSInteger)columnCount {
    return [[self alloc] initWithColumnCount:columnCount];
}

#pragma mark- 相关设置方法
- (void)setColumnSpacing:(NSInteger)columnSpacing rowSpacing:(NSInteger)rowSepacing sectionInset:(UIEdgeInsets)sectionInset {
    self.columnSpacing = columnSpacing;
    self.rowSpacing = rowSepacing;
    self.sectionInset = sectionInset;
}

#pragma mark- 布局相关方法
//布局前的准备工作
- (void)prepareLayout {
    [super prepareLayout];
    //初始化字典，有几列就有几个键值对，key为列，value为列的最大y值，初始值为上内边距
    for (int i = 0; i < self.columnCount; i++) {
        self.maxYDic[@(i)] = @(self.sectionInset.top);
    }
    
    //根据collectionView获取总共有多少个item
    NSInteger itemCount = [self.collectionView numberOfItemsInSection:0];
    [self.attributesArray removeAllObjects];
    //为每一个item创建一个attributes并存入数组
    for (int i = 0; i < itemCount; i++) {
        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        [self.attributesArray addObject:attributes];
    }
}

//计算collectionView的contentSize
- (CGSize)collectionViewContentSize {
    __block NSNumber *maxIndex = @0;
    //遍历字典，找出最长的那一列
    [self.maxYDic enumerateKeysAndObjectsUsingBlock:^(NSNumber *key, NSNumber *obj, BOOL *stop) {
        if ([self.maxYDic[maxIndex] floatValue] < obj.floatValue) {
            maxIndex = key;
        }
    }];
    
    //collectionView的contentSize.height就等于最长列的最大y值+下内边距
    return CGSizeMake(0, [self.maxYDic[maxIndex] floatValue] + self.sectionInset.bottom);
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    //根据indexPath获取item的attributes
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    //获取collectionView的宽度
    CGFloat collectionViewWidth = self.collectionView.frame.size.width;
    
    //item的宽度 = (collectionView的宽度 - 内边距与列间距) / 列数
    CGFloat itemWidth = (collectionViewWidth - self.sectionInset.left - self.sectionInset.right - (self.columnCount - 1) * self.columnSpacing) / self.columnCount;
    
    CGFloat itemHeight = 0;
    //获取item的高度，由外界计算得到
    if (self.itemHeightBlock) itemHeight = self.itemHeightBlock(itemWidth, indexPath);
    else {
        if ([self.delegate respondsToSelector:@selector(waterfallLayout:itemHeightForWidth:atIndexPath:)])
            itemHeight = [self.delegate waterfallLayout:self itemHeightForWidth:itemWidth atIndexPath:indexPath];
    }
    
    //找出最短的那一列
    __block NSNumber *minIndex = @0;
    [self.maxYDic enumerateKeysAndObjectsUsingBlock:^(NSNumber *key, NSNumber *obj, BOOL *stop) {
        if ([self.maxYDic[minIndex] floatValue] > obj.floatValue) {
            minIndex = key;
        }
    }];
    
    //根据最短列的列数计算item的x值
    CGFloat itemX = self.sectionInset.left + (self.columnSpacing + itemWidth) * minIndex.integerValue;
    
    //item的y值 = 最短列的最大y值 + 行间距
    CGFloat itemY = [self.maxYDic[minIndex] floatValue] + self.rowSpacing;
    
    //设置attributes的frame
    attributes.frame = CGRectMake(itemX, itemY, itemWidth, itemHeight);
    
    //更新字典中的最大y值
    self.maxYDic[minIndex] = @(CGRectGetMaxY(attributes.frame));
    
    return attributes;
}

//返回rect范围内item的attributes
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    return self.attributesArray;
}

@end
