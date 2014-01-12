//
//  HGMyplusViewController.h
//  HG
//
//  Created by Souvik Ray on 1/11/14.
//  Copyright (c) 2014 com.hg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HGMyplusViewController : UIViewController<CPTPlotDataSource>

@property (nonatomic, strong) CPTGraphHostingView *hostView;

@end
