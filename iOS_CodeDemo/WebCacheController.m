//
//  WebCacheController.m
//  iOS_CodeDemo
//
//  Created by mac book on 16/8/11.
//  Copyright © 2016年 mac book. All rights reserved.
//


//README.md
//在appdelegate里面注册了NSURLProtocol的继承类，已经做好缓存，断网再次进入会加载缓存
//在appdelegate的方法：
//-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
//有两种缓存方法，分别为国内外不同作者写的，都能缓存，前提是切换缓存方式的时候要卸载app，清除缓存
//webCache
//[NSURLProtocol registerClass:[RNCachingURLProtocol class]];//way1
//[NSURLProtocol registerClass:[CacheURLProtocol class]];//way2


#import "WebCacheController.h"

@interface WebCacheController ()

@end

@implementation WebCacheController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:webView];
    
    [webView loadRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://www.sina.com"]]];
    
}

@end
