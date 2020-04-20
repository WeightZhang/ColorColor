//
//  ImageTools.m
//  ColorColor
//
//  Created by zhangweikai on 2020/4/19.
//  Copyright © 2020 张伟凯. All rights reserved.
//

#import "ImageTools.h"

@implementation ImageTools
/// 获取像素画图片颜色
/// @param point 像素或坐标点
+ (void)getColorIn:(CGPoint)point{
    
}

/// 获取单色像素画着色位置数组
/// @param count 图片平均分割数
//+ (int *)getBitImgColorsArrayWith:(int)row and:(int)col{
//    int imgMap[row][col];
//    int **imgMapP = NULL;
//    for(int i = 0;i < row;i++){
//        for(int j = 0;j < col;j++){
//            imgMap[i][j] = [self getMapNum:i and:j];
//             NSLog(@"imgMap=%d | i=%d,j=%d",imgMap[i][j],i,j);
//        }
//    }
//    int *p = NULL;
//    return p;
//}


struct t_array getBitImgColorsArrayWith(int row,int col) {
    struct t_array array;
    for(int i = 0;i < row;i++){
        for(int j = 0;j < col;j++){
            array.imgMap[i][j] = [ImageTools getMapNum:i and:j];
//             NSLog(@"imgMap=%d | i=%d,j=%d",array.imgMap[i][j],i,j);
        }
    }
    
return array;
}
//    struct t_thing thing = retArr();


// int* getBitImgColorsArrayWith(int row,int col){
//     Array array;
//    int imgMap[row][col];
//    int *imgMapP = NULL;
//    for(int i = 0;i < row;i++){
//        for(int j = 0;j < col;j++){
//            imgMap[i][j] = [ImageTools getMapNum:i and:j];
//             NSLog(@"imgMap=%d | i=%d,j=%d",imgMap[i][j],i,j);
//        }
//    }
////     imgMapP = &imgMap;
//    return &imgMap;
//}

+ (int)getMapNum:(int)row and:(int)col{
    UIImage* piexImg = [UIImage imageNamed:@"piex"];
    NSUInteger count = 19;
    float WH = piexImg.size.width;
    int miniWH = WH/count;
 
    float selectX = miniWH/2.0 + col * miniWH;
    float selectY = miniWH/2.0 + row * miniWH;
    UIColor* blockColor = [self colorAtPixel:CGPointMake(selectX, selectY) in:piexImg];
    NSLog(@"blockColor=%@ | row=%d,col=%d",blockColor,row,col);

    CGColorRef cgColor = blockColor.CGColor;
    
    CIColor *ciColor = [CIColor colorWithCGColor:cgColor];
    CGFloat alpha = ciColor.alpha;
    CGFloat red = ciColor.red;
    
    NSLog(@"ciColor.alpha: %f", ciColor.alpha);
//    CGFloat alpha =blockColor.CGColor;
//    0.129412 / 0.521569 /
    if (alpha == 1 && red == 0 ) {
        return 1;
    }else{
        return 0;
    }

    
    
    
    return 0;
}
//获取图片某一点的颜色
+ (UIColor *)colorAtPixel:(CGPoint)point in:(UIImage*)image {
     if (!CGRectContainsPoint(CGRectMake(0.0f, 0.0f, image.size.width, image.size.height), point)) {
         return nil;
     }
     
     NSInteger pointX = trunc(point.x);
     NSInteger pointY = trunc(point.y);
     CGImageRef cgImage = image.CGImage;
     NSUInteger width = image.size.width;
     NSUInteger height = image.size.height;
     CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
     int bytesPerPixel = 4;
     int bytesPerRow = bytesPerPixel * 1;
     NSUInteger bitsPerComponent = 8;
     unsigned char pixelData[4] = { 0, 0, 0, 0 };
     CGContextRef context = CGBitmapContextCreate(pixelData,
                                                  1,
                                                  1,
                                                  bitsPerComponent,
                                                  bytesPerRow,
                                                  colorSpace,
                                                  kCGImageAlphaPremultipliedLast |     kCGBitmapByteOrder32Big);
     CGColorSpaceRelease(colorSpace);
     CGContextSetBlendMode(context, kCGBlendModeCopy);
     
     CGContextTranslateCTM(context, -pointX, pointY-(CGFloat)height);
     CGContextDrawImage(context, CGRectMake(0.0f, 0.0f, (CGFloat)width, (CGFloat)height), cgImage);
     CGContextRelease(context);
     
     CGFloat red   = (CGFloat)pixelData[0] / 255.0f;
     CGFloat green = (CGFloat)pixelData[1] / 255.0f;
     CGFloat blue  = (CGFloat)pixelData[2] / 255.0f;
     CGFloat alpha = (CGFloat)pixelData[3] / 255.0f;

     return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
 }

@end
