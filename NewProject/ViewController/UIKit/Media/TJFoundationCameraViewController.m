//
//  TJFoundationCameraViewController.m
//  NewProject
//
//  Created by lijianqiang on 2017/5/5.
//  Copyright © 2017年 STV. All rights reserved.
//

#import "TJFoundationCameraViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>

typedef void(^PropertyChangeBlock)(AVCaptureDevice *captureDevice);

@interface TJFoundationCameraViewController ()

@property (weak, nonatomic) IBOutlet UIView *preView;
@property (nonatomic, strong)AVCaptureSession *captureSession;//输入输出设置之间的数据传输
@property (nonatomic, strong)AVCaptureDeviceInput *captureDeviceInput;//从AVCaptureDevice获取数据
@property (nonatomic, strong)AVCaptureStillImageOutput *captureStillImageOutput;//照片输出流
@property (nonatomic, strong)AVCaptureVideoPreviewLayer *captureVideoPreviewLayer;//拍摄预览图层
@property (weak, nonatomic) IBOutlet UIImageView *focusCursor;//聚焦光标

@end

@implementation TJFoundationCameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addCaptureSession];
}

- (void)addCaptureSession{
    self.captureSession = [[AVCaptureSession alloc] init];
    //分辨率设置
    if ([self.captureSession canSetSessionPreset:AVCaptureSessionPreset1280x720]) {
        self.captureSession.sessionPreset = AVCaptureSessionPreset1280x720;
    }
    //获取输入设备
    AVCaptureDevice *captureDevice = [self getCameraDeviceWithPostion:AVCaptureDevicePositionBack];//后置摄像头
    if (!captureDevice) {
        TJLog(@"选取后置摄像头时有问题！");
        return;
    }
    
    NSError *error = nil;
    //根据输入设备初始化设备输入对象，用于获得输入数据
    self.captureDeviceInput = [[AVCaptureDeviceInput alloc] initWithDevice:captureDevice error:&error];
    if (error) {
        NSLog(@"取得设备输入对象时出错，错误原因：%@",error.localizedDescription);
        return;
    }
    //初始化设备输出对象，用于获得输出数据
    self.captureStillImageOutput = [[AVCaptureStillImageOutput alloc] init];
    NSDictionary *outputSettings = @{AVVideoCodecKey:AVVideoCodecJPEG};
    self.captureStillImageOutput.outputSettings = outputSettings;//输出设置
    //将设备输入添加到会话中
    if ([self.captureSession canAddInput:self.captureDeviceInput]) {
        [self.captureSession addInput:self.captureDeviceInput];
    }
    //将设备输出添加到会话中
    if ([self.captureSession canAddOutput:self.captureStillImageOutput]) {
        [self.captureSession addOutput:self.captureStillImageOutput];
    }
    //创建视频预览层，实时展示摄像头状态
    self.captureVideoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.captureSession];
    CALayer *layer = self.preView.layer;
    layer.masksToBounds = YES;
    self.captureVideoPreviewLayer.frame = layer.bounds;
    self.captureVideoPreviewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;//填充模式
    //视频预览层添加到界面中
//    [layer insertSublayer:self.captureVideoPreviewLayer atIndex:0];
    [layer insertSublayer:self.captureVideoPreviewLayer below:self.focusCursor.layer];
    [self.captureSession startRunning];
    [self addNotificationToCaptureDevice:captureDevice];
}

- (void)addGenstureRecognizer{
    UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapScreen:)];
    [self.preView addGestureRecognizer:tapGesture];

}

-(void)tapScreen:(UITapGestureRecognizer *)tapGesture{
    CGPoint point = [tapGesture locationInView:self.preView];
    //将UI坐标转化为摄像头坐标
    CGPoint cameraPoint = [self.captureVideoPreviewLayer captureDevicePointOfInterestForPoint:point];
    
}
- (void)addNotificationToCaptureDevice:(AVCaptureDevice *)captureDevice{
    //添加区域改变捕获通知必须先设置允许设备捕获
    [self changeDeviceProperty:^(AVCaptureDevice *captureDevice) {
        captureDevice.subjectAreaChangeMonitoringEnabled = YES;
    }];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(areaChange:) name:AVCaptureDeviceSubjectAreaDidChangeNotification object:captureDevice];
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
- (AVCaptureDevice *)getCameraDeviceWithPostion:(AVCaptureDevicePosition)position{
    NSArray *cameras = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice *camera in cameras) {
        if ([camera position] == position) {
            return camera;
        }
    }
    return nil;
}

- (IBAction)flashChange:(UIButton *)sender {
}
- (IBAction)cameraChange:(UIButton *)sender {
}
- (IBAction)takePhoto:(UIButton *)sender {
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
