//
//  BookStatic.h
//  LingFlash
//
//  Created by Thomas Dattilo on 3/17/19.
//  Copyright © 2019 Thomas Dattilo. All rights reserved.
//

#ifndef BookStatic_h
#define BookStatic_h
@class Book;
@interface BookStatic:NSObject
@property(nonatomic, readonly, copy)NSArray *allBooks;
    +(instancetype)sharedBookshelf;
-(Book*)addBook:(NSDictionary*) dict;

@end

#endif /* BookStatic_h */
