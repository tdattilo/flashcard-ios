//
//  TrainingViewController.h
//  LingFlash
//
//  Created by Thomas Dattilo on 3/7/19.
//  Copyright © 2019 Thomas Dattilo. All rights reserved.
//

#ifndef TrainingViewController_h
#define TrainingViewController_h

#import <UIKit/UIKit.h>

@interface TrainingViewController : UIViewController
@property (nonatomic) NSInteger trainingrate;
@property (nonatomic) NSInteger trainingtype;
@property (nonatomic, weak) IBOutlet UILabel *targetword;
@property (nonatomic, weak) IBOutlet UILabel *correctWrong;
@property (nonatomic, weak) IBOutlet UITextField *response;
-(IBAction)checkAnswer:(id)sender;
@end

#endif /* TrainingViewController_h */
