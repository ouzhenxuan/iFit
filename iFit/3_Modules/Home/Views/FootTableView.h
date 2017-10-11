//
//  FootTableView.h
//  iFit
//
//  Created by 区振轩 on 2017/10/10.
//  Copyright © 2017年 区振轩. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FootTableView : UITableView

{
    void(^heightReflashBlock)(double height);
}

- (void)registerTheTableViewHeight:(void(^)(double height))block;
@end
