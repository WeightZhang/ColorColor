//
//  Block.h
//  ColorColor
//
//  Created by zhangweikai on 2020/4/22.
//  Copyright © 2020 张伟凯. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Block : NSObject
@property(nonatomic,assign)int colorNum; // 颜色编号
@property(nonatomic,assign)int row;
@property(nonatomic,assign)int col;

@property(nonatomic,assign)int inTempSaveArray;
@property(nonatomic,assign)int inZZ;


+ (Block*)initBlockWith:(int)colorNum row:(int)row col:(int)col;

@end

NS_ASSUME_NONNULL_END
