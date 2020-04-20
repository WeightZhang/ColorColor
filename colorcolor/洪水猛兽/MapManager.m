//
//  MapManager.m
//  ColorColor
//
//  Created by zhangweikai on 2020/4/19.
//  Copyright © 2020 张伟凯. All rights reserved.
//

#import "MapManager.h"
#import "ColorButton.h"
#import "ImageTools.h"
/*
 http://www.lizibuluo.com/8bit/#import-save
 */


@interface MapManager(){
    struct t_array array ;
}
@property(nonatomic,strong)NSArray *currentColor;

@end
@implementation MapManager
+ (UIView*)createMapView:(NSArray*)colors{
    MapManager* map = [[MapManager alloc]initWithFrame:CGRectMake(0, 0, 400, 400)];
    map.currentColor = colors;
    [map drawBlockInMap];
//    map.backgroundColor = [UIColor redColor];
    return map;
}




- (void)drawBlockInMap{
    int colCount = 19;
    int rowCount = 19;
    
        CGFloat  marginY =2 ;
        CGFloat  marginX =2 ;
    
    CGFloat  mapHeight ;
    
    CGFloat  mapW = self.bounds.size.width;
    
        //-----------------总宽度---空隙数量  *  空隙宽度-----/有几个方块
        CGFloat  btnW = (mapW-(colCount+1)*marginX)/colCount;
    //        CGFloat  btnW = (self.map.bounds.size.width-(self.colCount+1)*marginX)/self.rowCount;
        CGFloat  btnH =  btnW;
        //计算map的高度
        mapHeight = (btnH+marginY) * rowCount+marginX;
    //    NSLog(@"self.mapHeight= %f",self.mapHeight);

        
        int totle = colCount * rowCount;
        for(int i=0;i < totle;i++){
           
            int row = i /colCount;
            int col = i % colCount;
    //         NSLog(@"i = %d  row=%d,col=%d",i,row,col);
            ColorButton *btn = [[ColorButton alloc]init];
            btn.layer.cornerRadius = 2;
            btn.row = row;
            btn.col = col;
            CGFloat  btnX = marginX +col *(btnW+marginX) ;
            CGFloat  btnY = marginY + row *(btnH+marginY);
            btn.bounds= CGRectMake(0, 0, btnW, btnH);
            btn.frame = CGRectMake(btnX, btnY,btnW, btnH);
            
            
            btn.colorNum = [self selectBtnColor:row and:col];
            btn.backgroundColor = [self getColor:btn.colorNum];
            [self addSubview:btn];
        }
}

// 绘制像素画模版
- (int)selectBtnColor:(int)row and:(int)col{
    int lastNum = 5;
    int val = array.imgMap[row][col];
    if (val ==1) {
        return lastNum;
    }
    return arc4random()%5;
}
- (UIColor* )getColor:(int)colorNum{

    if (colorNum ==-1) {
         return [UIColor clearColor];
    }
    NSArray *currentColor = self.currentColor;
    return  currentColor[colorNum];
}

@end
