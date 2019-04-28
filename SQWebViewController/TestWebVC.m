//
//  TestWebVC.m
//  SQWebViewController
//
//  Created by semny on 2019/4/28.
//  Copyright © 2019 AiXing. All rights reserved.
//

#import "TestWebVC.h"

@implementation TestWebVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (AX_WEB_VIEW_CONTROLLER_iOS9_0_AVAILABLE()) {
        self.webView.allowsLinkPreview = YES;
    }
    self.showsNavigationBackBarButtonItemTitle = NO;
    self.navigationBackItem = self.navigationBackBarButtonItem;
    self.navigationCloseItem = self.navigationCloseBarButtonItem;
    
#warning TEST 进度颜色调整
    //    _progressView           = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(MAIN_BOUNDS), 0)];
    self.progressTintColor = UIColor.yellowColor;
    self.trackTintColor = UIColor.lightGrayColor;
    //    [self.view addSubview:_progressView];
}


- (UIBarButtonItem *)navigationBackBarButtonItem {
    UIImage* backItemImage = [UIImage imageNamed:@"black_left"];
    UIGraphicsBeginImageContextWithOptions(backItemImage.size, NO, backItemImage.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0, backItemImage.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    CGRect rect = CGRectMake(0, 0, backItemImage.size.width, backItemImage.size.height);
    CGContextClipToMask(context, rect, backItemImage.CGImage);
    [[self.navigationController.navigationBar.tintColor colorWithAlphaComponent:0.5] setFill];
    CGContextFillRect(context, rect);
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImage* backItemHlImage = newImage?:[UIImage imageNamed:@"black_left"];
    UIButton* backButton = [UIButton buttonWithType:UIButtonTypeSystem];
    NSDictionary *attr = [[UIBarButtonItem appearance] titleTextAttributesForState:UIControlStateNormal];
    NSString *backBarButtonItemTitleString = nil;//self.showsNavigationBackBarButtonItemTitle ? SQWebViewControllerLocalizedString(@"back", @"back") : @"    ";
    if (attr) {
        NSAttributedString *attrStr = nil;
        if (backBarButtonItemTitleString) {
            attrStr = [[NSAttributedString alloc] initWithString:backBarButtonItemTitleString attributes:attr];
        }
        [backButton setAttributedTitle:attrStr forState:UIControlStateNormal];
        UIOffset offset = [[UIBarButtonItem appearance] backButtonTitlePositionAdjustmentForBarMetrics:UIBarMetricsDefault];
        backButton.titleEdgeInsets = UIEdgeInsetsMake(offset.vertical, offset.horizontal, 0, 0);
        backButton.imageEdgeInsets = UIEdgeInsetsMake(offset.vertical, offset.horizontal, 0, 0);
    } else {
        [backButton setTitle:backBarButtonItemTitleString forState:UIControlStateNormal];
        [backButton setTitleColor:self.navigationController.navigationBar.tintColor forState:UIControlStateNormal];
        [backButton setTitleColor:[self.navigationController.navigationBar.tintColor colorWithAlphaComponent:0.5] forState:UIControlStateHighlighted];
        [backButton.titleLabel setFont:[UIFont systemFontOfSize:17]];
    }
    [backButton setImage:backItemImage forState:UIControlStateNormal];
    [backButton setImage:backItemHlImage forState:UIControlStateHighlighted];
    [backButton sizeToFit];
    
    [backButton addTarget:self action:@selector(navigationItemHandleBack:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *navigationBackBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    return navigationBackBarButtonItem;
}

- (UIBarButtonItem *)navigationCloseBarButtonItem {
    //    if (_navigationCloseBarButtonItem) return _navigationCloseBarButtonItem;
    //    if (self.navigationItem.rightBarButtonItem == _doneItem && self.navigationItem.rightBarButtonItem != nil) {
    //        _navigationCloseBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:SQWebViewControllerLocalizedString(@"close", @"close") style:0 target:self action:@selector(doneButtonClicked:)];
    //    } else {
    //        _navigationCloseBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:SQWebViewControllerLocalizedString(@"close", @"close") style:0 target:self action:@selector(navigationIemHandleClose:)];
    //    }
    
    UIBarButtonItem *closeBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"close_icon"] style:UIBarButtonItemStyleDone target:nil action:nil];
    
    
    return closeBtn;
}

- (void)navigationItemHandleBack:(UIBarButtonItem *)sender {
    //#if AX_WEB_VIEW_CONTROLLER_USING_WEBKIT
    //    if ([self.webView canGoBack]) {
    //        _navigation = [self.webView goBack];
    //        return;
    //    }
    //#else
    //    if ([self.webView canGoBack]) {
    //        [self.webView goBack];
    //        return;
    //    }
    //#endif
    [self.navigationController popViewControllerAnimated:YES];
}
@end
