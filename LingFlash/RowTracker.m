//
//  RowTracker.m
//  LingFlash
//
//  Created by Thomas Dattilo on 3/27/19.
//  Copyright © 2019 Thomas Dattilo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RowTracker.h"


@interface RowTracker()
@property(nonatomic)NSMutableArray *privateRows;
@end
@implementation RowTracker
+(instancetype)sharedRows{
    static RowTracker *rows;
    if(!rows){
        rows=[[self alloc] initPrivate];
    }
    return rows;
}
-(void)addRows:(NSInteger)vals{
    self.privateRows = [[NSMutableArray alloc] init];
    for(int i = 0; i<vals; i++){
        [self.privateRows addObject:@1];
    }
    if([self.privateRows count]>0){
        NSLog(@"%@", self.privateRows[0]);
    }
}
-(instancetype)init{
    [NSException raise:@"Singleton" format:@"Singleton. Use function sharedChapters to init"];
    return nil;
}
-(instancetype)initPrivate{
    self=[super init];
    if(self){
        NSLog(@"Init Private Array");
    }
    return self;
}
-(void)rowTap:(NSInteger) row{
    if(self.privateRows[row]==0){
        self.privateRows[row]=@1;
    }
    else{
        self.privateRows[row]=@0;
    }
}
-(NSArray*)allRows{
    return self.privateRows;
}
-(void) clearRows{
    if([self.privateRows count]!=0){
        [self.privateRows removeAllObjects];
    }
}
-(int) length{
    return [self.privateRows count];
}

@end
