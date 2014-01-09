//
//  HGSugarViewController.h
//  HG
//
//  Created by Souvik Ray on 1/7/14.
//  Copyright (c) 2014 com.hg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HGSugarViewController : UIViewController<UIPickerViewDataSource,UIPickerViewDelegate>


@property (strong, nonatomic) IBOutlet UIPickerView *picker;
@property (strong, nonatomic) NSMutableArray  *bpvalueArray;
@property (strong, nonatomic) NSArray  *bptypeArray;

@end
