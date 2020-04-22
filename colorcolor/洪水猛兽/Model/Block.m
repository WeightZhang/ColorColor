//
//  Block.m
//  ColorColor
//
//  Created by zhangweikai on 2020/4/22.
//  Copyright © 2020 张伟凯. All rights reserved.
//

#import "Block.h"

@implementation Block
+ (Block*)initBlockWith:(int)colorNum row:(int)row col:(int)col{
    Block *b = [Block new];
    b.colorNum = colorNum;
    b.row = row;
    b.col = row;
    
    return b;
}
@end
