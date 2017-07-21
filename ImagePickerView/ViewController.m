//
//  ViewController.m
//  ImagePickerView
//
//  Created by Student on 02/05/16.
//  Copyright © 2016 Student. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
-(void)setScroller:(UIScrollView *)scroller{
    _scroller=scroller;
    _scroller.minimumZoomScale=0.2;
    _scroller.maximumZoomScale=3.0;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.imgView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.scroller addSubview:self.imgView];
    self.scroller.delegate=self;

    [self setUpAlert];
}

- (nullable UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imgView;
}
- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(nullable UIView *)view atScale:(CGFloat)scale{
    [self.scroller flashScrollIndicators];
    
}
-(void)setUpAlert{
    self.alert=[UIAlertController alertControllerWithTitle:@"Select Image" message:@"Upload Photo From Here" preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction * camera=[UIAlertAction actionWithTitle:@"Camera" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self handleCamera];
        
        
        
    }];
    
    UIAlertAction * gallery=[UIAlertAction actionWithTitle:@"Image Gallery" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self handleImageGallery];
        
    }];
    
    UIAlertAction * cancel=[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [self.alert addAction:camera];
    [self.alert addAction:gallery];
    [self.alert addAction:cancel];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)selectImagePressed:(UIButton *)sender {
    [self presentViewController:self.alert animated:YES completion:nil];
}
-(void)handleCamera{
    
    UIAlertController * camAlert=[UIAlertController alertControllerWithTitle:@"Error" message:@"Camera is not in the simulator" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * camAct=[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [camAlert addAction:camAct];
    [self presentViewController:camAlert animated:YES completion:nil];
    
//#if TARGET_OS_IPHONE
//    self.imagePicker=[[UIImagePickerController alloc]init];
//    self.imagePicker.sourceType=UIImagePickerControllerSourceTypeCamera;
//    [self presentViewController:self.imagePicker animated:YES completion:nil];
//    
//#endif
    
}
-(void)handleImageGallery{
    self.imagePicker=[[UIImagePickerController alloc]init];
       self.imagePicker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
    self.imagePicker.delegate=self;
        [self presentViewController:self.imagePicker animated:YES completion:nil];
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    NSData * dataImage=UIImageJPEGRepresentation([info objectForKey:@"UIImagePickerControllerOriginalImage"], 1);
    UIImage * img=[[UIImage alloc]initWithData:dataImage];
    [self.imgView setImage:img];
    [self.imgView sizeToFit];
    self.scroller.zoomScale=1.0;
    self.scroller.contentSize=self.imgView.image.size;
    [self.imagePicker dismissViewControllerAnimated:YES completion:nil];
    
}

@end
