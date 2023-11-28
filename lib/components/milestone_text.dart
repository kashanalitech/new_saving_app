import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../constants/custom_text_styles.dart';

class MilestoneText extends StatelessWidget {
  const MilestoneText({super.key, this.paddingtop = 0, this.paddingbottom = 0});

  final double paddingtop;
  final double paddingbottom;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: paddingtop, bottom: paddingbottom),
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: 'Here is a list of your milestones  ',
              style: CustomTextStyle.mediumBlack(context),
            ),
            const WidgetSpan(   
              alignment: PlaceholderAlignment.middle,
              child: Icon(
                Icons.emoji_flags,
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
