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

  static const smHeight = SizedBox(height: 25);
  static final mdHeight = SizedBox(height: screenHeight! * 0.05);
  static final lgHeight = SizedBox(height: screenHeight! * 0.08);
}
