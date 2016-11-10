//
//  EditViewController.m
//  NoteTaking
//
//  Created by John Wong on 5/11/2016.
//  Copyright © 2016年 VTC_peak. All rights reserved.
//

#import "EditViewController.h"

@interface EditViewController ()

@end

@implementation EditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleField.text = self.titleText;
    self.contentField.text = self.contentText;
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillDisappear:(BOOL)animated {
    self.titleText = self.titleField.text;
    self.contentText = self.contentField.text;
    [self performSegueWithIdentifier:@"saveSegue" sender:self];
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
