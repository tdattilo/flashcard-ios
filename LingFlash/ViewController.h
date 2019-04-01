//
//  ViewController.h
//  LingFlash
//
//  Created by Thomas Dattilo on 2/21/19.
//  Copyright © 2019 Thomas Dattilo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (nonatomic, weak) IBOutlet UILabel *onOff;
@property (nonatomic, weak) IBOutlet UITextField *username;
@property (nonatomic, weak) IBOutlet UITextField *password;
-(IBAction)logIn:(id)sender;
@end

