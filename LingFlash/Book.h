//
//  Book.h
//  LingFlash
//
//  Created by Thomas Dattilo on 3/17/19.
//  Copyright © 2019 Thomas Dattilo. All rights reserved.
//

#ifndef Book_h
#define Book_h

#import <Foundation/Foundation.h>

@interface Book:NSObject
@property(nonatomic) int id;
@property(nonatomic) NSString *title;
@property(nonatomic) int owner;

@end

#endif /* Book_h */
