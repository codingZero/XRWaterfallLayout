//
//  XRCollectionViewCell.m
//
//  Created by 肖睿 on 16/3/29.
//  Copyright © 2016年 XR. All rights reserved.
//

#import "XRCollectionViewCell.h"
#import <UIImageView+WebCache.h>
@interface XRCollectionViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation XRCollectionViewCell
- (void)setImageURL:(NSURL *)imageURL {
    _imageURL = imageURL;
    [self.imageView sd_setImageWithURL:imageURL placeholderImage:[UIImage imageNamed:@"placeholder"]];
}
@end
