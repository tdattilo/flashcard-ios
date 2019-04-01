//
//  TrainingViewController.m
//  LingFlash
//
//  Created by Thomas Dattilo on 3/7/19.
//  Copyright © 2019 Thomas Dattilo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TrainingViewController.h"

@interface TrainingViewController ()

@end

@implementation TrainingViewController

-(instancetype)init{
    self = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"TrainingView"];
    return self;
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}

-(IBAction)checkAnswer:(id)sender{
    
}

- (void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

@end
