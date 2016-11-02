//
//  SY_PicLableBtn.h
//  Components
//
//  Created by 沈云翔 on 2016/10/31.
//  Copyright © 2016年 shenyunxiang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef  NS_ENUM(NSInteger, PicLabType){
    PicLabTypeNone = 0,     //默认的button
    PicLabTypeTopImage,     //图片在上，文字在下
    PicLabTypeLeftImage,    //图片在左，文字在右
    PicLabTypeRightImage,   //图片在右，文字在左
    PicLabTypeBottomImage   //图片在下，文字在上
};

/**
 可调整图片与文字位置的Button
 */
@interface SY_PicLableBtn : UIButton


/**
 图片与文字的间距
 */
@property(nonatomic, assign) CGFloat    space;

/**
 文字
 */
@property(nonatomic, copy) NSString         *title;

/**
 文字Font
 */
@property(nonatomic, strong) UIFont        *titleFont;

/**
 图片的名字
 */
@property(nonatomic, copy) NSString        *imageStr;

+ (SY_PicLableBtn *)buttonWithPicLabType:(PicLabType)type;



@end
