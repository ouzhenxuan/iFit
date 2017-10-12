//
//  footTableViewCell.h
//  iFit
//
//  Created by 区振轩 on 2017/10/11.
//  Copyright © 2017年 区振轩. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FootTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *cellImage;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *suggestLabel;

@end
