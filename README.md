# XRWaterfallLayout
a simple waterfall flow layout

一个简单的瀑布流布局
______


#使用步骤
###导入
将XRWaterfallLayout文件夹中的所有文件添加到项目中

或

使用cocoapods导入，pod 'XRWaterfallLayout'

###使用
1.导入主头文件 XRWaterfallLayout.h

2.创建XRWaterfallLayout对象，根据需求设置各属性

3.设置代理并实现代理方法或设置itemHeightBlock属性

4.创建collectionView并设置其collectionViewLayout属性为该对象



#常用属性及方法

1.columnCount：总共有多少列

2.columnSpacing：列间距

3.rowSpacing：行间距

4.sectionInset：section与collectionView的间距

5.setColumnSpacing:rowSpacing:sectionInset:：同时设置列间距、行间距、sectionInset

6.CGFloat(^itemHeightBlock)(CGFloat, NSIndexPath *)：用来计算每个item高度的block


#效果图
![](http://upload-images.jianshu.io/upload_images/1429074-7fbb70e2ca3ba419.gif?imageMogr2/auto-orient/strip)

    