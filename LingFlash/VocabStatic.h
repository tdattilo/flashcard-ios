//
//  VocabStatic.h
//  LingFlash
//
//  Created by Thomas Dattilo on 3/24/19.
//  Copyright © 2019 Thomas Dattilo. All rights reserved.
//

#ifndef VocabStatic_h
#define VocabStatic_h

@class Vocab;
@interface VocabStatic:NSObject
@property(nonatomic, readonly, copy)NSArray *allWords;
+(instancetype)sharedVocab;
-(Vocab*)addWord:(NSDictionary*) dict;
-(void)clearWords;
@end


#endif /* VocabStatic_h */
