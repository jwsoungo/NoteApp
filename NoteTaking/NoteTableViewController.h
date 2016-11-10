//
//  NoteTableViewController.h
//  NoteTaking
//
//  Created by John Wong on 5/11/2016.
//  Copyright © 2016年 VTC_peak. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NoteTableViewController : UITableViewController
@property (nonatomic, retain) NSMutableArray *items;
@property (nonatomic, retain) NSMutableArray *timeStamp;
@property (nonatomic, retain) NSMutableArray *content;
@property (nonatomic, retain) NSString *savePath;

- (IBAction)addNote:(UIBarButtonItem*)sender;
- (IBAction)editTable:(UIBarButtonItem*)sender;

@end
