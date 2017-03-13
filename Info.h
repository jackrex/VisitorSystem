//
//  Info.h
//  KeepExpress
//
//  Created by jackrex on 11/1/2017.
//  Copyright © 2017 jackrex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Info : NSObject

+ (UIImage *)imageByScalingAndCroppingForSize:(CGSize)targetSize sourceImage:(UIImage *)sourceImage;

@end
