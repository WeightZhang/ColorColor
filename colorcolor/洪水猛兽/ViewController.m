//
//  ViewController.m
//  洪水猛兽
//
//  Created by 张伟凯 on 14-6-8.
//  Copyright (c) 2014年 张伟凯. All rights reserved.
//
#import "AudioTool.h"
#import "ColorTool.h"
#import "ViewController.h"
#import "ColorButton.h"
#import "ChangeColorButton.h"

#import "HelpView.h"
#import "ImageTools.h"
#import "MapManager.h"

#define kColorCount  6

typedef enum {kWhoTurns_1P,kWhoTurns_2P}WhoTurns;



@interface ViewController ()<OverViewDelegate>{
    struct t_array array ;
}

@property (nonatomic,assign,getter = isWin) BOOL win;

- (IBAction)clickBtn:(id)sender;

//--------单人相关------//
@property (weak, nonatomic) IBOutlet UILabel *gameModeSoloTitle;

//-------双人相关--------
@property (weak, nonatomic) IBOutlet UILabel *gameModelTowTitleBottom;
@property (weak, nonatomic) IBOutlet UILabel *gameModelTowTItleTop;

//要初始化的
@property (nonatomic,assign)int gameMode;
@property (nonatomic,assign)int mapSize;
@property (nonatomic,assign) int colorCount;//颜色数

@property (nonatomic,assign)WhoTurns whoTurns;//谁可以操作

@property (weak, nonatomic) IBOutlet UIButton *toOver;


@property(nonatomic,weak)IBOutlet UIView *map;
@property(nonatomic,assign)CGFloat mapHeight;
@property(nonatomic,strong)NSMutableArray *allButton;
//1P玩家
@property(nonatomic,strong)NSMutableArray *zuzhi;//在组织中 0不再组织  1在组织  2 在党国
//2P玩家
@property(nonatomic,strong)NSMutableArray *dangguo;//党国

@property (weak, nonatomic) IBOutlet UIView *bottomBtnView;
@property (weak, nonatomic) IBOutlet UIView *topBtnView;
@property  (nonatomic,strong) ChangeColorButton *saveTopBtn;
@property  (nonatomic,strong) ChangeColorButton *saveBottomBtn;


@property (nonatomic,assign) int soundOn;   //声音
@property (nonatomic,assign) int btnColor;   //按钮 颜色
@property (nonatomic,assign) int colCount;   //列数---一共有几列
@property (nonatomic,assign) int rowCount;  //行数----一共有几行
          



@property(nonatomic,weak) MapManager *mapView;
@end

@implementation ViewController
#pragma mark - 切换颜色相关

-( void)currentColor:(int)colorNum{
    switch (self.btnColor) {
        case 0: self.currentColor = [ColorTool RGBColor];  break;
        case 1: self.currentColor = [ColorTool RGBColor1];  break;
        case 2: self.currentColor = [ColorTool RGBColor2];  break;
        case 3: self.currentColor = [ColorTool RGBColor3];  break;
            
        default:
            break;
    }
//    return self.currentColor ;
}

//----------------------
- (void)viewDidLayoutSubviews{
//    NSLog(@"viewDidLayoutSubviews");
        self.map.bounds = CGRectMake(0, 0, self.view.bounds.size.width - 10*2, self.mapHeight);
}

- (void)viewDidLoad
{
//    NSLog(@"viewDidLoad");
         self.view.backgroundColor = [ColorTool RGBColorBG][arc4random()%12];
    [super viewDidLoad];
    [self setupValue];
    
    [self setupCountNum];
    
    [self setupBtnView:self.gameMode];
//    [self drawMap];
    MapManager* mapView = [MapManager createMapView:self.currentColor];
    [self.view addSubview:mapView];
    
//    UIButton *btn = [self.map.subviews lastObject];
//    NSLog(@"btn.frame = %@",btn);
    
    
}
- (void)setupValue{
    //加载存储数据
    DataTool *data = [DataTool sharedDataTool];
    [data loadData];
    self.soundOn = data.soundOn;
    self.colorCount = kColorCount;
    
    self.gameMode = data.gameMode;
    self.mapSize = 0;//
    self.btnColor = data.btnColor;
    [self currentColor:self.btnColor];
    //初始化几行几列

    [self setRowColNum:data.mapRow:data.mapCol];
    
    //初始化图片模版
    array = getBitImgColorsArrayWith(data.mapRow,data.mapCol);
    
    [self setupTipView:data.playTimes];
     data.playTimes++;
    [data updataSaveDataWithPlayTimes];
    
//    NSLog(@"Playtimes= %d",data.playTimes);
    self.zuzhi = [NSMutableArray array];
    self.dangguo = [NSMutableArray array];
    self.allButton = [NSMutableArray array];
}
/**
 *  初始化tipview
 *
 *  @param times 第几次运行游戏
 */
- (void)setupTipView:(int)times{
    if (times <= 3) {
        HelpView *helpView =  [[[NSBundle mainBundle] loadNibNamed:@"HelpView" owner:nil options:nil] lastObject];
        helpView.backgroundColor = [ColorTool RGBColorBG][arc4random()%12];
        [self.view addSubview:helpView];
    }
}
- (void)setRowColNum:(int)row :(int)col{
    if (fourInch) {
         self.rowCount = row;
         self.colCount = col;
//        NSLog(@"setRowColNum");

    }else{
        self.colCount = col;
        self.rowCount = self.colCount;
    }
}

#pragma mark - 计数相关
#pragma mark  ----- 单人模式相关
- (void)updataSoloCountTitle{
     self.gameModeSoloTitle.text = [NSString stringWithFormat:@"%d / %d",self.zuzhi.count , self.colCount *self.rowCount];
}
#pragma  mark   双人模式相关
- (void)updataTwoCountTitle{
    self.gameModelTowTitleBottom.text = [NSString stringWithFormat:@"%d / %d",self.zuzhi.count , self.dangguo.count];
    self.gameModelTowTItleTop.text = [NSString stringWithFormat:@"%d / %d", self.dangguo.count,self.zuzhi.count ];
}
#pragma mark---计数相关
/**
 *  计数初始化,设置是否显示或是隐藏
 */
- (void)setupCountNum{
    if (self.gameMode == kGameModeSolo) {
        self.gameModeSoloTitle.alpha = 1;
        self.gameModeSoloTitle.text = [NSString stringWithFormat:@"1/%d",self.colCount *self.rowCount];
    }else{
        self.gameModelTowTitleBottom.alpha = 1 ;
        self.gameModelTowTitleBottom.text = [NSString stringWithFormat:@"%d / %d",0,0];
        
        self.gameModelTowTItleTop.alpha = 1 ;
        self.gameModelTowTItleTop.text = [NSString stringWithFormat:@"%d / %d",0,0];
        //        self.gameModelTowTItleTop.transform
        self.gameModelTowTItleTop.transform =CGAffineTransformMakeRotation(M_PI);
    }
}


#pragma mark -  对战相关
/**
 *  cpu执行ai
 *  @param aiClass cpu等级   0低级   1高级
 */
- (void)cpuAI:(int)aiClass{
    //延迟执行
    double delayInSeconds = 1.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        //初级ai执行
        if (aiClass == 0) {
            ChangeColorButton *aiClickBtn = [self randomClickTopButton];
            [self clickTopColorBtn:aiClickBtn];
        }
        //高级ai执行
        else{
            //            ChangeColorButton *aiClickBtn = [self maxColorCountClickTopButton];
            ChangeColorButton *aiClickBtn = [self getMaxSumBtn];
//            NSLog(@"cpuAI:(int)aiClass 高级ai要点击的按钮的颜色 = %@",[self getColorName:aiClickBtn.color]);
            [self clickTopColorBtn:aiClickBtn];
        }
    });
}
// 更改该谁游戏,并设置对方不能交互
- (void)changeTurns{
   
    if (self.gameMode != kGameModeSolo) {
        self.topBtnView.alpha = 1;
        self.topBtnView.userInteractionEnabled = YES;
        self.bottomBtnView.alpha = 1;
        self.bottomBtnView.userInteractionEnabled = YES;
        
        if (self.whoTurns == kWhoTurns_1P) {
            self.topBtnView.alpha = 0.2;
            self.topBtnView.userInteractionEnabled = NO;
            self.whoTurns = kWhoTurns_2P;
        }else if(self.whoTurns == kWhoTurns_2P){
            self.bottomBtnView.alpha = 0.2;
            self.bottomBtnView.userInteractionEnabled = NO;
            self.whoTurns = kWhoTurns_1P;
            if(self.gameMode == kGameModeCliverCPU || self.gameMode == kGameModeWithFastCPU){
                self.topBtnView.userInteractionEnabled = NO;
            }
        }
    }else{
        self.bottomBtnView.alpha = 1;
    }
}
#pragma  ------ai相关-------
//根据游戏类型获取cpu等级
- (int)cupClass:(int)gameMode{
    return gameMode == kGameModeWithFastCPU ? 0 : 1;
}
// 初级ai随机点击按钮
- (ChangeColorButton *)randomClickTopButton{
//    NSLog(@"self.dangguo.count=%d",self.dangguo.count);
    while (1) {
        int btnColor = arc4random() % kColorCount;
         ChangeColorButton *aiClickBtn = self.topBtnView.subviews[btnColor];
        int dangguoColor =( (ColorButton*)[self.dangguo lastObject]).colorNum;
        int zzColor =( (ColorButton*)[self.zuzhi lastObject]).colorNum;
        if (aiClickBtn.color != zzColor && aiClickBtn.color != dangguoColor) {
            return aiClickBtn;
        }
    }
}
#pragma --高级ai相关--
- (ChangeColorButton *)getMaxSumBtn{
    NSMutableArray *saveCount = [NSMutableArray array];
    int dangguoCount = self.dangguo.count;
    ColorButton *zzBtn = [self.zuzhi lastObject];
    ColorButton *dgBtn = [self.dangguo lastObject];
    for (int i= 0; i < 6; i++) {
        if (zzBtn.colorNum != i && dgBtn.colorNum !=i ) {
            [self getCountWithColor:i];
            int dangguoCountAtfer = self.dangguo.count;
            [saveCount addObject:@(dangguoCountAtfer)];
//            NSLog(@"颜色_%@_dangguocount = %d",[self getColorName:i],dangguoCountAtfer);
            for (int i = 0 ; i < dangguoCountAtfer; i++) {
                if (i > dangguoCount-1) {
                    ColorButton *btn = self.dangguo[i];
                    btn.inZZ = 0;
                }
            }
            for (int i = 0; i < dangguoCountAtfer-dangguoCount; i++) {
                [self.dangguo removeLastObject];
            }
        }else{
            [saveCount addObject:@(0)];
        }
    }
    
    NSArray *sort =[saveCount sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2];
    }];
//    NSLog(@"saveCount=%@",saveCount);
//    NSLog(@"sort=%@",sort);
    int maxIndex = [saveCount indexOfObject:[sort lastObject]];
//    NSLog(@"maxIndex=%d",maxIndex);
    ChangeColorButton *btn = [self.bottomBtnView subviews][maxIndex];
    return btn;
}
-(void)getCountWithColor:(int)colorNum{
    //遍历zuzhi内的btn,判断其周围的是够可以加入
    NSMutableArray *temp = [NSMutableArray array];
    
    for (ColorButton *btn in self.dangguo) {
        if ((btn.row-1) >= 0) {
            ColorButton *upBtn = self.allButton[btn.row *self.colCount + btn.col - self.colCount];
            if (upBtn.inZZ == 0  && upBtn.colorNum == colorNum) {
                upBtn.inZZ = 2;
                upBtn.colorNum = colorNum;
                [temp addObject:upBtn];
            }
        }
        if ((btn.row+1) <= (self.rowCount-1)) {
            ColorButton *downBtn = self.allButton[btn.row *self.colCount + btn.col + self.colCount];
            if (downBtn.inZZ == 0  && downBtn.colorNum == colorNum) {
                downBtn.inZZ = 2;
                downBtn.colorNum = colorNum;
                [temp addObject:downBtn];
            }
        }
        if ((btn.col-1) >= 0) {
            ColorButton *leftBtn = self.allButton[btn.row *self.colCount + btn.col -1];
            if (leftBtn.inZZ == 0  && leftBtn.colorNum == colorNum) {
                leftBtn.inZZ = 2;
                leftBtn.colorNum = colorNum;
                [temp addObject:leftBtn];
                
            }
        }
        if ((btn.col+1) <= (self.colCount-1)) {
            ColorButton *rightBtn = self.allButton[btn.row *self.colCount + btn.col +1];
            if (rightBtn.inZZ == 0  && rightBtn.colorNum == colorNum) {
                rightBtn.inZZ = 2;
                rightBtn.colorNum = colorNum;
                [temp addObject:rightBtn];
                
            }
        }
    }
    for (ColorButton *tempBtn in temp ) {
        [self.dangguo addObject:tempBtn];
    }
    if (temp.count == 0) {
        return;
    }else{
        [self getCountWithColor:colorNum];
    }
//    NSLog(@"递归递归递归");
    
}



#pragma mark----  map相关
// 绘制像素画模版
- (int)selectBtnColor:(int)row and:(int)col{
    int lastNum = 5;
    int val = array.imgMap[row][col];
    if (val ==1) {
        return lastNum;
    }
    return arc4random()%5;
}
- (void)drawMap{
   
    
    CGFloat  marginY =2 ;
    CGFloat  marginX =2 ;
    //-----------------总宽度---空隙数量  *  空隙宽度-----/有几个方块
    CGFloat  btnW = (300-(self.colCount+1)*marginX)/self.colCount;
//        CGFloat  btnW = (self.map.bounds.size.width-(self.colCount+1)*marginX)/self.rowCount;
    CGFloat  btnH =  btnW;
    //计算map的高度
    self.mapHeight = (btnH+marginY) *self.rowCount+marginX;
//    NSLog(@"self.mapHeight= %f",self.mapHeight);

    
    int totle = self.colCount * self.rowCount;
    for(int i=0;i < totle;i++){
       
        int row = i /self.colCount;
        int col = i % self.colCount;
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
        [self.map addSubview:btn];
        
/*--------------------------操作-----------------------------------*/
        //将第一个btn添加进zz
        if (i == 0) {
            btn.inZZ = 1;
            [self.zuzhi addObject:btn];
        }
        
        if (self.gameMode != kGameModeSolo) {
            //将最后一个btn添加进dg
            if (i == (totle-1)) {
                ColorButton *btnFirst = self.allButton[0];
                btn.colorNum = [self getDifferentColorNum:btnFirst.colorNum];
                btn.inZZ = 2;
                [self.dangguo addObject:btn];
            }
        }        
        
        [self.allButton addObject:btn];
//        NSLog(@"btn.row = %d ,btn.col = %d",btn.row,btn.col);
    }
    ColorButton *first = self.allButton[0];
    [self btnAddToZuzhiWithColor:first.colorNum];

    ColorButton *last = self.allButton[totle-1];
    [self btnAddToDangguoWithColor:last.colorNum];
    
    //模拟点击了颜色按钮,使一开始左上角颜色相同的按钮都在zz数组中
     ChangeColorButton *btn1P = [self.topBtnView subviews][ first.colorNum];
     [self clickTopColorBtn: btn1P];
    
    ChangeColorButton *btn2P = [self.topBtnView subviews][ first.colorNum];
    [self clickTopColorBtn: btn2P];
    
    [self changeTurns];
   

}


/*
 1.判断zz中btn的上下左右,把不在zz中的并且颜色合适的加入zztemp数组
 
 递归,知道数组为空,跳出递归
 */
- (void)btnAddToDangguoWithColor:(int)colorNum{
    //遍历dg内的btn,判断其周围的是够可以加入
    NSMutableArray *temp = [NSMutableArray array];
    
    for (ColorButton *btn in self.dangguo) {
//        NSLog(@"btn.row = %d   btn.col= %d",btn.row,btn.col);
        if ((btn.row-1) >= 0) {
            //--------------------------------计算当前按钮在一维数组中的下标  -  一行有及各方块 = 它上面那个方块的下标
            ColorButton *upBtn = self.allButton[btn.row *self.colCount + btn.col - self.colCount];
            if (upBtn.inZZ == 0  &&  upBtn.colorNum == colorNum) {
                upBtn.inZZ = 2;
                upBtn.colorNum = colorNum;
                [temp addObject:upBtn];
            }
        }
        if ((btn.row+1) <= (self.rowCount-1)) {
            ColorButton *downBtn = self.allButton[btn.row *self.colCount + btn.col + self.colCount];
            if (downBtn.inZZ == 0  && downBtn.colorNum == colorNum) {
                downBtn.inZZ = 2;
                downBtn.colorNum = colorNum;
                [temp addObject:downBtn];
            }
        }
        if ((btn.col-1) >= 0) {
            ColorButton *leftBtn = self.allButton[btn.row *self.colCount + btn.col -1];
            if (leftBtn.inZZ == 0  && leftBtn.colorNum == colorNum) {
                leftBtn.inZZ = 2;
                leftBtn.colorNum = colorNum;
                [temp addObject:leftBtn];
                
            }
        }
        if ((btn.col+1) <= (self.colCount-1)) {
            ColorButton *rightBtn = self.allButton[btn.row *self.colCount + btn.col +1];
            if (rightBtn.inZZ == 0  && rightBtn.colorNum == colorNum) {
                rightBtn.inZZ = 2;
                rightBtn.colorNum = colorNum;
                [temp addObject:rightBtn];
                
            }
        }
    }
    for (ColorButton *tempBtn in temp ) {
        [self.dangguo addObject:tempBtn];
    }
    if (temp.count == 0) {
#warning ----胜利条件
//        [self isVictory];
//        return;
    }else{
        [self btnAddToDangguoWithColor:colorNum];
    }
}
- (void)btnAddToZuzhiWithColor:(int)colorNum{
    //遍历zuzhi内的btn,判断其周围的是够可以加入
    NSMutableArray *temp = [NSMutableArray array];
    
    for (ColorButton *btn in self.zuzhi) {
//        NSLog(@"btn.row = %d   btn.col= %d",btn.row,btn.col);
        if ((btn.row-1) >= 0) {
            ColorButton *upBtn = self.allButton[btn.row *self.colCount + btn.col - self.colCount];
            if (upBtn.inZZ == 0  && upBtn.colorNum == colorNum) {
                upBtn.inZZ = 1;
                upBtn.colorNum = colorNum;
                [temp addObject:upBtn];
               
            }
        }
        if ((btn.row+1) <= (self.rowCount-1)) {
            ColorButton *downBtn = self.allButton[btn.row *self.colCount + btn.col + self.colCount];
            if (downBtn.inZZ == 0  && downBtn.colorNum == colorNum) {
                downBtn.inZZ = 1;
                downBtn.colorNum = colorNum;
                [temp addObject:downBtn];
                            }
        }
        if ((btn.col-1) >= 0) {
            ColorButton *leftBtn = self.allButton[btn.row *self.colCount + btn.col -1];
            if (leftBtn.inZZ == 0  && leftBtn.colorNum == colorNum) {
                leftBtn.inZZ = 1;
                leftBtn.colorNum = colorNum;
                [temp addObject:leftBtn];
               
            }
        }
        if ((btn.col+1) <= (self.colCount-1)) {
            ColorButton *rightBtn = self.allButton[btn.row *self.colCount + btn.col +1];
            if (rightBtn.inZZ == 0  && rightBtn.colorNum == colorNum) {
                rightBtn.inZZ = 1;
                rightBtn.colorNum = colorNum;
                [temp addObject:rightBtn];
              
            }
        }
    }
    for (ColorButton *tempBtn in temp ) {
        [self.zuzhi addObject:tempBtn];
    }
    if (temp.count == 0) {
#warning ----胜利条件
//        [self isVictory];
////          NSLog(@"递归完成");
//        return;
    }else{
        [self btnAddToZuzhiWithColor:colorNum];
    }
//    NSLog(@"递归递归递归");
}

-(void)changeDangguoColor:(int)colorNum{
    
    for (ColorButton *btn in self.dangguo) {
        btn.colorNum = colorNum;
//        NSLog(@"btn.x = %f",btn.center.x);
        btn.backgroundColor = [self getColor:colorNum];
    }
}
-(void)changeZuzhiColor:(int)colorNum{
    
    for (ColorButton *btn in self.zuzhi) {
        btn.colorNum = colorNum;
//        NSLog(@"btn.x = %f",btn.center.x);
        btn.backgroundColor = [self getColor:colorNum];
    }
}


// 判断是否胜利
- (void)isVictory{
    OverView *over  = [[[NSBundle mainBundle] loadNibNamed:@"OverView" owner:nil options:nil] lastObject];
    over.gameMode = self.gameMode;
    over.backgroundColor = [ColorTool RGBColorBG][arc4random()%12];
    over.delegate = self;
    //单人胜利判断
    if (self.gameMode == kGameModeSolo) {
        if ( self.zuzhi.count == self.colCount *self.rowCount) {
//             [MBProgressHUD showSuccess: @"游戏结束"];
             [self.view addSubview:over];
             over.titleLabel.text = @"Color Unified!";
           
            over.transform = CGAffineTransformMakeScale(0.1,0.1);
            [UIView animateWithDuration:0.5 animations:^{
                over.transform = CGAffineTransformIdentity;
            }];
        }
    }
    //双人胜利判断
    else{
        if ((self.zuzhi.count  + self.dangguo.count)== self.colCount *self.rowCount) {
            
            over.topnum = self.dangguo.count;
            over.bottomnum = self.zuzhi.count;
            over.transform = CGAffineTransformMakeScale(0,0);
            
            [self.view addSubview:over];
            [UIView animateWithDuration:0.5 animations:^{
                over.transform = CGAffineTransformIdentity;

            }];

            
            if (self.zuzhi.count > self.dangguo.count) {
            over.titleLabel.text = @"Color Unified!";
            }else if (self.zuzhi.count < self.dangguo.count){
                over.titleLabel.text = @"What a pity !";
            }else{
                 over.titleLabel.text = @"You can do better !";
            }
        }
    }
 
}
#pragma mark - 代理方法
#pragma ---- Over界面跳转会menu界面
- (void)overViewClickBackBtn{
//    self.presentedViewController.view.backgroundColor = self.view.backgroundColor;
//    self.parentViewController.view.backgroundColor = self.view.backgroundColor;
    [((UINavigationController*)self.parentViewController) popToRootViewControllerAnimated:YES];
}

#pragma mark - 上下按钮相关
//绘制 上下按钮
- (void)setupBtnView:(int)gameMode{
    if (gameMode == kGameModeSolo) {
        [self setupBottomBtnView];
        [self setupTopBtnView];
        //单人游戏设置透明度为0
        self.topBtnView.alpha = 0;
//        NSLog(@"setupBtnView");
    }else{
        [self setupBottomBtnView];
        [self setupTopBtnView];
    }
}
- (void)setupBottomBtnView{
    //    CGFloat  marginY =2 ;
    CGFloat  marginX =10 ;
    CGFloat  btnW = (self.bottomBtnView.bounds.size.width-(kColorCount+1)*marginX)/kColorCount;
    CGFloat  btnH =  btnW;
    for (int i = 0; i < kColorCount; i ++) {
        CGFloat btnX = marginX + (marginX+btnW)*i;
        ChangeColorButton *btn = [[ChangeColorButton alloc]init];
        btn.layer.cornerRadius = 5;
        btn.frame = CGRectMake(btnX, 0, btnW, btnH);
        btn.color = i;
        btn.backgroundColor = [self getColor:btn.color];
        
        [self.bottomBtnView addSubview:btn];
        [btn addTarget:self action:@selector(clickBottomColorBtn:) forControlEvents:UIControlEventTouchUpInside];
        [btn addTarget:self action:@selector(clickBottomColorBtnDown:) forControlEvents:UIControlEventTouchDown];
    }
}
- (void)clickBottomColorBtnDown:(ChangeColorButton*)btn{
        btn.transform = CGAffineTransformMakeScale(0.9, 0.9);
        btn.alpha = 0.5;
}
//底部按钮点击
- (void)clickBottomColorBtn:(ChangeColorButton*)bottomBtn{
    //播放声音
    if (self.soundOn) {
            [AudioTool playSound:@"bottomSound.m4a"];
    }

    bottomBtn.transform = CGAffineTransformIdentity;
    bottomBtn.alpha = 1.0;
    
    [self btnAddToZuzhiWithColor:bottomBtn.color];
    [self changeZuzhiColor:bottomBtn.color];

    if (self.gameMode != kGameModeSolo) {
        [self changeTurns];
    }
    
    if (self.saveBottomBtn != nil) {
        //还原设置enabled为NO的按钮状态和颜色
        self.saveBottomBtn.backgroundColor = [self getColor:self.saveBottomBtn.color];
        self.saveBottomBtn.enabled = YES;
    }
    ChangeColorButton *btn = self.topBtnView.subviews[self.colorCount-1-bottomBtn.color];
    self.saveBottomBtn = btn;
    btn.backgroundColor = [self getColor:-1];
    btn.enabled = NO;
   
    if (self.gameMode == kGameModeWithFastCPU) {
         //cpu执行ai
        [self cpuAI:[self cupClass: self.gameMode]];
        //更新计数label双人
        [self updataTwoCountTitle];
    }else if(self.gameMode == kGameModeCliverCPU){
         [self cpuAI:[self cupClass: self.gameMode]];
        //更新计数label双人
        [self updataTwoCountTitle];
    }
    else if (self.gameMode == kGameModeSolo){
        //单人模式更新顶部的数字显示
        [self updataSoloCountTitle];
    }else{  //人人对战
        [self updataTwoCountTitle];
    }
#warning -mark------
     if ( self.zuzhi.count == self.colCount *self.rowCount && self.isWin == NO ) {
         self.win = YES;
         [self isVictory];
         return;
     }else if ( (self.zuzhi.count+self.dangguo.count) == self.colCount *self.rowCount && self.isWin == NO){
           self.win = YES;
         [self isVictory];
         return;
     }
}

- (void)setupTopBtnView{
    //    CGFloat  marginY =2 ;
    CGFloat  marginX =10 ;
    CGFloat  btnW = (self.topBtnView.bounds.size.width-(kColorCount+1)*marginX)/kColorCount;
    CGFloat  btnH =  btnW;
    for (int i = 0; i < kColorCount; i ++) {
//        CGFloat btnX = marginX + (marginX+btnW)*i;
        CGFloat btnX = marginX + (marginX+btnW)*i;
        ChangeColorButton *btn = [[ChangeColorButton alloc]init];
        
        btn.frame = CGRectMake(btnX, 40 - btnW, btnW, btnH);
        btn.color = (kColorCount-1 - i);
        btn.backgroundColor = [self getColor:btn.color];
        btn.layer.cornerRadius = 5;
        
        [self.topBtnView addSubview:btn];
        [btn addTarget:self action:@selector(clickTopColorBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
}
//顶部按钮点击
- (void)clickTopColorBtn:(ChangeColorButton*)topBtn{
    //播放声音
    if (self.soundOn) {
        [AudioTool playSound:@"topSound.m4a"];
    }
    [self btnAddToDangguoWithColor:topBtn.color];
    [self changeDangguoColor:topBtn.color];
    
    [self changeTurns];
    
    if (self.saveTopBtn != nil) {
        //还原设置enabled为NO的按钮状态和颜色
        self.saveTopBtn.backgroundColor = [self getColor:self.saveTopBtn.color];
        self.saveTopBtn.enabled = YES;
    }
    if (self.gameMode != kGameModeSolo) {
        ChangeColorButton *btn = self.bottomBtnView.subviews[topBtn.color];
        self.saveTopBtn = btn;
        btn.backgroundColor = [self getColor:-1];
        btn.enabled = NO;
    }
    if (self.gameMode != kGameModeSolo) {
        //更新计数label双人
        [self updataTwoCountTitle];
    }
    
    
    if ( self.zuzhi.count == self.colCount *self.rowCount && self.isWin == NO ) {
        self.win = YES;
        [self isVictory];
        return;
    }else if ( (self.zuzhi.count+self.dangguo.count) == self.colCount *self.rowCount && self.isWin == NO){
        self.win = YES;
        [self isVictory];
        return;
    }
}


- (UIColor* )getColor:(int)colorNum{

    if (colorNum ==-1) {
         return [UIColor clearColor];
    }
    NSArray *currentColor = self.currentColor;
    return  currentColor[colorNum];
}
/**
 *  获取不同的颜色
 *  @param colorNum 得到的颜色与此颜色不同
 *  @return 不同的颜色
 */
- (int)getDifferentColorNum:(int)colorNum{
    while (1) {
        int color = arc4random()%kColorCount;
        if (color != colorNum) {
            return color;
        }
    }
}

-(NSMutableArray *)saveArray{
    if (_saveArray == nil) {
        _saveArray = [NSMutableArray array];
    }
    return _saveArray ;
}


#pragma mark - 辅助代码

-(NSString *)getColorName:(int)colorNum{
    switch (colorNum) {
        case -1:    return @"灰色";         break;
        case  0:     return @"红色";          break;
        case  1:     return @"棕色";     break;
        case  2:     return @"蓝色";        break;
        case  3:     return @"绿色";      break;
        case  4:     return @"黄色";     break;
        case  5:     return @"黑色";       break;
    }
    return @"白色";
}

- (IBAction)clickBtn:(id)sender {
   ChangeColorButton *btn = [self getMaxSumBtn];
//   NSLog(@"最大的方块颜色是 : %@", [self getColorName:btn.color]);
}
@end
