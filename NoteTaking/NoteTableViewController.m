//
//  NoteTableViewController.m
//  NoteTaking
//
//  Created by John Wong on 5/11/2016.
//  Copyright © 2016年 VTC_peak. All rights reserved.
//

#import "NoteTableViewController.h"
#import "EditViewController.h"
@interface NoteTableViewController ()

@end

@implementation NoteTableViewController
int rowSelected = -1;
bool firstRunFlag = true;


- (void)viewDidLoad {
    [super viewDidLoad];
    self.items = [[NSMutableArray alloc] init];
    self.timeStamp = [[NSMutableArray alloc] init];
    self.content = [[NSMutableArray alloc] init];
    self.savePath = [self pathByCopyingFile:@"notes.plist"];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    if (!firstRunFlag) {
        NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:self.savePath];
        self.items = [data objectForKey:@"items"];
        self.content = [data objectForKey:@"content"];
        self.timeStamp = [data objectForKey:@"timeStamp"];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return self.items.count;

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"noteCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = [self.items objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = [self.timeStamp objectAtIndex:indexPath.row];
    
    
    return cell;
}

- (IBAction)addNote:(UIBarButtonItem *)sender{
    NSString *newNote = @"New Note";
    NSDate *currentTime = [NSDate date];
    NSDateFormatter *dataFormatter = [[NSDateFormatter alloc] init];
    [dataFormatter setDateFormat:@"hh:mm:ss YYYY-MM-dd"];
    NSString *newTime = [dataFormatter stringFromDate: currentTime];
    NSString *newContent = @"";
    [self.items addObject:newNote];
    [self.timeStamp addObject:newTime];
    [self.content addObject:newContent];
    [self.tableView reloadData];
    
}

- (IBAction)editTable:(UIBarButtonItem*)sender {
    if (self.editing == NO) {
        sender.title = @"Done";
        self.editing = YES;
    } else {
        sender.title = @"Edit";
        self.editing = NO;
    }
    [self saveNote];
    
}



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [self.tableView beginUpdates];
        [self.items removeObjectAtIndex:indexPath.row];
        [self.content removeObjectAtIndex:indexPath.row];
        [self.timeStamp removeObjectAtIndex:indexPath.row];
        
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self.tableView endUpdates];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}



// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
    
    NSLog(@"%@", self.items);
    NSString *tempItem = self.items[fromIndexPath.row];
    NSString *tempContent = self.content[fromIndexPath.row];
    NSString *tempTimeStamp = self.timeStamp[fromIndexPath.row];
    
    [self.items removeObjectAtIndex:fromIndexPath.row];
    [self.items insertObject:tempItem atIndex:toIndexPath.row];
    [self.content removeObjectAtIndex:fromIndexPath.row];
    [self.content insertObject:tempContent atIndex:toIndexPath.row];
    [self.timeStamp removeObjectAtIndex:fromIndexPath.row];
    [self.timeStamp insertObject:tempTimeStamp atIndex:toIndexPath.row];
    NSLog(@"%@", self.items);
}



// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    rowSelected = indexPath.row;
    EditViewController *evc = segue.destinationViewController;
    evc.titleText = [self.items objectAtIndex:indexPath.row];
    evc.contentText = [self.content objectAtIndex:indexPath.row];
    evc.noteIndex = [NSString stringWithFormat:@"%d", rowSelected];
    
}

- (IBAction)unwindToHome:(UIStoryboardSegue *)unwindSegue {
    NSLog(@"Segue has unwound to here...");
    EditViewController *evc = unwindSegue.sourceViewController;
    NSString *title = evc.titleText;
    NSString *content = evc.contentText;
    NSString *noteIndex = evc.noteIndex;
    NSDate *currentTime = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"hh:mm:ss YYYY-MM-dd"];
    NSString *newTime = [dateFormatter stringFromDate: currentTime];
    NSLog(@"title: %@", title);
    [self.items replaceObjectAtIndex:[noteIndex intValue] withObject:title];
    [self.content replaceObjectAtIndex:[noteIndex intValue] withObject:content];
    [self.timeStamp replaceObjectAtIndex:[noteIndex intValue] withObject:newTime];
    [self.tableView reloadData];
    [self saveNote];
}


- (NSString *)pathByCopyingFile:(NSString *)fileName {
    NSArray *comp = [fileName componentsSeparatedByString: @"."];
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *srcPath = [bundle pathForResource:comp[0] ofType:comp[1]];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documents = [paths objectAtIndex:0];
    NSString *path = [documents stringByAppendingPathComponent:fileName];
    if (![fileManager fileExistsAtPath:path] && srcPath !=nil) {
        NSError *error;
        [fileManager copyItemAtPath:srcPath toPath:path error:&error];
        
    } else {
        
        firstRunFlag = false;
    }
    return path;
}

- (void) saveNote {
    
    NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
    [data setValue:self.items forKey:@"items"];
    [data setValue:self.content forKey:@"content"];
    [data setValue:self.timeStamp forKey:@"timeStamp"];
    [data writeToFile:self.savePath atomically:YES];
    
}


@end
