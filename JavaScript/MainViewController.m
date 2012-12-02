//
//  MainViewController.m
//  JavaScript
//
//  Created by Ansel on 12-11-27.
//  Copyright (c) 2012年 Ansel. All rights reserved.
//
/*
    Added by hubing 20121202
*/
#import "MainViewController.h"
#include <sys/sysctl.h>

#include <mach/mach.h>
@interface MainViewController ()

@end

@implementation MainViewController
@synthesize JSwebView;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"test String :%@",test);
    JSwebView.backgroundColor = [UIColor clearColor];
    JSwebView.scalesPageToFit = YES;
    JSwebView. delegate = self;
    NSURL * url = [[NSURL alloc] initWithString: @"http://www.google.com.hk/m?gl=CN&hl=zh_CN&source=ihp" ];
    NSURLRequest * request = [[NSURLRequest alloc] initWithURL:url];
    [JSwebView loadRequest:request];
    [url release];
   [request release];
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:3
                                                      target:self
                                                    selector:@selector(onTimer:)
                                                    userInfo:nil
                                                     repeats:YES];
    // Do any additional setup after loading the view from its nib.
}
#pragma mark - ----------UIWebView代理方法------------
- ( void )webViewDidFinishLoad:(UIWebView * )webView {
    
    NSString * currentURL = [webView stringByEvaluatingJavaScriptFromString: @"document.location.href" ];
    NSString * title = [webView stringByEvaluatingJavaScriptFromString: @"document.title" ];
    NSLog(@"\ncurrentURL is:%@,\nTitle is:%@",currentURL,title);
    NSString * js_result = [webView stringByEvaluatingJavaScriptFromString: @"document.getElementsByName('q')[0].value='赵发凯'; " ];
    NSLog(@"js_result is:%@",js_result);
    
//    NSString * js_result2 = [webView stringByEvaluatingJavaScriptFromString: @" document.forms[0].submit(); "];
//    NSLog(@"js_result2 is:%@",js_result2);
//    [webView stringByEvaluatingJavaScriptFromString: @" var script = document.createElement('script'); "
//     " script.type = 'text/javascript'; "
//     " script.text = \"function myFunction() { "
//     " var field = document.getElementsByName('q')[0]; "
//     " field.value='赵发凯'; "
//     " document.forms[0].submit(); "
//     " }\"; "
//     " document.getElementsByTagName('head')[0].appendChild(script); " ];
//    
//    [webView stringByEvaluatingJavaScriptFromString: @" myFunction(); " ];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//MARK: 可用内存
- (double)availableMemory
{
    vm_statistics_data_t vmStats;
    mach_msg_type_number_t infoCount = HOST_VM_INFO_COUNT;
    kern_return_t kernReturn = host_statistics(mach_host_self(),HOST_VM_INFO,(host_info_t)&vmStats,&infoCount);
    if(kernReturn != KERN_SUCCESS)
        {
        return NSNotFound;
        }
    return ((vm_page_size * vmStats.free_count) / 1024.0) / 1024.0;
}


//MARK: 已使用内存
- (double)usedMemory
{
    task_basic_info_data_t taskInfo;
    mach_msg_type_number_t infoCount = TASK_BASIC_INFO_COUNT;
    kern_return_t kernReturn = task_info(mach_task_self(),
                                         TASK_BASIC_INFO, (task_info_t)&taskInfo, &infoCount);
    if(kernReturn != KERN_SUCCESS) {
        return NSNotFound;
    }
    return taskInfo.resident_size / 1024.0 / 1024.0;
}

//MARK: 总的内存为
-(double)totalMemory{
    task_basic_info_data_t taskInfo;
    mach_msg_type_number_t infoCount = TASK_BASIC_INFO_COUNT;
    kern_return_t kernReturn = task_info(mach_task_self(),
                                         TASK_BASIC_INFO, (task_info_t)&taskInfo, &infoCount);
    if(kernReturn != KERN_SUCCESS) {
        return NSNotFound;
    }
    return taskInfo.resident_size / 1024.0 / 1024.0;
}

- (void)onTimer:(id)sender
{
    NSLog(@" 使用内存  %f  剩余内存  %f",[self usedMemory],[self availableMemory]);
}
-(void)setTest:(NSString *) newtest{
    if(test == newtest){
        [test release];
    }
    test = [newtest retain];
}
@end
