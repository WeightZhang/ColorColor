//
//  ColorTool.m
//  洪水猛兽
//
//  Created by 张伟凯 on 14-6-13.
//  Copyright (c) 2014年 张伟凯. All rights reserved.
//

#import "ColorTool.h"

@implementation ColorTool
+ (UIColor*)RGBRandomColor{
    return [self RGBColorBG][arc4random()%12];
}
+ (NSArray*)RGBColorBG{
    NSMutableArray *colorArray = [NSMutableArray array];
    [colorArray addObject:RGBColor(109,188,158)];
    [colorArray addObject:RGBColor(121,204,118)];
    [colorArray addObject:RGBColor(96,151,218)];
    [colorArray addObject:RGBColor(220,189,189)];
    [colorArray addObject:RGBColor(71,88,158)];
    [colorArray addObject:RGBColor(77,46,82)];
    [colorArray addObject:RGBColor(167,104,131)];
    [colorArray addObject:RGBColor(82,69,89)];
    [colorArray addObject:RGBColor(108,115,118)];
    [colorArray addObject:RGBColor(170,172,47)];
    [colorArray addObject:RGBColor(62,74,93)];
    [colorArray addObject:RGBColor(140,91,181)];
    
    return colorArray;
}
+ (NSArray*)RGBColor3{
    NSMutableArray *colorArray = [NSMutableArray array];
        [colorArray addObject:RGBColor(97,72,134)];
        [colorArray addObject:RGBColor(46,10,0)];
        [colorArray addObject:RGBColor(114,168,127)];
        [colorArray addObject:RGBColor(213,133,141)];
        [colorArray addObject:RGBColor(238,198,58)];
        [colorArray addObject:RGBColor(165,25,45)];

    return colorArray;
}
+ (NSArray*)RGBColor1{
    NSMutableArray *colorArray = [NSMutableArray array];
    [colorArray addObject:RGBColor(127,205,120)];
    [colorArray addObject:RGBColor(107,164,204)];
    [colorArray addObject:RGBColor(131,150,148)];
    [colorArray addObject:RGBColor(213,188,141)];
    [colorArray addObject:RGBColor(233,182,199)];
    [colorArray addObject:RGBColor(222,132,108)];
    return colorArray;
}
+ (NSArray*)RGBColor{
    NSMutableArray *colorArray = [NSMutableArray array];
    [colorArray addObject:RGBColor(177,32,58)];
    [colorArray addObject:RGBColor(49,0,0)];
    [colorArray addObject:RGBColor(110,124,46)];
    [colorArray addObject:RGBColor(103,168,117)];
    [colorArray addObject:RGBColor(211,90,128)];
    [colorArray addObject:RGBColor(237,192,45)];
    return colorArray;
}
+ (NSArray*)RGBColor2{
    NSMutableArray *colorArray = [NSMutableArray array];
    [colorArray addObject:RGBColor(208,76,145)];
    [colorArray addObject:RGBColor(93,100,170)];
    [colorArray addObject:RGBColor(246,222,167)];
    [colorArray addObject:RGBColor(240,197,51)];
    [colorArray addObject:RGBColor(131,131,86)];
    [colorArray addObject:RGBColor(80,80,80)];
    
    return colorArray;
}
@end
