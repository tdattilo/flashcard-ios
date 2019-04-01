//
//  Vocab.h
//  LingFlash
//
//  Created by Thomas Dattilo on 3/24/19.
//  Copyright © 2019 Thomas Dattilo. All rights reserved.
//

#ifndef Vocab_h
#define Vocab_h

@interface Vocab:NSObject
@property(nonatomic) int id;
@property(nonatomic) int bookId;
@property(nonatomic) int chId;
@property(nonatomic) NSString *foreignword;
@property(nonatomic) NSString *englishword;

@end


#endif /* Vocab_h */
