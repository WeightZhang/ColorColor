//
//  ImageTools.h
//  ColorColor
//
//  Created by zhangweikai on 2020/4/19.
//  Copyright © 2020 张伟凯. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef struct t_array {
    int row;
    int col;
    int imgMap[19][19];
} MapArray;

@interface ImageTools : NSObject

+ (NSArray*)getBitImgColorsArray;

/// 根据像素画绘制像素画二维数组
MapArray getBitImgColorsArrayWith();

@end

NS_ASSUME_NONNULL_END
