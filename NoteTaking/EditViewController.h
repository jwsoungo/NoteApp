//
//  EditViewController.h
//  NoteTaking
//
//  Created by John Wong on 5/11/2016.
//  Copyright © 2016年 VTC_peak. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *titleField;
@property (weak, nonatomic) IBOutlet UITextView *contentField;
@property (nonatomic, retain) NSString *noteIndex;
@property (nonatomic, retain) NSString *titleText;
@property (nonatomic, retain) NSString *contentText;

@end
