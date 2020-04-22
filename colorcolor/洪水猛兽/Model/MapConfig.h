//
//  MapConfig.h
//  ColorColor
//
//  Created by zhangweikai on 2020/4/22.
//  Copyright © 2020 张伟凯. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MapConfig : NSObject

@property(nonatomic,assign)int row;
@property(nonatomic,assign)int col;
@property(nonatomic,assign)CGSize size;

@property(nonatomic,strong)NSArray* colors;
@property(nonatomic,copy)NSString* piexImgName; //像素画模版图片名字


@end

NS_ASSUME_NONNULL_END
