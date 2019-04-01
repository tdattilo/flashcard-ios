//
//  SettingsViewController.m
//  LingFlash
//
//  Created by Thomas Dattilo on 3/7/19.
//  Copyright © 2019 Thomas Dattilo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "SettingsViewController.h"
#import "TrainingViewController.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

-(instancetype)init{
    self = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"SettingsView"];
    self.tabBarItem.title=@"Settings";
    return self;
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.picker.delegate = self;
    self.picker.dataSource = self;
    [self.view addSubview: self.picker];
    self.newwordrate.text=@"3";
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView*)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return 3;
}
- (NSString *)pickerView:(UIPickerView *)thePickerView
             titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSString *title;
    switch(row){
        case 0:
            title=@"Learn For The First Time";
            break;
        case 1:
            title=@"Review";
            break;
        case 2:
            title=@"Continuous";
            break;
    }
    return title;
}
-(IBAction)startTraining:(id)sender{
    TrainingViewController *tvc = [[TrainingViewController alloc] init];
    tvc.trainingrate=[self.newwordrate.text integerValue];
    tvc.trainingtype=[self.picker selectedRowInComponent: 0];
    [self.navigationController pushViewController:tvc animated:YES];
}

- (void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

@end
