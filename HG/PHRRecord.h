//
//  PHRRecord.h
//  HG
//
//  Created by Souvik Ray on 2/8/14.
//  Copyright (c) 2014 com.hg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PHRRecord : NSObject<NSCopying>
@property (nonatomic, copy) NSString *trans_id;
@property (nonatomic, copy) NSString *trans_value;
@end
