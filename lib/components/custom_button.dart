import 'package:flutter/material.dart';

import '../constants/custom_text_styles.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.title,
    required this.ontap,
    this.horizontalpadding = 10,
    this.verticalpadding = 9,
    this.toppadding = 10,
    this.bottompadding = 10,
    this.width = 150,
    this.borderRadius = 15,
    this.icon,
  });

  final String title;
  final Function()? ontap;
  final double horizontalpadding;
  final double verticalpadding;
  final double toppadding;
  final double bottompadding;
  final double width;
  final double borderRadius;
  final Icon? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: toppadding, bottom: bottompadding),
      width: width,
      child: ElevatedButton(
        onPressed: ontap,
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            padding: EdgeInsets.symmetric(
                horizontal: horizontalpadding, vertical: verticalpadding),
            backgroundColor: Colors.black54,
            textStyle: CustomTextStyle.mediumWhite(context)),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
              ),
            ),
            if (icon != null) icon!,
          ],
        ),
      ),
    );
  }
}
