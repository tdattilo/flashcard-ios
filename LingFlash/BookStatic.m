//
//  BookStatic.m
//  LingFlash
//
//  Created by Thomas Dattilo on 3/17/19.
//  Copyright © 2019 Thomas Dattilo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BookStatic.h"
#import "Book.h"
@interface BookStatic()
@property(nonatomic)NSMutableArray *privateBooks;
@end
@implementation BookStatic
    +(instancetype)sharedBookshelf{
        static BookStatic *bookshelf;
        if(!bookshelf){
            bookshelf=[[self alloc] initPrivate];
        }
        return bookshelf;
    }
-(Book*)addBook:(NSDictionary*)dict{
    NSLog(@"Adding Book");
    NSLog(@"%@", dict);
    Book *newBook = [[Book alloc]init];
    NSLog(@"Adding ID");
    newBook.id=[dict[@"id"]intValue];
    NSLog(@"Adding Title");
    newBook.title=dict[@"title"];
    NSLog(@"Adding Owner");
    newBook.owner=[dict[@"owner"] intValue];
    NSLog(@"Adding Book to Shelf");
    [self.privateBooks addObject:newBook];
    NSLog(@"Book added successfully!");
    return newBook;
}
-(instancetype)init{
    [NSException raise:@"Singleton" format:@"Singleton. Use function sharedBookshelf to init"];
    return nil;
}
-(instancetype)initPrivate{
    self=[super init];
    if(self){
        NSLog(@"Init privateBooks");
        self.privateBooks=[[NSMutableArray alloc] init];
    }
    return self;
}
-(NSArray*)allBooks{
    return [self.privateBooks copy];
}

@end
