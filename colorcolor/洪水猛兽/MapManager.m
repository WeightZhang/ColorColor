//
//  MapManager.m
//  ColorColor
//
//  Created by zhangweikai on 2020/4/19.
//  Copyright © 2020 张伟凯. All rights reserved.
//

#import "MapManager.h"
#import "ColorButton.h"
#import "Block.h"


/*
 http://www.lizibuluo.com/8bit/#import-save
 */


@interface MapManager(){
//    struct t_array  mapArray ;
}
@property(nonatomic,strong)UIView* mapView;
@property(nonatomic,strong)NSMutableArray* blocks; //地图格子数组



@end
@implementation MapManager

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static MapManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [super allocWithZone:zone];
    });
    
    return instance;
}

+ (instancetype)sharedMapMng
{
    return [[self alloc] init];
}


+ (UIView*)createMapViewWith:(MapConfig*)config{
    // 准备绘制地图的参数
    NSArray* colors = config.colors;
    CGSize mapSize = config.size;
    NSString* piexImgName = config.piexImgName;
    
    // 获取像素画模版数组
//    NSArray* originMapArray = [ImageTools getBitImgColorsArray:piexImgName]; //TODO
    NSArray* originMapArray = [ImageTools getBitImgColorsArray];
    // 设置
    
    MapManager* mm = [MapManager sharedMapMng];
    mm.blocks = [NSMutableArray arrayWithArray:[mm setBlocksFrom:originMapArray]];
    
    UIView* map = [[UIView alloc]initWithFrame:CGRectMake(0, 0, mapSize.width, mapSize.height)];
    map.backgroundColor = [UIColor whiteColor];
    [mm drawBlockInMap:map with:colors];
    mm.mapView = map;
    return map;
}
- (NSArray*)setBlocksFrom:(NSArray*)originMapArray{
    
    NSMutableArray* blocks = [NSMutableArray array];
    for (int i = 0; i<originMapArray.count; i++) {
        // 像素画中着色位置标示：0 空，1 着色
        NSNumber* oMapFlag = originMapArray[i];
        int blockColorNum = [self selectBtnColorWithFlag:oMapFlag.intValue];
        
        [blocks addObject:[Block initBlockWith:blockColorNum row:0 col:0]];
    }
    
    return blocks;
}


- (void)drawBlockInMap:(UIView*)map with:(NSArray*)colors{
    int colCount = 19;
    int rowCount = 19;
    
    CGFloat  marginY =2 ;
    CGFloat  marginX =2 ;
    
    CGFloat  mapHeight ;
    
    CGFloat  mapW = map.bounds.size.width;
    
    //-----------------总宽度---空隙数量  *  空隙宽度-----/有几个方块
    CGFloat  btnW = (mapW-(colCount+1)*marginX)/colCount;
    //        CGFloat  btnW = (self.map.bounds.size.width-(self.colCount+1)*marginX)/self.rowCount;
    CGFloat  btnH =  btnW;
    //计算map的高度
    mapHeight = (btnH+marginY) * rowCount+marginX;
    //    NSLog(@"self.mapHeight= %f",self.mapHeight);
    
    
    int totle = colCount * rowCount;
    for(int i=0;i < totle;i++){
        Block* block = self.blocks[i];
        
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
        
        
        btn.colorNum = block.colorNum;
        btn.backgroundColor = [MapManager getColor:block.colorNum from:colors];
        [map addSubview:btn];
    }
}

// 绘制像素画模版
- (int)selectBtnColorWithFlag:(int)flag{
    int lastNum = 5;
    int val = flag;
    if (val ==1) {
        return lastNum;
    }
    return arc4random()%5;
}
+ (UIColor* )getColor:(int)colorNum from:(NSArray *)colors{
    
    if (colorNum ==-1) {
        return [UIColor clearColor];
    }
    NSArray *currentColor = colors;
    return  currentColor[colorNum];
}

@end
