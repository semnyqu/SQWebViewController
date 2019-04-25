//
//  TableViewController.m
//  SQWebViewController
//
//  Created by ai on 15/12/23.
//  Copyright © 2015年 AiXing. All rights reserved.
//

#import "TableViewController.h"
#import "SQWebViewController.h"
#import <AXPracticalHUD/AXPracticalHUD.h>
#import "TestWebViewController.h"

@interface TableViewController () <UITextFieldDelegate>

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedStringFromTableInBundle(@"back", @"SQWebViewController", [NSBundle bundleWithPath:[[[NSBundle bundleForClass:NSClassFromString(@"SQWebViewController")] resourcePath] stringByAppendingPathComponent:@"SQWebViewController.bundle"]], @"Back") style:0 target:nil action:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:
        {
            SQWebViewController *webVC = [[SQWebViewController alloc] initWithURL:[NSURL fileURLWithPath:[NSBundle.mainBundle pathForResource:@"Swift" ofType:@"pdf"]]];
            webVC.title = @"Swift.pdf";
            webVC.isTitleFixedCoded = YES;
            webVC.showsToolBar = NO;
            if (AX_WEB_VIEW_CONTROLLER_iOS9_0_AVAILABLE()) {
                webVC.webView.allowsLinkPreview = YES;
            }
            [self.navigationController pushViewController:webVC animated:YES];
        }
            break;
        case 1:
        {
//            SQWebViewController *webVC = [[SQWebViewController alloc] initWithAddress:@"http://www.baidu.com"];
//            webVC.showsToolBar = NO;
//            // webVC.showsNavigationCloseBarButtonItem = NO;
//            webVC.title = @"TEST_TEST";
//            webVC.isTitleFixedCoded = NO;
//            if (AX_WEB_VIEW_CONTROLLER_iOS9_0_AVAILABLE()) {
//                webVC.webView.allowsLinkPreview = YES;
//            }
            TestWebViewController *testVC = [[TestWebViewController alloc] init];
            testVC.title = @"TEST_WEBVC";
            [self.navigationController pushViewController:testVC animated:YES];
        }
            break;
        case 2:
        {
            SQWebViewController *webVC = [[SQWebViewController alloc] initWithAddress:@"http://www.baidu.com"];
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:webVC];
            nav.navigationBar.tintColor = [UIColor colorWithRed:0.322 green:0.322 blue:0.322 alpha:1.00];
            [self presentViewController:nav animated:YES completion:NULL];
            webVC.showsToolBar = YES;
            webVC.navigationType = 1;
            webVC.title = nil;
            webVC.isTitleFixedCoded = YES;
        }
            break;
        case 3: {
            SQWebViewController *webVC = [[SQWebViewController alloc] initWithAddress:@"https://github.com/devedbox/SQWebViewController"];
            webVC.showsToolBar = NO;
            webVC.showsBackgroundLabel = NO;
            webVC.title = @"TEST_TEST";
            webVC.isTitleFixedCoded = YES;
            // webVC.showsNavigationBackBarButtonItemTitle = NO;
            if (kCFCoreFoundationVersionNumber >= kCFCoreFoundationVersionNumber_iOS_9_0) {
                webVC.webView.allowsLinkPreview = YES;
            }
            [self.navigationController pushViewController:webVC animated:YES];
        } break;
        case 4: {
            SQWebViewController *webVC = [[SQWebViewController alloc] initWithAddress:@"https://github.com/devedbox/SQWebViewController/releases/latest"];
            webVC.showsToolBar = NO;
            if (kCFCoreFoundationVersionNumber >= kCFCoreFoundationVersionNumber_iOS_9_0) {
                webVC.webView.allowsLinkPreview = YES;
            }
            [self.navigationController pushViewController:webVC animated:YES];
        } break;
        default:
            break;
    }
}

- (void)handle:(id)sender {
    NSURL *URL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"SQWebViewController.bundle/html.bundle/neterror" ofType:@"html" inDirectory:nil]];
    SQWebViewController *webVC = [[SQWebViewController alloc] initWithURL:URL];
    webVC.showsToolBar = NO;
    webVC.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0.100f green:0.100f blue:0.100f alpha:0.800f];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.996f green:0.867f blue:0.522f alpha:1.00f];
    [self.navigationController pushViewController:webVC animated:YES];
}

- (IBAction)gotoGithub:(id)sender {
    SQWebViewController *webVC = [[SQWebViewController alloc] initWithAddress:@"https://github.com/devedbox/SQWebViewController"];
    webVC.showsToolBar = NO;
    if (kCFCoreFoundationVersionNumber >= kCFCoreFoundationVersionNumber_iOS_9_0) {
        webVC.webView.allowsLinkPreview = YES;
    }
    [self.navigationController pushViewController:webVC animated:YES];
}

- (IBAction)clearCache:(id)sender {
    [[AXPracticalHUD sharedHUD] showNormalInView:self.navigationController.view text:@"清理缓存..." detail:nil configuration:NULL];
    [SQWebViewController clearWebCacheCompletion:^{
        [[AXPracticalHUD sharedHUD] hide:YES afterDelay:0.5 completion:NULL];
    }];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    // Get the text of text field.
    NSString *text = [textField.text copy];
    // Create an url object with the text string.
    NSURL *URL = [NSURL URLWithString:text];
    
    if (URL) {
        [self.view endEditing:YES];
        
        SQWebViewController *webVC = [[SQWebViewController alloc] initWithURL:URL];
        webVC.showsToolBar = NO;
        if (kCFCoreFoundationVersionNumber >= kCFCoreFoundationVersionNumber_iOS_9_0) {
            webVC.webView.allowsLinkPreview = YES;
        }
        [self.navigationController pushViewController:webVC animated:YES];
    }
    
    return YES;
}
@end
