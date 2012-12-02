//
//  MainViewController.h
//  JavaScript
//
//  Created by Ansel on 12-11-27.
//  Copyright (c) 2012年 Ansel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController<UIWebViewDelegate>
{
    NSString *test;
}
-(void)setTest:(NSString *) newtest;
@property (retain, nonatomic) IBOutlet UIWebView *JSwebView;
@end
