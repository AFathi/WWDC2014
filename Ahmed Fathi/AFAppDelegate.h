//
//  AFAppDelegate.h
//  Ahmed Fathi
//
//  Created by Ahmed Fathi on 4/5/14.
//  Copyright (c) 2014 Ahmed Fathi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AFViewController;
@class AFVCYears;
@interface AFAppDelegate : UIResponder <UIApplicationDelegate>
@property (weak, nonatomic) AFViewController *timemachinevc;
@property (weak, nonatomic) AFVCYears *loadyearvc;
@property (strong, nonatomic) UIWindow *window;

@end
