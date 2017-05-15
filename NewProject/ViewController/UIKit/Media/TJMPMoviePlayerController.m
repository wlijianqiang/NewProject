//
//  TJMPMoviePlayerController.m
//  NewProject
//
//  Created by lijianqiang on 2017/5/12.
//  Copyright © 2017年 STV. All rights reserved.
//

#import "TJMPMoviePlayerController.h"
#import <MediaPlayer/MediaPlayer.h>

@interface TJMPMoviePlayerController ()

@property (nonatomic, strong)MPMoviePlayerController *moviePlayer;

@end

@implementation TJMPMoviePlayerController

//-(void)dealloc{
//    [[NSNotificationCenter defaultCenter]removeObserver:self];
//
//}
//
//-(void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    [self addMoviePlayer];
//}
//
////- (void)viewWillDisappear:(BOOL)animated{
////    [super viewWillDisappear:animated];
////    [self.moviePlayer play];
////}
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    // Do any additional setup after loading the view.
//    self.navigationItem.title = @"MPMoviePlayerController";
//    
////    [self addNotification];
//   // [self thumbnailImageRequest];
//}
//
//- (void)addMoviePlayer{
//    
//    NSURL *url = [self getFileUrl];
//    self.moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:url];
//    self.moviePlayer.view.frame = self.view.bounds;
//    self.moviePlayer.view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
//    [self.view addSubview:self.moviePlayer.view];
//    [self.moviePlayer play];
//}
//
///**添加通知监测媒体播放控制器的状态*/
//- (void)addNotification{
//    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
//
//    [notificationCenter addObserver:self selector:@selector(mediaPlayerPlayBackStateChange:) name:MPMoviePlayerPlaybackStateDidChangeNotification object:self.moviePlayer];
//    
//    [notificationCenter addObserver:self selector:@selector(mediaPlayerPlayBackFinished:) name:MPMoviePlayerPlaybackDidFinishNotification object:self.moviePlayer];
//    
//    [notificationCenter addObserver:self selector:@selector(mediaPlayThumbnailRequestFinished:) name:MPMoviePlayerThumbnailImageRequestDidFinishNotification object:self.moviePlayer];
//}
///**获取视频缩略图*/
//- (void)thumbnailImageRequest{
//    //获取1.0s 2.5s的缩略图
//    [self.moviePlayer requestThumbnailImagesAtTimes:@[@1.0,@2.5] timeOption:MPMovieTimeOptionNearestKeyFrame];
//}
///**播放完成*/
//- (void)mediaPlayerPlayBackFinished:(NSNotification *)notification{
//    TJLog(@"播放完成. %ld",self.moviePlayer.playbackState);
//}
//- (void)mediaPlayerPlayBackStateChange:(NSNotification *)notification{
//    
//    switch (self.moviePlayer.playbackState) {
//        case MPMoviePlaybackStatePlaying:
//            TJLog(@"开始播放！");
//            break;
//          case MPMoviePlaybackStatePaused:
//            TJLog(@"播放暂停");
//            break;
//            case MPMoviePlaybackStateStopped:
//            TJLog(@"停止播放");
//            break;
//        default:
//            NSLog(@"播放状态:%li",self.moviePlayer.playbackState);
//            break;
//    }
//}
//
//- (void)mediaPlayThumbnailRequestFinished:(NSNotification *)notification{
//    TJLog(@"视频截图已完成");
////    UIImage *image = notification.userInfo[MPMoviePlayerThumbnailTimeKey];
////    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);//保存图片到相册
//}
///**取得本地文件 @return 文件路径*/
//- (NSURL *)getFileUrl{
//    NSString *urlString = [[NSBundle mainBundle] pathForResource:@"The New Look of OS X Yosemite.mp4" ofType:nil];
//    NSURL *url = [NSURL fileURLWithPath:urlString];
//    return url;
//}
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
#pragma mark - 控制器视图方法
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //播放
    [self.moviePlayer play];
    
    //添加通知
    [self addNotification];
    
    //获取缩略图
    [self thumbnailImageRequest];
}

-(void)dealloc{
    //移除所有通知监控
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark - 私有方法
/**
 *  取得本地文件路径
 *
 *  @return 文件路径
 */
-(NSURL *)getFileUrl{
    NSString *urlStr=[[NSBundle mainBundle] pathForResource:@"The New Look of OS X Yosemite.mp4" ofType:nil];
    NSURL *url=[NSURL fileURLWithPath:urlStr];
    return url;
}

/**
 *  取得网络文件路径
 *
 *  @return 文件路径
 */
-(NSURL *)getNetworkUrl{
    NSString *urlStr=@"http://192.168.1.161/The New Look of OS X Yosemite.mp4";
    urlStr=[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url=[NSURL URLWithString:urlStr];
    return url;
}

/**
 *  创建媒体播放控制器
 *
 *  @return 媒体播放控制器
 */
-(MPMoviePlayerController *)moviePlayer{
    if (!_moviePlayer) {
        NSURL *url=[self getFileUrl];
        _moviePlayer=[[MPMoviePlayerController alloc]initWithContentURL:url];
        _moviePlayer.view.frame=self.view.bounds;
        _moviePlayer.view.autoresizingMask=UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        [self.view addSubview:_moviePlayer.view];
    }
    return _moviePlayer;
}

/**
 *  获取视频缩略图
 */
-(void)thumbnailImageRequest{
    //获取13.0s、21.5s的缩略图
    [self.moviePlayer requestThumbnailImagesAtTimes:@[@13.0,@21.5] timeOption:MPMovieTimeOptionNearestKeyFrame];
}

#pragma mark - 控制器通知
/**
 *  添加通知监控媒体播放控制器状态
 */
-(void)addNotification{
    NSNotificationCenter *notificationCenter=[NSNotificationCenter defaultCenter];
    [notificationCenter addObserver:self selector:@selector(mediaPlayerPlaybackStateChange:) name:MPMoviePlayerPlaybackStateDidChangeNotification object:self.moviePlayer];
    [notificationCenter addObserver:self selector:@selector(mediaPlayerPlaybackFinished:) name:MPMoviePlayerPlaybackDidFinishNotification object:self.moviePlayer];
    [notificationCenter addObserver:self selector:@selector(mediaPlayerThumbnailRequestFinished:) name:MPMoviePlayerThumbnailImageRequestDidFinishNotification object:self.moviePlayer];
    
}

/**
 *  播放状态改变，注意播放完成时的状态是暂停
 *
 *  @param notification 通知对象
 */
-(void)mediaPlayerPlaybackStateChange:(NSNotification *)notification{
    switch (self.moviePlayer.playbackState) {
        case MPMoviePlaybackStatePlaying:
            NSLog(@"正在播放...");
            break;
        case MPMoviePlaybackStatePaused:
            NSLog(@"暂停播放.");
            break;
        case MPMoviePlaybackStateStopped:
            NSLog(@"停止播放.");
            break;
        default:
            NSLog(@"播放状态:%li",self.moviePlayer.playbackState);
            break;
    }
}

/**
 *  播放完成
 *
 *  @param notification 通知对象
 */
-(void)mediaPlayerPlaybackFinished:(NSNotification *)notification{
    NSLog(@"播放完成.%li",self.moviePlayer.playbackState);
}

/**
 *  缩略图请求完成,此方法每次截图成功都会调用一次
 *
 *  @param notification 通知对象
 */
-(void)mediaPlayerThumbnailRequestFinished:(NSNotification *)notification{
    NSLog(@"视频截图完成.");
    UIImage *image=notification.userInfo[MPMoviePlayerThumbnailImageKey];
    //保存图片到相册(首次调用会请求用户获得访问相册权限)
    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
