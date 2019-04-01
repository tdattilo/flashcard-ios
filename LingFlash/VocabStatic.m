//
//  VocabStatic.m
//  LingFlash
//
//  Created by Thomas Dattilo on 3/24/19.
//  Copyright © 2019 Thomas Dattilo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Vocab.h"
#import "VocabStatic.h"


@interface VocabStatic()
@property(nonatomic)NSMutableArray *privateWords;
@end
@implementation VocabStatic
+(instancetype)sharedVocab{
    static VocabStatic *words;
    if(!words){
        words=[[self alloc] initPrivate];
    }
    return words;
}
-(Vocab*)addWord:(NSDictionary*)dict{
    if(self.privateWords==nil){
        NSLog(@"Private Words nil");
    }
    //NSLog(@"Adding Word");
    //NSLog(@"%@", dict);
    Vocab *newWord = [[Vocab alloc] init];
    //NSLog(@"Adding ID");
    newWord.id=[dict[@"id"]intValue];
    //NSLog(@"Adding Book ID");
    newWord.bookId=[dict[@"bookId"] intValue];
    //NSLog(@"Adding Chapter ID");
    newWord.chId=[dict[@"chId"] intValue];
    //NSLog(@"Adding Foreign Word to Object");
    newWord.foreignword =dict[@"foreignword"];
    //NSLog(@"Adding English Word to Object");
    newWord.englishword = dict[@"englishword"];
    //NSLog(@"Adding Word Object to List");
    [self.privateWords addObject:newWord];
    //NSLog(@"Word added successfully!");
    NSLog(@"%ld", [self.privateWords count]);
    return newWord;
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
