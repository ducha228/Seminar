//
//  ViewController.h
//  GraphicsChart
//
//  Created by DucHa on 5/1/13.
//  Copyright (c) 2013 DucHa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface ViewController : UIViewController <UIWebViewDelegate>
@property(strong, nonatomic) UIWebView *webView;
@property(strong, nonatomic) UIButton *playButton;
@property(strong, nonatomic) AVAudioPlayer *audioPlayer;
@end
