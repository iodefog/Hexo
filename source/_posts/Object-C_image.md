title: Object-C图片压缩--像素压缩和非像素压缩
date: 2015-08-05 10:21:00
categories: 技术
tags: 
description:
---


```objc
/*
 *	@brief	压缩图片 @Fire
 *
 *	@param 	originImage 	原始图片
 *	@param 	pc 	是否进行像素压缩
 *	@param 	maxPixel 	压缩后长和宽的最大像素；pc=NO时，此参数无效。
 *	@param 	jc 	是否进行JPEG压缩
 *	@param 	maxKB 	图片最大体积，以KB为单位；jc=NO时，此参数无效。
 *
 *	@return	返回图片的NSData
 */
- (NSData*) compressImage:(UIImage*)originImage PixelCompress:(BOOL)pc MaxPixel:(CGFloat)maxPixel JPEGCompress:(BOOL)jc MaxSize_KB:(CGFloat)maxKB;
```







```objc
- (NSData*) compressImage:(UIImage*)originImage PixelCompress:(BOOL)pc MaxPixel:(CGFloat)maxPixel JPEGCompress:(BOOL)jc MaxSize_KB: (CGFloat)maxKB
{
    /*
     压缩策略： 支持最多921600个像素点
        像素压缩：（调整像素点个数）
            当图片长宽比小于3:1 or 1:3时，图片长和宽最多为maxPixel像素；
            当图片长宽比在3:1 和 1:3之间时，会保证图片像素压缩到921600像素以内；
        JPEG压缩：（调整每个像素点的存储体积）
            默认压缩比0.99;
            如果压缩后的数据仍大于IMAGE_MAX_BYTES，那么将调整压缩比将图片压缩至IMAGE_MAX_BYTES以下。
     策略调整：
        不进行像素压缩，或者增大maxPixel，像素损失越小。
        使用无损压缩，或者增大IMAGE_MAX_BYTES.
     注意：
        jepg压缩比为0.99时，图像体积就能压缩到原来的0.40倍了。
     */
    UIImage * scopedImage = nil;
    NSData * data = nil;
    //CGFloat maxbytes = maxKB * 1024;

    if (originImage == nil) {
        return nil;
    }
    
    if ( pc == YES ) {    //像素压缩
        // 像素数最多为maxPixel*maxPixel个
        CGFloat photoRatio = originImage.size.height / originImage.size.width;
        if ( photoRatio < 0.3333f )
        {                           //解决宽长图的问题
            CGFloat FinalWidth = sqrt ( maxPixel*maxPixel/photoRatio );
            scopedImage = [EncodeUtil convertImage:originImage scope:MAX(FinalWidth, maxPixel)];
        }
        else if ( photoRatio <= 3.0f )
        {                           //解决高长图问题
            scopedImage = [EncodeUtil convertImage:originImage scope: maxPixel];
        }
        else
        {                           //一般图片
            CGFloat FinalHeight = sqrt ( maxPixel*maxPixel*photoRatio );
            scopedImage = [EncodeUtil convertImage:originImage scope:MAX(FinalHeight, maxPixel)];
        }
    }
    else {          //不进行像素压缩
        scopedImage = originImage;
    }
    
    [scopedImage retain];
    
    if ( jc == YES ) {     //JPEG压缩
        data = UIImageJPEGRepresentation(scopedImage, 0.8);
        NSLog(@"data compress with ratio (0.9) : %d KB", data.length/1024);
    }
    else {
        data = UIImageJPEGRepresentation(scopedImage, 1.0);
        NSLog(@"data compress : %d KB", data.length/1024);
    }
    
    [scopedImage release];
    
    return data;
}
```


EncodeUtil.m  实现


```objc
+ (UIImage *)convertImage:(UIImage *)origImage scope:(CGFloat)scope
{
    UIImage *image = nil;
    CGSize size = origImage.size;
    if (size.width < scope && size.height < scope) {
        // do nothing
        image = origImage;
    } else {
        CGFloat length = size.width;
        if (size.width < size.height) {
            length = size.height;
        }
        CGFloat f = scope/length;
        NSInteger nw = size.width * f;
        NSInteger nh = size.height * f;
        if (nw > scope) {
            nw = scope;
        }
        if (nh > scope) {
            nh = scope;
        }

        CGSize newSize = CGSizeMake(nw, nh);
//        CGSize newSize = CGSizeMake(size.width*f, size.height*f);
        
        //
        UIGraphicsBeginImageContext(newSize);
        //UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0f);
        // Tell the old image to draw in this new context, with the desired
        // new size 
        [origImage drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)]; 
        // Get the new image from the context 
        image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext(); 
    }
    return image;
}
```


