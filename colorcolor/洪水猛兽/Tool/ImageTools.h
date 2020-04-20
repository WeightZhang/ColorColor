//
//  ImageTools.h
//  ColorColor
//
//  Created by zhangweikai on 2020/4/19.
//  Copyright © 2020 张伟凯. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

struct t_array {
    int imgMap[19][19];
};

@interface ImageTools : NSObject
+ (void)getBitImgColorsArrayWith:(int)row and:(int)col;

struct t_array getBitImgColorsArrayWith(int row,int col);

@end

NS_ASSUME_NONNULL_END
