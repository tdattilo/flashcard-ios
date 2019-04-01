//
//  ChapterStatic.m
//  LingFlash
//
//  Created by Thomas Dattilo on 3/23/19.
//  Copyright © 2019 Thomas Dattilo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Chapter.h"
#import "ChapterStatic.h"


@interface ChapterStatic()
@property(nonatomic)NSMutableArray *privateChapters;
@end
@implementation ChapterStatic
+(instancetype)sharedChapters{
    static ChapterStatic *chapters;
    if(!chapters){
        chapters=[[self alloc] initPrivate];
    }
    return chapters;
}
-(Chapter*)addChapter:(NSDictionary*)dict{
    NSLog(@"Adding Chapter");
    NSLog(@"%@", dict);
    Chapter *newChapter = [[Chapter alloc]init];
    NSLog(@"Adding ID");
    newChapter.id=[dict[@"id"]intValue];
    NSLog(@"Adding Chapter Title");
    newChapter.chaptitle=dict[@"chaptitle"];
    NSLog(@"Adding Book ID");
    newChapter.book_id=[dict[@"book_id"] intValue];
    NSLog(@"Adding Chapter to List");
    [self.privateChapters addObject:newChapter];
    NSLog(@"Chapter added successfully!");
    return newChapter;
}
-(instancetype)init{
    [NSException raise:@"Singleton" format:@"Singleton. Use function sharedChapters to init"];
    return nil;
}
-(instancetype)initPrivate{
    self=[super init];
    if(self){
        NSLog(@"Init privateBooks");
        self.privateChapters=[[NSMutableArray alloc] init];
    }
    return self;
}
-(NSArray*)allChapters{
    return [self.privateChapters copy];
}
-(void) clearChapters{
    if([self.privateChapters count]>0){
        [self.privateChapters removeAllObjects];
    }
}

@end
