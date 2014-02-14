//
//  JSONHelper.m
//  HG
//
//  Created by Souvik Ray on 2/8/14.
//  Copyright (c) 2014 com.hg. All rights reserved.
//

#import "JSONHelper.h"
#import "PHRRecord.h"

@implementation JSONHelper

/*+ (NSArray *)groupsFromJSON:(NSData *)objectNotation error:(NSError **)error
{
    NSError *localError = nil;
    NSDictionary *parsedObject = [NSJSONSerialization JSONObjectWithData:objectNotation options:0 error:&localError];
    
    if (localError != nil) {
        *error = localError;
        return nil;
    }
    
    NSMutableArray *groups = [[NSMutableArray alloc] init];
    
    NSArray *results = [parsedObject valueForKey:@"results"];
    NSLog(@"Count %d", results.count);
    
    for (NSDictionary *groupDic in results) {
        Post *group = [[Post alloc] init];
        
        for (NSString *key in groupDic) {
            if ([group respondsToSelector:NSSelectorFromString(key)]) {
                [group setValue:[groupDic valueForKey:key] forKey:key];
            }
        }
        
        [groups addObject:group];
    }
    
    return groups;
}

+ (NSArray *)postsFromJSON:(NSDictionary *)objectNotation
{
    
    NSMutableArray *groups = [[NSMutableArray alloc] initWithCapacity:100];
    NSLog(@"Count %d", 100);
    
    //NSArray *results = [parsedObject valueForKey:@"result"];
    NSArray *results = [objectNotation objectForKey:@"result"];
    NSLog(@"Count %d", results.count);
    for (NSDictionary *groupDic in results) {
        Post *group = [[Post alloc] init];
        
        for (NSString *key in groupDic) {
            if ([group respondsToSelector:NSSelectorFromString(key)]) {
                NSLog(@"Here %d", results.count);
                [group setValue:[groupDic valueForKey:key] forKey:key];
                NSLog(@"VALUE=%@",[group valueForKey:key]);
            }
        }
        [groups addObject:group];
    }
    
    return groups;
}

+ (NSArray *)notifsFromJSON:(NSDictionary *)objectNotation
{
    
    NSMutableArray *groups = [[NSMutableArray alloc] initWithCapacity:100];
    
    NSArray *results = [objectNotation objectForKey:@"result"];
    for (NSDictionary *groupDic in results) {
        if ([[groupDic valueForKey:@"type"] isEqualToString:@"answer"]) {
            NotifAns *notif = [[NotifAns alloc] init];
            
            for (NSString *key in groupDic) {
                if ([notif respondsToSelector:NSSelectorFromString(key)]) {
                    [notif setValue:[groupDic valueForKey:key] forKey:key];
                }
            }
            [groups addObject:notif];
            
        }
        //else if (<#expression#>) {
        //
        //}
        
        
    }
    
    return groups;
}*/

+ (NSArray *)phrFromJSON:(NSDictionary *)objectNotation
{
    
    NSMutableArray *groups = [[NSMutableArray alloc] initWithCapacity:100];
    NSLog(@"Count %d", 100);
    
    //NSArray *results = [parsedObject valueForKey:@"result"];
    NSArray *results = [objectNotation objectForKey:@"result"];
    NSLog(@"Count %d", results.count);
    for (NSDictionary *groupDic in results) {
        PHRRecord *group = [[PHRRecord alloc] init];
        
        for (NSString *key in groupDic) {
            if ([group respondsToSelector:NSSelectorFromString(key)]) {
                NSLog(@"Here %d", results.count);
                [group setValue:[groupDic valueForKey:key] forKey:key];
                NSLog(@"VALUE=%@",[group valueForKey:key]);
            }
        }
        [groups addObject:group];
    }
    
    return groups;
}

@end
