//
//  TJFoundationCameraRecordingViewController.m
//  NewProject
//
//  Created by lijianqiang on 2017/5/11.
//  Copyright © 2017年 STV. All rights reserved.
//

#import "TJFoundationCameraRecordingViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>

typedef void(^PropertyChangeBlock)(AVCaptureDevice *captureDevice);

@interface TJFoundationCameraRecordingViewController ()<AVCaptureFileOutputRecordingDelegate>//视频文件输出代理
@property (nonatomic, strong)AVCaptureSession *captureSession;//输入输出设置之间的数据传输
@property (nonatomic, strong)AVCaptureDeviceInput *captureDeviceInput;//从AVCaptureDevice获取输入数据
@property (nonatomic, strong)AVCaptureMovieFileOutput *captureMovieFileOutput;//视频输出流
@property (nonatomic, strong)AVCaptureVideoPreviewLayer *captureVideoPreviewLayer;//相机拍摄预览图层
@property (nonatomic, assign)BOOL enableRotation; //是否允许旋转(注意：视频录制过程中禁止屏幕选转)
@property (nonatomic, assign)CGRect *lastBounds;//旋转前的大小
@property (assign,nonatomic) UIBackgroundTaskIdentifier backgroundTaskIdentifier
;//后台任务标识

@property (nonatomic, strong)AVCaptureStillImageOutput *captureStillImageOutput;//照片输出流

@property (weak, nonatomic) IBOutlet UIView *preView;
@property (weak, nonatomic) IBOutlet UIButton *recorderButton;

@property (weak, nonatomic) IBOutlet UIImageView *focusCursor;//聚焦光标

@end

@implementation TJFoundationCameraRecordingViewController

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self.captureSession stopRunning];
}
-(BOOL)shouldAutorotate{
    return self.enableRotation;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addCaptureSession];
}

- (void)addCaptureSession{
    
    self.captureSession = [[AVCaptureSession alloc] init];
    if ([self.captureSession canSetSessionPreset:AVCaptureSessionPreset1280x720]) {
        self.captureSession.sessionPreset = AVCaptureSessionPreset1280x720;
    }
    //获得输入设备
    AVCaptureDevice *captureDevice=[self getCameraDeviceWithPosition:AVCaptureDevicePositionBack];//取得后置摄像头
    if (!captureDevice) {
        NSLog(@"取得后置摄像头时出现问题.");
        return;
    }
    //添加一个音频输入设备
    AVCaptureDevice *audioCaptureDevice = [[AVCaptureDevice devicesWithMediaType:AVMediaTypeAudio]firstObject];
    NSError *error=nil;
    //根据输入设备初始化设备输入对象，用于获得输入数据
    self.captureDeviceInput=[[AVCaptureDeviceInput alloc]initWithDevice:captureDevice error:&error];
    if (error) {
        NSLog(@"取得设备输入对象时出错，错误原因：%@",error.localizedDescription);
        return;
    }
    AVCaptureDeviceInput *audioCaptureDeviceInput = [[AVCaptureDeviceInput alloc] initWithDevice:audioCaptureDevice error:&error];
    if (error) {
        NSLog(@"取得设备输入对象时出错，错误原因：%@",error.localizedDescription);
        return;
    }
    
    //初始化设备输入对象，用于获得输出数据
    self.captureMovieFileOutput = [[AVCaptureMovieFileOutput alloc] init];
    //将设备输入添加到会话中
    if ([self.captureSession canAddInput:self.captureDeviceInput]) {
        [self.captureSession addInput:self.captureDeviceInput];
        [self.captureSession addInput:audioCaptureDeviceInput];
        AVCaptureConnection *captureConnection = [self.captureMovieFileOutput connectionWithMediaType:AVMediaTypeVideo];
        if ([captureConnection isVideoStabilizationSupported]) {
            captureConnection.preferredVideoStabilizationMode = AVCaptureVideoStabilizationModeAuto;
        }
    }
    //将设备输出添加到会话中
    if ([self.captureSession canAddOutput:self.captureMovieFileOutput]) {
        [self.captureSession addOutput:self.captureMovieFileOutput];
    }
    
    //初始化设备输出对象，用于获得输出数据
    self.captureStillImageOutput = [[AVCaptureStillImageOutput alloc] init];
    NSDictionary *outputSettings = @{AVVideoCodecKey:AVVideoCodecJPEG};
    self.captureStillImageOutput.outputSettings = outputSettings;//输出设置
    //将设备输出添加到会话中
    if ([self.captureSession canAddOutput:self.captureStillImageOutput]) {
        [self.captureSession addOutput:self.captureStillImageOutput];
    }
    
    //创建视频预览层，用于实时展示摄像头状态
    self.captureVideoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.captureSession];
    CALayer *layer = self.preView.layer;
    layer.masksToBounds = YES;
    self.captureVideoPreviewLayer.frame = layer.bounds;
    self.captureVideoPreviewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;//填充模式
    //将视频预览层添加到界面中
    [layer insertSublayer:self.captureVideoPreviewLayer below:self.focusCursor.layer];
    self.enableRotation = YES;
    [self.captureSession startRunning];
    
    [self addNotificationToCaptureDevice:captureDevice];
    [self addGenstureRecognizer];
}

//屏幕旋转时调用视频预览图层的方向
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    AVCaptureConnection *captureConnection = [self.captureVideoPreviewLayer connection];
    captureConnection.videoOrientation = (AVCaptureVideoOrientation)toInterfaceOrientation;
}
////旋转后重新设置大小
- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation{
    self.captureVideoPreviewLayer.frame = self.preView.bounds;
}
- (void)addGenstureRecognizer{
    UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapScreen:)];
    [self.preView addGestureRecognizer:tapGesture];
    
}

-(void)tapScreen:(UITapGestureRecognizer *)tapGesture{
    CGPoint point = [tapGesture locationInView:self.preView];
    //将UI坐标转化为摄像头坐标
    CGPoint cameraPoint = [self.captureVideoPreviewLayer captureDevicePointOfInterestForPoint:point];
    [self setFocusCursorWithPoint:point];
    [self focusWithMode:AVCaptureFocusModeAutoFocus exposureMode:AVCaptureExposureModeAutoExpose atPoint:cameraPoint];
}

/**
 设置聚焦模式
 @param point 聚焦点
 */

- (void)focusWithMode:(AVCaptureFocusMode)focusMode exposureMode:(AVCaptureExposureMode)exposureMode atPoint:(CGPoint)point{
    [self changeDeviceProperty:^(AVCaptureDevice *captureDevice) {
        //设置聚焦
        if ([captureDevice isFocusModeSupported:focusMode]) {
            [captureDevice setFocusMode:AVCaptureFocusModeAutoFocus];
        }
        if ([captureDevice isFocusPointOfInterestSupported]) {
            [captureDevice setFocusPointOfInterest:point];
        }
        //设置曝光
        if ([captureDevice isExposureModeSupported:exposureMode]) {
            [captureDevice setExposureMode:AVCaptureExposureModeAutoExpose];
        }
        if ([captureDevice isExposurePointOfInterestSupported]) {
            [captureDevice setExposurePointOfInterest:point];
        }
    }];
}
/**
 设置聚焦光标位置
 @param point 光标位置
 */
- (void)setFocusCursorWithPoint:(CGPoint)point{
    self.focusCursor.center = point;
    self.focusCursor.transform = CGAffineTransformMakeScale(1.5, 1.5);
    self.focusCursor.alpha = 1.0f;
    [UIView animateWithDuration:1.0f animations:^{
        self.focusCursor.transform = CGAffineTransformIdentity;
        
    }completion:^(BOOL finished) {
        self.focusCursor.alpha=0;
    }];
}


/**输入设备添加通知*/
- (void)addNotificationToCaptureDevice:(AVCaptureDevice *)captureDevice{
    //添加区域改变捕获通知必须先设置允许设备捕获
    [self changeDeviceProperty:^(AVCaptureDevice *captureDevice) {
        captureDevice.subjectAreaChangeMonitoringEnabled = YES;
    }];
    //捕获区域发生改变
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(areaChange:) name:AVCaptureDeviceSubjectAreaDidChangeNotification object:captureDevice];
}
/**移除监测捕获区域通知*/
- (void)removeNotificationFromCaptureDevice:(AVCaptureDevice *)captureDevice{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVCaptureDeviceSubjectAreaDidChangeNotification object:captureDevice];
}
- (void)areaChange:(NSNotification *)notification{
    TJLog(@"捕获区域改变");
}
/**
 *  改变设备属性的统一操作方法
 *
 *  @param propertyChange 属性改变操作
 */
- (void)changeDeviceProperty:(PropertyChangeBlock)propertyChange{
    AVCaptureDevice *captureDevice = [self.captureDeviceInput device ];
    NSError *error = nil;
    //改变设备属性前一定要先调用lockForConfiguration:调用完成后使用unlockForConfiguration方法解锁
    if ([captureDevice lockForConfiguration:&error]) {
        propertyChange(captureDevice);
        [captureDevice unlockForConfiguration];
    }else{
        TJLog(@"设置设备属性过程发生错误，错误信息：%@",error.localizedDescription);
    }
}

/**
 *  取得指定位置的摄像头
 *
 *  @param position 摄像头位置
 *
 *  @return 摄像头设备
 */
- (AVCaptureDevice *)getCameraDeviceWithPosition:(AVCaptureDevicePosition)position{
    NSArray *cameras = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice *camera in cameras) {
        if ([camera position] == position) {
            return camera;
        }
    }
    return nil;
}

- (IBAction)cameraChange:(UIButton *)sender {
    //获取当前摄像头
    AVCaptureDevice *currentDevice = [self.captureDeviceInput device];
    AVCaptureDevicePosition currentPostion = [currentDevice position];
    
    [self removeNotificationFromCaptureDevice:currentDevice];
    AVCaptureDevice *toChangeDevice;
    AVCaptureDevicePosition toChangePostion = AVCaptureDevicePositionFront;
    if (currentPostion == AVCaptureDevicePositionFront || currentDevice == AVCaptureDevicePositionUnspecified) {
        toChangePostion = AVCaptureDevicePositionBack;
    }
    toChangeDevice = [self getCameraDeviceWithPosition:toChangePostion];
    [self addNotificationToCaptureDevice:toChangeDevice];
    //获取要调整的设备输入对象
    AVCaptureDeviceInput *toChangeDeviceInput = [[AVCaptureDeviceInput alloc] initWithDevice:toChangeDevice error:nil];
    //改变会话前一定要开启配置，完成配置后调教配置改变
    [self.captureSession beginConfiguration];
    //移除原有对象
    [self.captureSession removeInput:self.captureDeviceInput];
    if ([self.captureSession canAddInput:toChangeDeviceInput]) {
        [self.captureSession addInput:toChangeDeviceInput];
        self.captureDeviceInput = toChangeDeviceInput;
    }
    //提交会话
    [self.captureSession commitConfiguration];
}
- (IBAction)currentImageAction:(UIButton *)sender {

    AVCaptureConnection *captureConnection = [self.captureStillImageOutput connectionWithMediaType:AVMediaTypeVideo];
    //根据连接取得设备输出
    [self.captureStillImageOutput captureStillImageAsynchronouslyFromConnection:captureConnection completionHandler:^(CMSampleBufferRef imageDataSampleBuffer, NSError *error) {
        if (imageDataSampleBuffer) {
            NSData *imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageDataSampleBuffer];
            UIImage *image = [UIImage imageWithData:imageData];
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
            [self showHint:@"图片存储完成!"];
        }
    }];
}
- (IBAction)flashChange:(UIButton *)sender {
    AVCaptureDevice *device = [self.captureDeviceInput device];
    if ([device hasFlash]) {
        //改变设备属性前一定要先调用lockForConfiguration:调用完成后使用unlockForConfiguration方法解锁
        [device lockForConfiguration:nil];
        if (!device.torchMode ) {
            device.torchMode = AVCaptureTorchModeOn;
        }else{
            device.torchMode = AVCaptureTorchModeOff;
        }
        [device unlockForConfiguration];
    }
}

- (IBAction)recordButton:(UIButton *)sender {
    //根据设备输出获得连接
    AVCaptureConnection *captureConnection = [self.captureMovieFileOutput connectionWithMediaType:AVMediaTypeVideo];
    //根据连接取得设备输出数据
    if (![self.captureMovieFileOutput isRecording]) {
        self.enableRotation = NO;
        
        //预览图层和视频方向保持一致
        captureConnection.videoOrientation = self.captureVideoPreviewLayer.connection.videoOrientation;
        NSString *outputFielPath = [NSTemporaryDirectory() stringByAppendingString:@"recordMovie.mov"];
        NSLog(@"save path is :%@",outputFielPath);
        NSURL *fileUrl = [NSURL fileURLWithPath:outputFielPath];
        NSLog(@"fileUrl:%@",fileUrl);
        //将视频写入文件
        [self.captureMovieFileOutput startRecordingToOutputFileURL:fileUrl recordingDelegate:self];
        
    }else{
        [self.captureMovieFileOutput stopRecording];
    }
}
#pragma mark - 视频输出代理
-(void)captureOutput:(AVCaptureFileOutput *)captureOutput didStartRecordingToOutputFileAtURL:(NSURL *)fileURL fromConnections:(NSArray *)connections{
    [self showHint:@"开始录制"];
    self.enableRotation = NO;
}
-(void)captureOutput:(AVCaptureFileOutput *)captureOutput didFinishRecordingToOutputFileAtURL:(NSURL *)outputFileURL fromConnections:(NSArray *)connections error:(NSError *)error{
    [self showHint:@"视频录制完成！"];
    //视频录入完成之后在后台将视频存储到相簿
    self.enableRotation = YES;
    UIBackgroundTaskIdentifier lastBackgroundTaskIdentifier = self.backgroundTaskIdentifier;
    self.backgroundTaskIdentifier = UIBackgroundTaskInvalid;
    ALAssetsLibrary *assetsLibrary = [[ALAssetsLibrary alloc]init];
    [assetsLibrary writeVideoAtPathToSavedPhotosAlbum:outputFileURL completionBlock:^(NSURL *assetURL, NSError *error) {
        if (error) {
            NSLog(@"保存视频到相簿过程中发生错误，错误信息：%@",error.localizedDescription);
        }
        NSLog(@"outputUrl:%@",outputFileURL);
        [[NSFileManager defaultManager] removeItemAtURL:outputFileURL error:nil];
        if (lastBackgroundTaskIdentifier != UIBackgroundTaskInvalid) {
            [[UIApplication sharedApplication] endBackgroundTask:lastBackgroundTaskIdentifier];
        }
        NSLog(@"成功保存视频到相簿.");[self showHint:@"视频保存成功！"];
    }];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
