//
//  ViewController.h
//  ImagePickerView
//
//  Created by Student on 02/05/16.
//  Copyright © 2016 Student. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate,UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scroller;

@property UIImageView *imgView;
@property UIAlertController * alert;
@property UIImagePickerController * imagePicker;
@end

