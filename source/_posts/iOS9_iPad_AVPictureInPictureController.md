title: iOS9 iPad 画中画，AVPictureInPictureController使用
date: 2015-12-31 18:05:00
categories: 技术
tags: [iOS9, iPad, 画中画, AVPictureInPictureCo, 使用]
description:
---

```objc
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self avkitPlayer];
}

- (void)avkitPlayer{
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"movie" ofType:@"mp4"];
    self.avPlayer = [AVPlayer playerWithURL:[NSURL fileURLWithPath:path]];
    self.playerlayer = [AVPlayerLayer playerLayerWithPlayer:self.avPlayer];
    self.playerlayer.frame = self.view.bounds;
    if([AVPictureInPictureController isPictureInPictureSupported]){
        _avPictureInPictureController =  [[AVPictureInPictureController alloc] initWithPlayerLayer:self.playerlayer];
        _avPictureInPictureController.delegate = self;
    }
    [self.avPlayer play];
    [self.view.layer addSublayer:self.playerlayer];
    
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    [[AVAudioSession sharedInstance] setActive:YES error:nil];
}


- (IBAction)actionPiPStart:(id)sender {
    if (_avPictureInPictureController.pictureInPictureActive) {
        [_avPictureInPictureController stopPictureInPicture];
    }
    else {
        [_avPictureInPictureController startPictureInPicture];
    }
}

```

