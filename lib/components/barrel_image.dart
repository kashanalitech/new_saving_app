import 'package:flutter/material.dart';

import '../constants/helper.dart';
// import 'package:saving_app/constants/helper.dart';

class BarrelImage extends StatelessWidget {
  const BarrelImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'images/barrel_saving.png',
      width: Helper.getWidth(context),
      fit: BoxFit.cover,
    );
  }
}
