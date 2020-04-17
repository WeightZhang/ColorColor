//
//  StartViewController.m
//  洪水猛兽
//
//  Created by 张伟凯 on 14-6-15.
//  Copyright (c) 2014年 张伟凯. All rights reserved.
//

#import "StartViewController.h"

@interface StartViewController ()
{
    GameMode gameMode;
    int color;
    int mapRow;
    int mapCol;
    int mapSize;
}
- (IBAction)clickGameModeBtn:(id)sender;
- (IBAction)clickChangeColorBtn:(id)sender;
- (IBAction)clickChangeMapSizeBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *gameModeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *gameColor;
@property (weak, nonatomic) IBOutlet UILabel *mapSizeLabel;
- (IBAction)clickStartBtn:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *startBtn;

@end

@implementation StartViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
        self.startBtn.layer.cornerRadius = 5;
    self.startBtn.backgroundColor = [ColorTool RGBColorBG][arc4random()%12];
    self.view.backgroundColor = [ColorTool RGBColorBG][arc4random()%12];
    if (!iOS7) {
        self.startBtn.titleLabel.textColor = [UIColor blackColor];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)awakeFromNib{
    [super awakeFromNib];


}
- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    

    
    
    
    DataTool *data = [DataTool sharedDataTool];
    [data loadData];
    gameMode = data.gameMode;
     color = data.btnColor;
     mapRow = data.mapRow;
     mapCol = data.mapCol;
     mapSize = data.mapSize;
    
    [self setGameMode:gameMode];
    [self setMapSize:mapSize];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)clickGameModeBtn:(id)sender {
    gameMode ++;
    if (gameMode > kGameMode2P) {
        gameMode = kGameModeSolo;
    }
    [self setGameMode:gameMode];
}
- (void)setGameMode:(GameMode)mode{
    switch (mode) {
        case kGameModeSolo:     self.gameModeLabel.text = @"Yourself";        break;
        case kGameMode2P:     self.gameModeLabel.text = @"Your Friend";        break;
        case kGameModeCliverCPU:     self.gameModeLabel.text = @"Advanced CPU";        break;
        case kGameModeWithFastCPU:     self.gameModeLabel.text = @"Normal CPU";        break;
    }
}

- (IBAction)clickChangeColorBtn:(id)sender {
    color ++;
    if (color > 3) {
        color = 0;
    }
    [self setColors:color];
  
}
- (void)setColors:(int)btncolor{
    switch (btncolor) {
        case 0:     self.gameColor.image= [UIImage imageNamed:@"btnColor0.png"];     break;
        case 1:     self.gameColor.image= [UIImage imageNamed:@"btnColor1.png"];        break;
        case 2:     self.gameColor.image= [UIImage imageNamed:@"btnColor2.png"];       break;
        case 3:     self.gameColor.image= [UIImage imageNamed:@"btnColor3.png"];       break;
    }
}
- (IBAction)clickChangeMapSizeBtn:(id)sender {
    mapSize ++;
    if (mapSize > kMapSize18X26) {
        mapSize = kMapSize6X8;
    }
    [self setMapSize:mapSize];
}
- (void)setMapSize:(MapSize)size{
    if (fourInch) {
        switch (size) {
            case kMapSize6X8:     self.mapSizeLabel.text = @"6 X 8";      mapCol = 6; mapRow = 8;  break;
            case kMapSize8X11:     self.mapSizeLabel.text = @"8 X 11";   mapCol = 8; mapRow = 11;     break;
            case kMapSize12X16:     self.mapSizeLabel.text = @"12 X 16";  mapCol = 12; mapRow = 16;      break;
            case kMapSize18X26:     self.mapSizeLabel.text = @"18 X 26";   mapCol = 18; mapRow = 26;     break;
        }
    }else{
        switch (size) {
            case kMapSize6X8:     self.mapSizeLabel.text = @"6 X 6";      mapCol = 6; mapRow = 8;  break;
            case kMapSize8X11:     self.mapSizeLabel.text = @"8 X 8";   mapCol = 8; mapRow = 11;     break;
            case kMapSize12X16:     self.mapSizeLabel.text = @"12 X 12";  mapCol = 12; mapRow = 16;      break;
            case kMapSize18X26:     self.mapSizeLabel.text = @"18 X 18";   mapCol = 18; mapRow = 26;     break;
        }

    }

}
- (IBAction)clickStartBtn:(id)sender {
    DataTool *data =[DataTool sharedDataTool];
    data.gameMode = gameMode;
    data.mapCol = mapCol;
    data.mapRow = mapRow;
    data.btnColor = color;
    data.mapSize = mapSize;
    [data saveDateToBundle];
}
@end
