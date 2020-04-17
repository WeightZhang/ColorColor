//
//  HelpView.m
//  洪水猛兽
//
//  Created by 张伟凯 on 14-6-15.
//  Copyright (c) 2014年 张伟凯. All rights reserved.
//

#import "HelpView.h"

@interface HelpView ()
- (IBAction)clickBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *goBtn;

@end

@implementation HelpView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
- (void)awakeFromNib{
    [super awakeFromNib];
    if (!iOS7) {
        self.goBtn.titleLabel.textColor = [UIColor blackColor];
    }
}
- (IBAction)clickBtn:(id)sender {
    [UIView animateWithDuration:0.5 animations:^{
        self.transform = CGAffineTransformMakeScale(0, 0);
    } completion:^(BOOL finished) {
    
        [self removeFromSuperview];
    }];
}
@end
