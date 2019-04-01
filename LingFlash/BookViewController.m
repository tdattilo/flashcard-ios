//
//  BookViewController.m
//  LingFlash
//
//  Created by Thomas Dattilo on 3/7/19.
//  Copyright © 2019 Thomas Dattilo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BookViewController.h"
#import "BookStatic.h"
#import "Book.h"
#import "WebPulls.h"
#import "ChapterViewController.h"
#import "ChapterStatic.h"
#import "Chapter.h"

@interface BookViewController()
@property(nonatomic) NSMutableArray* privateBooks;
@end
@implementation BookViewController
-(instancetype)init{
    NSLog(@"Init BookViewController");
    self=[super initWithStyle:UITableViewStylePlain];
    if(self.books==nil){
        NSLog(@"Self.books is nil");
    }
    self.privateBooks=[[NSMutableArray alloc] init];
    BookStatic *bookshelf=[BookStatic sharedBookshelf];
    NSLog(@"%ld", [[bookshelf allBooks] count]);
    for(int i=0; i<[[bookshelf allBooks] count]; i++){
        [self.privateBooks addObject:[bookshelf allBooks][i]];
    }
    UINavigationItem *nav = self.navigationItem;
    nav.title = @"Books";
    nav.hidesBackButton = YES;
    return self;
}
-(instancetype)initWithStyle:(UITableViewStyle)style{
    return [self init];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad{
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier: @"UITableViewBookCell"];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *values = self.books;
    Book *book = values[indexPath.row];
    NSString *book_id = [NSString stringWithFormat:@"%d", book.id];
    NSDictionary *dictionary=@{
                               @"book_id":book_id
                               };
    [WebPulls postCall:dictionary fromURL:@"https://lingflash.herokuapp.com/calls/chapters" completionHandler:^(NSMutableArray *response, NSError *error){
        NSLog(@"Got to Table Completion Handler");
        if(!error){
            NSLog(@"%@", response);
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"Got to async dispatch");
                ChapterStatic *blockChapters=[ChapterStatic sharedChapters];
                [blockChapters clearChapters];
                NSLog(@"%@",[blockChapters description]);
                for(int i=0; i<[response count]; i++){
                    NSLog(@"%@", response[i]);
                    NSLog(@"%@",[response[i] class]);
                    [blockChapters addChapter:response[i]];
                }
                ChapterViewController *chapterController = [[ChapterViewController alloc] init];
                NSLog(@"%ld", [chapterController.chapters count]);
                [self.navigationController pushViewController:chapterController animated:YES];
            });}
    }];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"In table view");
    NSInteger result =[self.books count];
    NSLog(@"%ld", (long)result);
    return result;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"In cell labeling");
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewBookCell" forIndexPath: indexPath];
    NSArray *values = self.books;
    Book *book = values[indexPath.row];
    NSString*label = book.title;
    NSLog(@"%@", label);
    cell.textLabel.text= label;
    return cell;
}

-(NSArray*)books{
    return [self.privateBooks copy];
}
@end
