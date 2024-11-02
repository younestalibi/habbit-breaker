import 'package:flutter/material.dart';

class Dimensions {
  static MediaQueryData? mediaQueryData;
  static double? screenWidth;
  static double? screenHeight;

  void init(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    print(mediaQueryData);
    screenWidth = mediaQueryData!.size.width;
    print(screenWidth);
    screenHeight = mediaQueryData!.size.height;
  }

  static get widthSize {
    return screenWidth;
  }

  static get heightSize {
    return screenHeight;
  }

  static const xxsHeight = SizedBox(height: 8);
  static const xsHeight = SizedBox(height: 16);
  static const smHeight = SizedBox(height: 25);
  static final mdHeight = SizedBox(height: screenHeight! * 0.05);
  static final lgHeight = SizedBox(height: screenHeight! * 0.08);

  static const xxsWidth = SizedBox(width: 8);
  static const xsWidth = SizedBox(width: 16);
  static const smWidth = SizedBox(width: 25);
  static final mdWidth = SizedBox(width: screenWidth! * 0.05);
  static final lgWidth = SizedBox(width: screenWidth! * 0.08);
}
