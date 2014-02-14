//
//  HGCholViewController.h
//  HG
//
//  Created by Souvik Ray on 2/13/14.
//  Copyright (c) 2014 com.hg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HGMyPHRViewController.h"

@interface HGCholViewController : UIViewController<UIPickerViewDataSource,UIPickerViewDelegate>

@property(weak, nonatomic)  HGMyPHRViewController *callerView;
@property (strong, nonatomic) IBOutlet UIPickerView *picker;
@property (strong, nonatomic) NSMutableArray  *cholTotalvalueArray;
@property (strong, nonatomic) NSMutableArray  *cholLDLvalueArray;
@property (strong, nonatomic) NSMutableArray  *cholHDLvalueArray;
@property (strong, nonatomic) NSMutableArray  *cholTrivalueArray;
@property (nonatomic,assign) NSInteger cholTotalValue;
@property (nonatomic,assign) NSInteger cholLDLValue;
@property (nonatomic,assign) NSInteger cholHDLValue;
@property (nonatomic,assign) NSInteger cholTriValue;

@end
