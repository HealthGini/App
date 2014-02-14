//
//  PHRRecord.m
//  HG
//
//  Created by Souvik Ray on 2/8/14.
//  Copyright (c) 2014 com.hg. All rights reserved.
//

#import "PHRRecord.h"

@implementation PHRRecord

-(id) copyWithZone: (NSZone *) zone
{
    PHRRecord *phrcopy = [[PHRRecord allocWithZone:zone] init];
    _trans_id = @"";
    _trans_value = @"";
    return phrcopy;
}

@end
