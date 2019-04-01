//
//  SettingsViewController.h
//  LingFlash
//
//  Created by Thomas Dattilo on 3/7/19.
//  Copyright © 2019 Thomas Dattilo. All rights reserved.
//

#ifndef SettingsViewController_h
#define SettingsViewController_h
#import <UIKit/UIKit.h>

@interface SettingsViewController : UIViewController<UIPickerViewDelegate, UIPickerViewDataSource>
@property (nonatomic, weak) IBOutlet UITextField *newwordrate;
@property (nonatomic, weak) IBOutlet UIPickerView *picker;
-(IBAction)startTraining:(id)sender;
@end

#endif /* SettingsViewController_h */
