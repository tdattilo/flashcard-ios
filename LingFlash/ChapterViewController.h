//
//  ChapterViewController.h
//  LingFlash
//
//  Created by Thomas Dattilo on 3/7/19.
//  Copyright © 2019 Thomas Dattilo. All rights reserved.
//

#ifndef ChapterViewController_h
#define ChapterViewController_h

#import <UIKit/UIKit.h>

@interface ChapterViewController:UITableViewController
@property (nonatomic, assign)NSArray *chapters;

-(void)goToVocab:(UITableView *)tableView;
@end

#endif /* ChapterViewController_h */
