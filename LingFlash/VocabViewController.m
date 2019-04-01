//
//  VocabViewController.m
//  LingFlash
//
//  Created by Thomas Dattilo on 3/7/19.
//  Copyright © 2019 Thomas Dattilo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Vocab.h"
#import "VocabStatic.h"
#import "VocabViewController.h"
#import "WebPulls.h"
#import "RowTracker.h"
#import "TrainingWords.h"

@interface VocabViewController()
@property(nonatomic) NSMutableArray* privateWords;
@end

@implementation VocabViewController
-(instancetype)init{
    NSLog(@"Init VocabViewController");
    self=[super initWithStyle:UITableViewStylePlain];
    if(self.words==nil){
        NSLog(@"Self.words is nil");
    }
    self.privateWords=[[NSMutableArray alloc] init];
    VocabStatic *wordlist=[VocabStatic sharedVocab];
    NSLog(@"%ld", [[wordlist allWords] count]);
    for(int i=0; i<[[wordlist allWords] count]; i++){
        [self.privateWords addObject:[wordlist allWords][i]];
    }
    self.tabBarItem.title=@"Vocab";
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
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier: @"UITableViewVocabCell"];
}
- (void)viewWillDisappear:(BOOL)animated;{
    RowTracker* rows = [RowTracker sharedRows];
    VocabStatic *voc=[VocabStatic sharedVocab];
    NSMutableArray *checkedRows = [[NSMutableArray alloc] init];
    for(int i=0; i<[rows length]; i++){
        if([rows allRows][i]>0){
            [checkedRows addObject:[voc allWords][i]];
        }
        
    }
    TrainingWords *tw = [TrainingWords sharedVocab];
    [tw clearWords];
    [tw addWords:checkedRows];
    [super viewWillDisappear:animated];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if(cell.accessoryType==UITableViewCellAccessoryCheckmark){
        cell.accessoryType=UITableViewCellAccessoryNone;
    }
    else{
        cell.accessoryType=UITableViewCellAccessoryCheckmark;
    }
    RowTracker *rt = [RowTracker sharedRows];
    [rt rowTap:indexPath.row];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"In table view");
    NSInteger result =[self.privateWords count];
    NSLog(@"Words held in view controller: %ld", (long)result);
    RowTracker *rt = [RowTracker sharedRows];
    [rt clearRows];
    [rt addRows: result];
    return result;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"In cell labeling");
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewVocabCell" forIndexPath: indexPath];
    NSArray *values = self.privateWords;
    Vocab *word = values[indexPath.row];
    NSString*label = word.foreignword;
    NSLog(@"%@", label);
    cell.textLabel.text= [[label stringByAppendingString: @" | "] stringByAppendingString:word.englishword];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    return cell;
}



@end
