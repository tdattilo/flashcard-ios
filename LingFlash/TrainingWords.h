//
//  TrainingWords.h
//  LingFlash
//
//  Created by Thomas Dattilo on 3/31/19.
//  Copyright © 2019 Thomas Dattilo. All rights reserved.
//

#ifndef TrainingWords_h
#define TrainingWords_h
@interface TrainingWords:NSObject
@property(nonatomic, readonly, copy)NSArray *allWords;
@property(nonatomic, readonly, copy)NSArray *rightWrong;
+(instancetype)sharedVocab;
-(void)addWords:(NSArray*) arr;
-(void)clearWords;
@end


#endif /* TrainingWords_h */
