//
//  ViewController.m
//
//  Created by 肖睿 on 16/3/29.
//  Copyright © 2016年 XR. All rights reserved.
//

#import "ViewController.h"
#import "XRCollectionViewCell.h"
#import "XRWaterfallLayout.h"
#import "XRImage.h"
@interface ViewController ()<UICollectionViewDataSource, XRWaterfallLayoutDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray<XRImage *> *images;
@end

@implementation ViewController

- (NSMutableArray *)images {
    //从plist文件中取出字典数组，并封装成对象模型，存入模型数组中
    if (!_images) {
        _images = [NSMutableArray array];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"1.plist" ofType:nil];
        NSArray *imageDics = [NSArray arrayWithContentsOfFile:path];
        for (NSDictionary *imageDic in imageDics) {
            XRImage *image = [XRImage imageWithImageDic:imageDic];
            [_images addObject:image];
        }
    }
    return _images;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //创建瀑布流布局
    XRWaterfallLayout *waterfall = [XRWaterfallLayout waterFallLayoutWithColumnCount:3];
    
    //设置各属性的值
//    waterfall.rowSpacing = 10;
//    waterfall.columnSpacing = 10;
//    waterfall.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    //或者一次性设置
    [waterfall setColumnSpacing:10 rowSpacing:10 sectionInset:UIEdgeInsetsMake(10, 10, 10, 10)];
    
    
    //设置代理，实现代理方法
    waterfall.delegate = self;
    /*
     //或者设置block
     [waterfall setItemHeightBlock:^CGFloat(CGFloat itemWidth, NSIndexPath *indexPath) {
        //根据图片的原始尺寸，及显示宽度，等比例缩放来计算显示高度
        XRImage *image = self.images[indexPath.item];
        return image.imageH / image.imageW * itemWidth;
    }];
     */
    //创建collectionView
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:waterfall];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerNib:[UINib nibWithNibName:@"XRCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    self.collectionView.dataSource = self;
    [self.view addSubview:self.collectionView];
}

- (void)click {
    [self.images removeAllObjects];
    [self.collectionView reloadData];
}


//根据item的宽度与indexPath计算每一个item的高度
- (CGFloat)waterfallLayout:(XRWaterfallLayout *)waterfallLayout itemHeightForWidth:(CGFloat)itemWidth atIndexPath:(NSIndexPath *)indexPath {
    //根据图片的原始尺寸，及显示宽度，等比例缩放来计算显示高度
    XRImage *image = self.images[indexPath.item];
    return image.imageH / image.imageW * itemWidth;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.images.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    XRCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.imageURL = self.images[indexPath.item].imageURL;
    return cell;
}

@end
