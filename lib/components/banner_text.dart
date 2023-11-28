import 'package:flutter/material.dart';

import '../constants/custom_text_styles.dart';

class BannerText extends StatelessWidget {
  const BannerText({super.key, this.paddingbottom = 0, this.title = ''});

  final double paddingbottom;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: paddingbottom),
      child: Align(
        alignment: Alignment.center,
        child: Text(
          title,
          style: CustomTextStyle.largeBlack(context),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
