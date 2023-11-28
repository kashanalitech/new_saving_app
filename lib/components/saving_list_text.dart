import 'package:flutter/material.dart';

import '../constants/custom_text_styles.dart';

class SavingListText extends StatelessWidget {
  const SavingListText({super.key, required this.title, this.paddingtop = 0});

  final String title;
  final double paddingtop;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: paddingtop),
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
                text: 'List Of savings made this week  ',
                style: CustomTextStyle.mediumBlack(context)),
            const WidgetSpan(
              alignment: PlaceholderAlignment.middle,
              child: Icon(
                Icons.percent,
                size: 35,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
