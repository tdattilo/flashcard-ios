//
//  TrainingWords.m
//  LingFlash
//
//  Created by Thomas Dattilo on 3/31/19.
//  Copyright © 2019 Thomas Dattilo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Vocab.h"
#import "TrainingWords.h"


@interface TrainingWords()
@property(nonatomic)NSMutableArray *privateWords;
@end
@implementation TrainingWords
+(instancetype)sharedVocab{
    static TrainingWords *words;
    if(!words){
        words=[[self alloc] initPrivate];
    }
    return words;
}
-(void)addWords:(NSArray*)arr{
    [self.privateWords addObjectsFromArray:arr];

}


-(instancetype)init{
    [NSException raise:@"Singleton" format:@"Singleton. Use function sharedChapters to init"];
    return nil;
}
-(instancetype)initPrivate{
    self=[super init];
    if(self){
        NSLog(@"Init privateWords");
        self.privateWords=[[NSMutableArray alloc] init];
    }
    return self;
}
-(NSArray*)allWords{
    NSLog(@"Private words count: %ld", [self.privateWords count]);
    return [self.privateWords copy];
}
-(void) clearWords{
    if([self.privateWords count]>0){
        [self.privateWords removeAllObjects];
    }
}

@end
