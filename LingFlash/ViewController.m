//
//  ViewController.m
//  LingFlash
//
//  Created by Thomas Dattilo on 2/21/19.
//  Copyright © 2019 Thomas Dattilo. All rights reserved.
//

#import "ViewController.h"
#import "WebPulls.h"
#import "BodyViewController.h"
#import "BookViewController.h"
#import "BookStatic.h"
@interface ViewController ()

@end

@implementation ViewController

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.onOff.hidden=YES;
    // Do any additional setup after loading the view, typically from a nib.
}
-(IBAction)logIn:(id)sender{
    BookStatic *bookshelf=[BookStatic sharedBookshelf];
    NSLog(@"%@",[bookshelf description]);
            NSDictionary *dictionary=@{
                                       @"username":self.username.text,
                                       @"password":self.password.text
                                       };
            __block NSString *result = [NSString string];
            [WebPulls singlePostCall:dictionary fromURL:@"https://lingflash.herokuapp.com/calls/unpw" completionHandler:^(NSDictionary *response, NSError *error) {
                if(!error){
                result = [result stringByAppendingString:response[@"response"]];
                    NSLog(@"Got to first completion handler");
                    NSLog(@"%@", result);
                    if([result intValue]>0){
                        dispatch_async(dispatch_get_main_queue(), ^{
                            NSLog(@"Got to async dispatch");
                            self.onOff.text=@"";
                            NSDictionary *dictionary=@{
                                                       @"user_id":result
                                                       };
                            [WebPulls postCall:dictionary fromURL:@"https://lingflash.herokuapp.com/calls/books" completionHandler:^(NSMutableArray *secondResponse, NSError *errorTwo){
                                NSLog(@"Got to Second Completion Handler");
                                if(!errorTwo){
                                    NSLog(@"%@", secondResponse);
                                    dispatch_async(dispatch_get_main_queue(), ^{
                                        NSLog(@"Got to async dispatch");
                                        BookStatic *blockBookshelf=[BookStatic sharedBookshelf];
                                        NSLog(@"%@",[blockBookshelf description]);
                                        for(int i=0; i<[secondResponse count]; i++){
                                            NSLog(@"%@", secondResponse[i]);
                                            NSLog(@"%@",[secondResponse[i] class]);
                                            [blockBookshelf addBook:secondResponse[i]];
                                        }
                                        BookViewController *bookController = [[BookViewController alloc] init];
/*                                        NSLog(@"%ld", [[blockBookshelf allBooks] count]);
                                        for(int i=0; i<[[blockBookshelf allBooks] count]; i++){
                                            [bookController.books addObject:[blockBookshelf allBooks][i]];
                                        }*/
                                        NSLog(@"%ld", [bookController.books count]);
                                        [self.navigationController pushViewController:bookController animated:YES];
                                    });}
                            }];
                            
                        });
                        
                    }
                    else{
                        dispatch_async(dispatch_get_main_queue(),^{
                            self.onOff.text = [self.onOff.text stringByAppendingString:result];
                            self.onOff.hidden = NO;
                        });
                    }
                    
                }
            }];
}
- (void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

@end
