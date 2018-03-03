//
//  CourseDetailTableViewController.m
//  goodgood
//
//  Created by GoGo on 15/10/6.
//  Copyright © 2015年 GoGo. All rights reserved.
//

#import "CourseDetailTableViewController.h"
#import "DetailTableViewCell.h"
#import "Crouse.h"
@interface CourseDetailTableViewController ()

@end

@implementation CourseDetailTableViewController

static NSString *courseIdentifer = @"course";
static NSString *timeIdentifer = @"time";
static NSString *classmateIdentifer = @"classmate";
static NSString *deleteIdentifer = @"delete";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.allowsSelection = NO;
    self.navigationItem.title = self.crouse.name;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell1;
    switch (indexPath.section) {
        case 0:{
            DetailTableViewCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"DetailTableViewCell" owner:self options:nil]lastObject];
            cell.name.text = self.crouse.name;
            cell.week.text = [NSString stringWithFormat:@"%d-%d周",self.crouse.beginWeek,self.crouse.endWeek];
            cell.section.text = [NSString stringWithFormat:@"周%d %d-%d节",self.crouse.weekTime,self.crouse.orderTime, self.crouse.orderTime + self.crouse.extend];
            cell.teacher.text = self.crouse.teacher;
            cell.classroom.text = self.crouse.room;
            cell1 = cell;
            break;
        }
        case 1:{
            cell1 =[[[NSBundle mainBundle] loadNibNamed:@"DetailTimeViewCell" owner:self options:nil]lastObject];
            break;
        }
            
            
        default:
            cell1 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"xyz"];
            break;
    }
    return cell1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
            return 130;
            break;
            
        default:
            return 44;
            break;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section == 0){
        return 0;
    }else{
        return 5;
    }
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


@end
