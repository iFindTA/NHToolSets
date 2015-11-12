# NHToolSets
### 开发过程中经常用到的Utils for iOS
#### 如果后续文件过大再考虑分文件处理

##### Usage:
通过Pod搜索：打开终端执行$ Pod Search NHToolSets

##### Info Description:
```
NSString:
/**
 *	@brief	Judging method
 *
 *	@return	whether the string is empty
 */
- (BOOL)isEmpty;

/**
 *	@brief	Judging method
 *
 *	@return	whether only contain numbers
 */
- (BOOL)isOnlyNumbers;

/**
 *	@brief	Judging method
 *
 *	@return	wheter only contain letters
 */
- (BOOL)isOnlyLetters;

/**
 *	@brief	Judging method
 *
 *	@return	whether only contain number or letter
 */
- (BOOL)isNumberOrLetter;

/**
 *	@brief	Hash
 *
 *	@return	md5 hash value
 */
- (NSString *)MD5Hash;

/**
 *	@brief	Hash
 *
 *	@return	sha1 hash value
 */
- (NSString *)SHA1Hash;

/**
 *	@brief	caculate string's size
 *
 *	@param 	font 	string's font
 *	@param 	width 	string's width
 *
 *	@return	the adjust size of string
 */
- (CGSize)sizeThatFitsaWithFont:(UIFont *)font width:(CGFloat)width;

```



```
UIImage:
/**
 *	@brief	Judging Method
 *
 *	@param 	image 	other image
 *
 *	@return	whether only the two image is equal
 */
- (BOOL)isEqualTo:(UIImage *)image;


/**
 *	@brief	generate image
 *
 *	@param 	color 	the image's color
 *
 *	@return	the image from color
 */
+ (UIImage *)imageWithColor:(UIColor *)color;

/**
 *	@brief	generate small image
 *
 *	@param 	bounds 	the destnation image's frame
 *
 *	@return	the cropped image
 */
- (UIImage *)croppedImage:(CGRect)bounds;

/**
 *	@brief	scale image
 *
 *	@param 	dstSize 	the destnation size
 *
 *	@return	the scaled image
 */
- (UIImage*)scaleImageToSize:(CGSize)dstSize;

/**
 *	@brief	create round corner image
 *
 *	@param 	image 	the origin image
 *	@param 	size 	destnation size
 *	@param 	radius 	destnation radius
 *
 *	@return	the round image
 */
- (UIImage *)createRoundedRectImage:(UIImage *)image withSize:(CGSize)size withRadius:(NSInteger)radius;

/**
 *	@brief	generate dark image
 *
 *	@param 	color 	dark color
 *	@param 	level 	dark level
 *
 *	@return	the dark image
 */
- (UIImage *)darkColor:(UIColor *)color lightLevel:(CGFloat)level;
```