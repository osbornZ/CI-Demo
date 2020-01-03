# CI-Demo

一个关于CoreImage 框架的相关内容集合。



[CoreImage 概述及简单使用](http://osbornz.github.io/2020/01/02/CoreImage-1/)


#### 扩展
Core Image的自动强图片效果，会分析图像的直方图、图像属性、脸部区域，然后通过一组滤镜来改善图片效果。

	    NSArray *adjustments = [_myImage autoAdjustmentFilters];

* CIFaceBalance
* CIVibrance
* CIToneCurve

[Apple Enhance Doc](https://developer.apple.com/library/archive/documentation/GraphicsImaging/Conceptual/CoreImaging/ci_autoadjustment/ci_autoadjustmentSAVE.html)


