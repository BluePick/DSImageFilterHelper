# DSImageFilterHelper
Easy solution for filter images and best fit for custom filter control for photo &amp; video


![](https://github.com/BluePick/DSImageFilterHelper/blob/master/filters.gif)


| Name |  Filter |
| ------ | ------ | 
| Normal | No Filter |
| Chrome | CIPhotoEffectChrome |
| Fade | CIPhotoEffectFade |
| Instant | CIPhotoEffectInstant |
| Mono | CIPhotoEffectMono |
| Noir | CIPhotoEffectNoir |
| Process | CIPhotoEffectProcess |
| Tonal | CIPhotoEffectTonal |
| Transfer | CIPhotoEffectTransfer |
| Tone | CILinearToSRGBToneCurve |
| Linear | CISRGBToneCurveToLinear |

### USE
#### Filter image
```
var imageFilterSet: [ImageFilter]?
DSImageFilterHelper.shared.createFilteredImages(filters: [.normal, .chrome], image: #imageLiteral(resourceName: "Barbie.jpg")) { (imgSet) in
            self.imageFilterSet = imgSet
            // imgSet[1].filter.value --> CIPhotoEffectChrome
            // imgSet[1].filter.name --> Chrome
            // imgSet[1].image --> get filtered image
            // COLLECTION VIEW RELOAD
        }
```



#### Filtered Thumb images

``` 
DSImageFilterHelper.shared.resizeImage(image: #imageLiteral(resourceName: "Barbie.jpg"), resizedSize: CGSize(width: 60, height: 60))
```

```
DSImageFilterHelper.shared.createFilteredImages(filters: Filter.allValues, image: DSImageFilterHelper.shared.resizeImage(image: #imageLiteral(resourceName: "Barbie.jpg"), resizedSize: CGSize(width: 60, height: 60)) ) { (imgSet) in
            self.imageFilterSet = imgSet
            // COLLECTION VIEW RELOAD
        }
```




