//
//  Colours.h
//  Cinco
//
//  Created by Rory Watson on 02/01/2014.
//  Copyright (c) 2014 Rory Watson. All rights reserved.
//

#ifndef Cinco_Colours_h
#define Cinco_Colours_h

#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define pantone032 UIColorFromRGB(0xFF3333);
#define pantone130 UIColorFromRGB(0xFFCC33);
#define pantone248 UIColorFromRGB(0x990099);
#define pantone300 UIColorFromRGB(0x0066CC);
#define pantone390 UIColorFromRGB(0x99CC00);
#define pantone423 UIColorFromRGB(0x999999);
#define pantone669 UIColorFromRGB(0x0099CC);
#define pantone3135 UIColorFromRGB(0x333366);
#define pantoneBlack UIColorFromRGB(0x000000);
#define pantoneWhite UIColorFromRGB(0xFFFFFF);

#define debugBool TRUE

#endif
