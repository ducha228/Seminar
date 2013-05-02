//
//  ViewController.m
//  GraphicsChart
//
//  Created by DucHa on 5/1/13.
//  Copyright (c) 2013 DucHa. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSString *pathName = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html" inDirectory:@"/"];
    NSString *htmlString = [NSString stringWithContentsOfFile:pathName encoding:NSUTF8StringEncoding error:nil];
    
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSURL *baseUrl = [NSURL fileURLWithPath:path];
    _webView = [[UIWebView alloc] initWithFrame:self.view.frame];
    [_webView loadHTMLString:htmlString baseURL:baseUrl];
    _webView.delegate = self;
    [self.view addSubview:_webView];
    
    _playButton = [[UIButton alloc] initWithFrame:CGRectMake(100, 20, 100, 40)];
    [_playButton setTitle:@"Play" forState:UIControlStateNormal];
    _playButton.backgroundColor = [UIColor darkGrayColor];
    [_playButton addTarget:self action:@selector(playAudio) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_playButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL) webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
}

- (void) playAudio
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"ManchesterUnited" ofType:@"mp3"];
    NSURL *url = [NSURL fileURLWithPath:path];
    _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:NULL];
    [_audioPlayer play];
}
@end
