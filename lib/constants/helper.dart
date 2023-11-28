import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Helper {
  static const Color greyTextColor = Color(0xff575757);

//   static const HOME_MENU_ITEM = "Home";
//   static const STORES_MENU_ITEM = "Stores";
//   static const ORDER_MENU_ITEM = "Order";
//   static const PROFILE_MENU_ITEM = "Profile";

//   static IconData getBottomMenuIcon(String name) {
//     if (name == HOME_MENU_ITEM) {
//       return Icons.home;
//     } else if (name == STORES_MENU_ITEM) {
//       return Icons.storefront_sharp;
//     } else if (name == ORDER_MENU_ITEM) {
//       return Icons.receipt_outlined;
//     } else if (name == PROFILE_MENU_ITEM) {
//       return Icons.person_3_outlined;
//     } else {
//       return Icons.home;
//     }
//   }

  static double getHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static double getWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }
}
