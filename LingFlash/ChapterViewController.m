//
//  ChapterViewController.m
//  LingFlash
//
//  Created by Thomas Dattilo on 3/7/19.
//  Copyright © 2019 Thomas Dattilo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ChapterViewController.h"
#import "ChapterStatic.h"
#import "Chapter.h"
#import "Vocab.h"
#import "VocabStatic.h"
#import "VocabViewController.h"
#import "WebPulls.h"
#import "RowTracker.h"
#import "SettingsViewController.h"

@interface ChapterViewController()
@property(nonatomic) NSMutableArray* privateChapters;
@end

@implementation ChapterViewController
-(instancetype)init{
    NSLog(@"Init ChapterViewController");
    self=[super initWithStyle:UITableViewStylePlain];
    if(self.chapters==nil){
        NSLog(@"Self.chapters is nil");
    }
    self.privateChapters=[[NSMutableArray alloc] init];
    ChapterStatic *chapterlist=[ChapterStatic sharedChapters];
    NSLog(@"%ld", [[chapterlist allChapters] count]);
    for(int i=0; i<[[chapterlist allChapters] count]; i++){
        [self.privateChapters addObject:[chapterlist allChapters][i]];
    }
    UINavigationItem *nav = self.navigationItem;
    nav.title = @"Chapters";
    nav.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemPlay target:self action:@selector(goToVocab:)];
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
-(void)goToVocab:(UITableView *)tableView{
    RowTracker *rows = [RowTracker sharedRows];
    VocabStatic *voc=[VocabStatic sharedVocab];
    [voc clearWords];
    NSMutableArray *checkedRows = [[NSMutableArray alloc] init];
    for(int i=0; i<[rows length]; i++){
        if([rows allRows][i]>0){
            [checkedRows addObject:[[ChapterStatic sharedChapters] allChapters][i]];
        }
    }
    NSMutableArray *dictList = [[NSMutableArray alloc] init];
    for(Chapter *ch in checkedRows){
        NSString *ch_id = [NSString stringWithFormat:@"%d", ch.id];
        NSDictionary *dict = @{
                               @"ch_id":ch_id
                               };
        [dictList addObject:dict];
    }
        [WebPulls multiPostCall:dictList fromURL:@"https://lingflash.herokuapp.com/calls/words" completionHandler:^(NSMutableArray *response, NSError *error){
            if(!error){

                [[NSNotificationCenter defaultCenter] addObserverForName:@"Data Task Successful" object:nil queue:nil usingBlock:^(NSNotification *note){
                    NSLog(@"%@", response);
                    for(int i=0; i<[response count]; i++){
                        [voc addWord:response[i]];
                    }
                    NSLog(@"Words in controller %ld", [[voc allWords] count]);
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"WordsAdded" object:nil];
                }];
            }}];
    [[NSNotificationCenter defaultCenter] addObserverForName:@"WordsAdded" object:nil queue:nil usingBlock:^(NSNotification *note){
            NSLog(@"Got to Vocab Controller Creation");
        dispatch_async(dispatch_get_main_queue(),^{
            NSLog(@"Words before vocab controller %ld", [[voc allWords] count]);
            SettingsViewController *svc = [[SettingsViewController alloc] init];
            VocabViewController *vvc= [[VocabViewController alloc] init];
            UITabBarController *tvc = [[UITabBarController alloc] init];
            tvc.viewControllers=@[vvc, svc];
            [self.navigationController pushViewController:tvc animated:YES];
        });
    }];

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
    NSInteger result =[self.privateChapters count];
    NSLog(@"%ld", (long)result);
    RowTracker *rt = [RowTracker sharedRows];
    [rt addRows: result];
    return result;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"In cell labeling");
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewBookCell" forIndexPath: indexPath];
    NSArray *values = self.privateChapters;
    Chapter *chapter = values[indexPath.row];
    NSString*label = chapter.chaptitle;
    NSLog(@"%@", label);
    cell.textLabel.text= label;
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    return cell;
}

-(NSArray*)chapters{
    return [self.privateChapters copy];
}
@end
