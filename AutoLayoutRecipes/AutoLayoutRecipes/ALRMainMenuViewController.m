//
//  ALRMainMenuViewController.m
//  AutoLayoutRecipes
//
//  Created by Allen Cheung on 4/1/15.
//  Copyright (c) 2015 Allen Cheung. All rights reserved.
//

#import "ALRMainMenuViewController.h"

#import "ALRKeyboardViewController.h"

@interface ALRMainMenuViewController ()

@property (copy, nonatomic) NSArray *actionViewControllers;

@end

@implementation ALRMainMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"Recipes", nil);
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"foo"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIViewController *)_viewControllerForRow:(NSInteger)row {
    if (!self.actionViewControllers) {
        self.actionViewControllers = @[
                                       [[ALRKeyboardViewController alloc] init],
                                       ];
    }
    return self.actionViewControllers[row];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"foo" forIndexPath:indexPath];
    
    cell.textLabel.text = [self _viewControllerForRow:indexPath.row].title;
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UIViewController *viewController = [self _viewControllerForRow:indexPath.row];
    [self.navigationController pushViewController:viewController animated:YES];
}

@end
