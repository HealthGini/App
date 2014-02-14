//
//  JSONHelper.h
//  HG
//
//  Created by Souvik Ray on 2/8/14.
//  Copyright (c) 2014 com.hg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSONHelper : NSObject


//+ (NSArray *)groupsFromJSON:(NSData *)objectNotation error:(NSError **)error;
//+ (NSArray *)postsFromJSON:(NSDictionary *)objectNotation;
//+ (NSArray *)notifsFromJSON:(NSDictionary *)objectNotation;
+ (NSArray *)phrFromJSON:(NSDictionary *)objectNotation;


@end
