//
//  OverView.m
//  洪水猛兽
//
//  Created by 张伟凯 on 14-6-13.
//  Copyright (c) 2014年 张伟凯. All rights reserved.
//

#import "OverView.h"
#import "ColorTool.h"

@interface OverView ()
- (IBAction)back:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *backBtn;

@property (weak, nonatomic) IBOutlet UIView *numView;
@property (weak, nonatomic) IBOutlet UILabel *topNum;
@property (weak, nonatomic) IBOutlet UILabel *bottomNum;

@end
@implementation OverView


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
- (void)awakeFromNib{
    self.backBtn.backgroundColor = [ColorTool RGBColor3][arc4random()%6];
    self.backBtn.layer.cornerRadius = 5;
    self.numView.layer.cornerRadius = 5;
    if (!iOS7) {
        self.backBtn.titleLabel.textColor=[UIColor blackColor];
    }
   
}
- (void)willMoveToSuperview:(UIView *)newSuperview{
    if (self.gameMode == kGameModeSolo) {
        self.numView.alpha = 0;
    }else{
        self.topNum.text = [NSString stringWithFormat:@"%d",self.topnum ];
        self.bottomNum.text =[NSString stringWithFormat:@"%d",self.bottomnum ];
    }
}
- (IBAction)back:(id)sender {
    if ([self.delegate respondsToSelector:@selector(overViewClickBackBtn)]) {
        [self.delegate overViewClickBackBtn];
    }
}
@end
