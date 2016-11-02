//
//  SY_PicLableBtn.m
//  Components
//
//  Created by 沈云翔 on 2016/10/31.
//  Copyright © 2016年 shenyunxiang. All rights reserved.
//

#import "SY_PicLableBtn.h"

#define kScreenSize [UIScreen mainScreen].bounds.size
//当设备为Plus时，字体放大1.5倍，其他不变
#define KScaleSize kScreenSize.width > 375 ? 1.5 : 1


@interface SY_PicLableBtn ()

@property(nonatomic, assign) PicLabType    type;

@property(nonatomic, assign) CGSize         charSize;

@property(nonatomic, assign) CGSize         imageSize;



@end


@implementation SY_PicLableBtn

+ (SY_PicLableBtn *)buttonWithPicLabType:(PicLabType)type {
    SY_PicLableBtn *btn = [SY_PicLableBtn buttonWithType:UIButtonTypeCustom];
    btn.type = type;
    [btn setDefaultProperty];
    
    return btn;
}




#pragma mark - Setter 
- (void)setTitle:(NSString *)title {
    if (![title isEqualToString:_title]) {
        _title = title;
        [self setTitle:_title forState:UIControlStateNormal];
        
        self.charSize = [self stringSizeWith:_title Font:self.titleFont];
        
    }
}

- (void)setTitleFont:(UIFont *)titleFont {
    
    if (![_titleFont isEqual:titleFont]) {
        _titleFont = titleFont;
        self.titleLabel.font = _titleFont;
        self.charSize = [self stringSizeWith:self.title Font:_titleFont];
    }
}

- (void)setImageStr:(NSString *)imageStr {
    if (![_imageStr isEqualToString:imageStr]) {
        
        UIImage *image = [UIImage imageNamed:imageStr];
        
        CGFloat imageH = image.size.height + 1 ;
        CGFloat imageW = image.size.width  + 1;
        
        self.imageSize = CGSizeMake(imageW, imageH);
        
        [self setImage:image forState:UIControlStateNormal];
    }
    
    
}

#pragma mark - Private Metahod
//设置默认的属性
- (void)setDefaultProperty{
    self.space = 5;
    self.charSize = CGSizeZero;
    self.titleFont = [UIFont systemFontOfSize:11];
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
}
//计算字符串的size
- (CGSize)stringSizeWith:(NSString *)string Font:(UIFont*)font{
    CGSize size = CGSizeZero;
    
    if (string != nil && font != nil) {
        
        NSMutableParagraphStyle *textStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
        NSDictionary *dic = @{NSFontAttributeName:font,
                              NSParagraphStyleAttributeName:textStyle};

        CGSize tempSize = [string boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)
                                               options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                            attributes:dic
                                               context:nil].size;
        
        size.width = ceilf(tempSize.width) + 1 ;
        size.height = ceilf(tempSize.height) + 1;
        
    }
    
    return size;
}

//计算button的size
- (CGSize)calculateButtonSizeWithImageViewSize:(CGSize)imageViewSize
                                     LableSize:(CGSize)lableSize
                                    PicLabType:(PicLabType)type{
    CGSize buttonSize = CGSizeZero;
    
    if (type == PicLabTypeTopImage || type == PicLabTypeBottomImage) {
        
        buttonSize.width = MAX(imageViewSize.width , lableSize.width);
        buttonSize.height = imageViewSize.height + self.space + lableSize.height;
        
    } else if (type == PicLabTypeLeftImage || type == PicLabTypeRightImage) {
        
        buttonSize.width = imageViewSize.width + self.space + lableSize.width;
        buttonSize.height = MAX(imageViewSize.height, lableSize.height);
        
    }
    
    return buttonSize;
}

//调整ImageView 和 Lable 的布局
- (void)adjustLayout{
    
    if (self.type != PicLabTypeNone) {
        CGSize viewSize = [self calculateButtonSizeWithImageViewSize:self.imageSize
                                                           LableSize:self.charSize
                                                          PicLabType:self.type];
        
        CGPoint imageViewOri ;
        CGPoint lableOri;
        switch (self.type) {
            case PicLabTypeTopImage:
            {
                
                imageViewOri = CGPointMake((viewSize.width - self.imageSize.width)*0.5, 0);
                lableOri     = CGPointMake((viewSize.width - self.charSize.width)*0.5,
                                           self.space + imageViewOri.y + self.imageSize.height);
                
            }
                break;
            case PicLabTypeLeftImage:
            {
                imageViewOri = CGPointMake(0, (viewSize.height - self.imageSize.height) * 0.5);
                lableOri     = CGPointMake(self.space + imageViewOri.x + self.imageSize.width,
                                           (viewSize.height - self.charSize.height)*0.5);
            }
                break;
            case PicLabTypeRightImage:
            {
                lableOri = CGPointMake(0, (viewSize.height - self.charSize.height)*0.5);
                imageViewOri = CGPointMake(self.space + lableOri.x + self.charSize.width,
                                           (viewSize.height - self.imageSize.height)*0.5);
            }
                break;
            case PicLabTypeBottomImage:
            {

                lableOri = CGPointMake((viewSize.width - self.charSize.width)*0.5, 0);
                imageViewOri = CGPointMake((viewSize.width - self.imageSize.width)*0.5,
                                           self.space + lableOri.y + self.charSize.height);
            }
            default:
                break;
        }
        
        self.titleLabel.frame = CGRectMake(lableOri.x, lableOri.y, self.charSize.width, self.charSize.height);
        
        self.imageView.frame = CGRectMake(imageViewOri.x, imageViewOri.y, self.imageSize.width, self.imageSize.height);
        
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, viewSize.width, viewSize.height);
        
        
    }
}


- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    [self adjustLayout];
    
}

@end
