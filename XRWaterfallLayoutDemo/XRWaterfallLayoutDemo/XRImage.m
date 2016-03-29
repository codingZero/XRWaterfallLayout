//
//  XRImage.m
//  XRWaterfallLayoutDemo
//
//  Created by ibos on 16/3/29.
//  Copyright © 2016年 XR. All rights reserved.
//

#import "XRImage.h"

@implementation XRImage
+ (instancetype)imageWithImageDic:(NSDictionary *)imageDic {
    XRImage *image = [[XRImage alloc] init];
    image.imageURL = [NSURL URLWithString:imageDic[@"img"]];
    image.imageW = [imageDic[@"w"] floatValue];
    image.imageH = [imageDic[@"h"] floatValue];
    return image;
}
@end
