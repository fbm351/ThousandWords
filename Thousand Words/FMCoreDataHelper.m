//
//  FMCoreDataHelper.m
//  Thousand Words
//
//  Created by Fredrick Myers on 2/28/14.
//  Copyright (c) 2014 Fredrick Myers. All rights reserved.
//

#import "FMCoreDataHelper.h"

@implementation FMCoreDataHelper

+ (NSManagedObjectContext *)managedObjectContext
{
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    
    return context;
}

@end
