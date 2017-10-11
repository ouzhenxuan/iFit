//
//  LabelNumView.m
//  iFit
//
//  Created by 区振轩 on 2017/9/23.
//  Copyright © 2017年 区振轩. All rights reserved.
//

#import "LabelNumView.h"


@interface LabelNumView ()

@property (weak, nonatomic) IBOutlet UILabel *NumLabel;
@property (weak, nonatomic) IBOutlet UILabel *NameLabel;

@end

@implementation LabelNumView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)awakeFromNib{

    [super awakeFromNib];
    NSLog(@"123");
}

- (instancetype)init{
    self = [super init];
    if (self) {
        NSLog(@"1345");
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        NSLog(@"990");
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self =  [super initWithFrame:frame];
    if (self) {
        NSLog(@"jklj");
        
    }
    return self;
}

- (void)setNumFontSize:(int)NumFontSize{
    _NumFontSize = NumFontSize;
    self.NumLabel.font = [UIFont systemFontOfSize:NumFontSize];
}

-(instancetype) initViewWithNum:(int)num Title:(NSString *)title{
    
    self = [[[NSBundle mainBundle] loadNibNamed:@"LabelNumView" owner:nil options:nil] lastObject];
    
    [self.NumLabel setText:[NSString stringWithFormat:@"%d",num]];
    [self.NameLabel setText:title];
    
    self.NumLabel.adjustsFontSizeToFitWidth=YES;
    [self.NumLabel setAdjustsFontSizeToFitWidth:YES];
    self.NumLabel.minimumScaleFactor = 0.1;
    return self;
}



@end
