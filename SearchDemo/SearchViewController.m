//
//  SearchViewController.m
//  Https_Test
//
//  Created by weiyun on 2017/12/25.
//  Copyright © 2017年 wy. All rights reserved.
//

#import "SearchViewController.h"
#import "NextViewController.h"

#define SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define KEYWINDOW   [UIApplication sharedApplication].keyWindow

@interface SearchViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchResultsUpdating,UISearchBarDelegate>
@property (nonatomic , strong) UITableView * articalTableView;
@property (nonatomic , strong) NSMutableArray * articalArray;///文章数组
@property (nonatomic , assign) NSInteger currentPage;///当前页数
//搜索框
@property (nonatomic, strong) UISearchController *searchController;
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic) BOOL isEdit;
@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    self.articalArray = [[NSMutableArray alloc]initWithCapacity:0];
    self.isEdit = NO;
    
    for (int i = 0; i < 10; i ++) {
        [self.articalArray addObject:[NSString stringWithFormat:@"%zd",i]];
    }
    
    self.articalTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    self.articalTableView.delegate = self;
    self.articalTableView.dataSource = self;
    self.articalTableView.backgroundColor = [UIColor whiteColor];
    self.articalTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.articalTableView.tableFooterView = [UIView new];
    self.articalTableView.tableHeaderView = [UIView new];
    [self.view addSubview:self.articalTableView];
    
    _searchBar = [[UISearchBar alloc] initWithFrame: CGRectMake(0, 0, self.view.frame.size.width, 44)];
    //_searchBar.delegate = self;
    _searchBar.placeholder = @"搜索";
    
    //UIWindow *window = [UIApplication sharedApplication].keyWindow;
    // 创建UISearchController, 这里使用当前控制器来展示结果
   // self.searchController = [[UISearchController alloc]initWithSearchResultsController:[[NextViewController alloc]init]];
    self.searchController = [[UISearchController alloc]initWithSearchResultsController:nil];
    // 设置结果更新代理
    self.searchController.searchResultsUpdater = self;
    // 因为在当前控制器展示结果, 所以不需要这个透明视图
    //self.searchController.dimsBackgroundDuringPresentation = YES;
    self.searchController.dimsBackgroundDuringPresentation = NO;
    self.searchController.searchBar.delegate = self;
    // 将searchBar赋值给tableView的tableHeaderView
    self.articalTableView.tableHeaderView = self.searchController.searchBar;
}
#pragma mark- UITableViewDelegate，UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.articalArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* cellIdentifier = @"cell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = self.articalArray[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (nullable NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    //添加一个删除按钮
    UITableViewRowAction * deleteAction = [UITableViewRowAction rowActionWithStyle:(UITableViewRowActionStyleNormal) title:@"删除" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        NSLog(@"点击了删除");
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"确定删除？" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //1.更新数据
            [self.articalArray removeObjectAtIndex:indexPath.row];
            //2.更新UI
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationAutomatic)];
        }];
        UIAlertAction * action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alert addAction:action1];
        [alert addAction:action2];
        if (self.isEdit == NO) {
            [self presentViewController:alert animated:YES completion:nil];
        }else{
            [_searchController presentViewController:alert animated:YES completion:nil];
        }
    }];
    //删除按钮颜色
    deleteAction.backgroundColor = [UIColor redColor];
    return @[deleteAction];
}
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    self.isEdit = YES;
    return YES;
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    self.isEdit = NO;
}
#pragma mark - UISearchResultsUpdating
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    //NSString *inputStr = searchController.searchBar.text ;
    //[self.articalArray removeAllObjects];
    //self.currentPage = 1;
    //[self getArticalList:inputStr];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
