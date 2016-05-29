//
//  NSArray+MHSourceFileSorting.m
//  MHImportBuster
//
//  Created by Marko Hlebar on 02/05/2016.
//  Copyright © 2016 Marko Hlebar. All rights reserved.
//

#import "NSArray+MHSourceFileSorting.h"
#import "MHHeaderCache.h"
#import "MHSourceFile.h"
#import "NSString+CamelCase.h"
#import "NSString+Score.h"

@implementation NSArray (MHSourceFileSorting)

- (NSArray *)mh_sortedResultsForSearchString:(NSString *)string; {
    //TODO: this implicit dependency is not great.
    MHHeaderCache *cache = [MHHeaderCache sharedCache];
    
    return [self sortedArrayUsingComparator:^NSComparisonResult(id <MHSourceFile> _Nonnull obj1, id <MHSourceFile> _Nonnull obj2) {

        CGFloat firstObjectScore = [[obj1 name] scoreAgainst: string fuzziness: @(1) options: NSStringScoreOptionFavorSmallerWords];

        CGFloat secondObjectScore = [[obj2 name] scoreAgainst: string
                                                    fuzziness: @(1)
                                                      options: NSStringScoreOptionFavorSmallerWords];

        if (firstObjectScore > secondObjectScore) {
            return NSOrderedAscending;
        }
        else if (firstObjectScore < secondObjectScore) {
            return NSOrderedDescending;
        }
        else {
            return NSOrderedSame;
        }        
    }];
}

@end
