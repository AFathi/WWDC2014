//
//  AFViewController.h
//  Ahmed Fathi
//
//  Created by Ahmed Fathi on 4/5/14.
//  Copyright (c) 2014 Ahmed Fathi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <CoreMotion/CoreMotion.h>
@interface AFViewController : UIViewController{
    IBOutlet UIView *timemachineview;
    IBOutlet UIView *parallaxview;
    IBOutlet UILabel *AF;
    IBOutlet UILabel *tm;
    IBOutlet UILabel *tip;
    IBOutlet UIButton *clockbutton;
    IBOutlet UIButton *timemachine;
    IBOutlet UIButton *summaryo;
}
- (IBAction)enter:(id)sender;
- (IBAction)summaryaction:(id)sender;
-(void)hidee;
@end
