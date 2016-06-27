//
//  ViewController.m
//  WebViewAndTableView
//
//  Created by qiulili on 26/6/16.
//  Copyright © 2016年 qiulili. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIWebViewDelegate>{

float Height;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        UITableViewCell *cell1 = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
        UIImageView * imageview= (UIImageView *)[cell1 viewWithTag:1001];
        return cell1;
    }else{
        UITableViewCell *cell2 = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"cell2" forIndexPath:indexPath];
        UIWebView *webView = (UIWebView *)[cell2 viewWithTag:2001];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"html"];
        [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:path]]];
        webView.delegate = self;
        return cell2;
    }
    return nil;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectZero];
    view.backgroundColor = [UIColor colorWithRed:10.0/255.0 green:240.0/255.0 blue:0.0/255.0 alpha:1];
    view.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 2);
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }else{
        return 50;
    }
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 300;
    }else{
        return Height;
    }
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSString *js = @"function imgAutoFit() { \
    var imgs = document.getElementsByTagName('img'); \
    for (var i = 0; i < imgs.length; ++i) {\
    var img = imgs[i];   \
    img.style.maxWidth = %f;   \
    } \
    }";
    js = [NSString stringWithFormat:js, [UIScreen mainScreen].bounds.size.width - 20];
    [webView stringByEvaluatingJavaScriptFromString:js];
    [webView stringByEvaluatingJavaScriptFromString:@"imgAutoFit()"];
    float htmlHeight= [[webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.scrollHeight"] floatValue];
    Height = htmlHeight;
    [self.tableViewOne reloadData];
}
@end
