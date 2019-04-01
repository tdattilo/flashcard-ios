//
//  ChapterStatic.h
//  LingFlash
//
//  Created by Thomas Dattilo on 3/23/19.
//  Copyright © 2019 Thomas Dattilo. All rights reserved.
//

#ifndef ChapterStatic_h
#define ChapterStatic_h

@class Chapter;
@interface ChapterStatic:NSObject
@property(nonatomic, readonly, copy)NSArray *allChapters;
+(instancetype)sharedChapters;
-(Chapter*)addChapter:(NSDictionary*) dict;
-(void)clearChapters;
@end

#endif /* ChapterStatic_h */
