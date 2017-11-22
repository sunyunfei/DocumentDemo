//
//  ViewController.m
//  DocumentDemo
//
//  Created by 孙云飞 on 2017/11/22.
//  Copyright © 2017年 孙云飞. All rights reserved.
//

#import "ViewController.h"
#import <QuickLook/QuickLook.h>
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,QLPreviewControllerDataSource,QLPreviewControllerDelegate>{
    
    NSURL *_showUrl;
}
@property(nonatomic,weak)IBOutlet UITableView *tableView;
@property(nonatomic,strong)NSArray *dataArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.dataArray = @[@"test1.pdf",@"test2.xls",@"test3.docx",@"test4.rtf"];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *path = [[NSBundle mainBundle]pathForResource:self.dataArray[indexPath.row] ofType:nil];
    _showUrl = [NSURL fileURLWithPath:path];
    //开始创建
    QLPreviewController *preVC = [[QLPreviewController alloc]init];
    preVC.delegate = self;
    preVC.dataSource = self;
    [self presentViewController:preVC animated:YES completion:nil];
}



#pragma mark -----preDelegate

- (NSInteger)numberOfPreviewItemsInPreviewController:(QLPreviewController *)controller{
    
    return 1;
}

- (id<QLPreviewItem>)previewController:(QLPreviewController *)controller previewItemAtIndex:(NSInteger)index{
    
    return _showUrl;
}
@end
