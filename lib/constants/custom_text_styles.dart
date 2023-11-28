import 'package:flutter/material.dart';

class CustomTextStyle {
  CustomTextStyle._();

  static TextStyle largeBlack(BuildContext context) {
    return Theme.of(context).textTheme.titleLarge!.copyWith(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: Colors.black,
        letterSpacing: 1);
  }

  static TextStyle largeRed(BuildContext context) {
    return Theme.of(context).textTheme.titleLarge!.copyWith(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.red,
        );
  }

  static TextStyle largegrey(BuildContext context) {
    return Theme.of(context).textTheme.titleLarge!.copyWith(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: Colors.grey,
        letterSpacing: 1);
  }

  static TextStyle largeWhite(BuildContext context) {
    return Theme.of(context).textTheme.titleLarge!.copyWith(
        fontSize: 25,
        fontWeight: FontWeight.w600,
        color: Colors.white,
        letterSpacing: 1);
  }

  static TextStyle mediumWhite(BuildContext context) {
    return Theme.of(context).textTheme.titleMedium!.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Colors.white,
        letterSpacing: 0.5);
  }

  static TextStyle mediumGrey(BuildContext context) {
    return Theme.of(context).textTheme.titleMedium!.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Colors.grey,
        letterSpacing: 0.5);
  }

  static TextStyle mediumBlack(BuildContext context) {
    return Theme.of(context).textTheme.titleMedium!.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Colors.black,
        letterSpacing: 0.5);
  }

  static TextStyle smallWhite(BuildContext context) {
    return Theme.of(context).textTheme.titleSmall!.copyWith(
        fontSize: 12.0,
        fontWeight: FontWeight.w300,
        color: Colors.white,
        letterSpacing: 0.5);
  }

  static TextStyle smallWhiteBold(BuildContext context) {
    return Theme.of(context).textTheme.titleSmall!.copyWith(
        fontSize: 12.0,
        fontWeight: FontWeight.w600,
        color: Colors.white,
        letterSpacing: 0.5);
  }

  static TextStyle smallBlack(BuildContext context) {
    return Theme.of(context).textTheme.titleSmall!.copyWith(
        fontSize: 14.0,
        fontWeight: FontWeight.w300,
        color: Colors.black,
        letterSpacing: 0.5);
  }

  static TextStyle smallBlackBold(BuildContext context) {
    return Theme.of(context).textTheme.titleSmall!.copyWith(
        fontSize: 12.0,
        fontWeight: FontWeight.w600,
        color: Colors.black,
        letterSpacing: 0.5);
  }

  static TextStyle smallGreyBold(BuildContext context) {
    return Theme.of(context).textTheme.titleSmall!.copyWith(
        fontSize: 12.0,
        fontWeight: FontWeight.w600,
        color: Colors.grey,
        letterSpacing: 0.5);
  }

  // static ThemeData buttonStyle(BuildContext context) {
  //   return ThemeData(
  //     elevatedButtonTheme: const ElevatedButtonThemeData(
  //       style: ButtonStyle(
  //         alignment: Alignment.center,
  //       ),
  //     ),
  //   );
  // }
  // static TextStyle buttonText(BuildContext context) {
  //   return Theme.of(context).textTheme.titleMedium!.copyWith(
  //       fontSize: 13,
  //       fontWeight: FontWeight.w400,
  //       color: Colors.white,
  //       letterSpacing: 0.5);
  // }
}
