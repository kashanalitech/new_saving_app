import 'package:flutter/material.dart';
import 'package:new_saving_app/constants/custom_text_styles.dart';
import 'package:new_saving_app/constants/helper.dart';

class customField extends StatelessWidget {
  const customField({
    super.key,
    this.text,
    this.height,
    this.icon,
    this.align,
    this.controller,
    this.onChanged
  });

  final String? text;
  final double? height;
  final Icon? icon;
  final TextAlign? align;
  final TextEditingController? controller;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        alignment: Alignment.center,
        height: height ?? Helper.getHeight(context) * .07,
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 4,
            ),
          ],
        ),
        child: TextField(
          onChanged: onChanged,
          controller: controller,
          textAlign: align ?? TextAlign.start,
            decoration: InputDecoration(contentPadding: const EdgeInsets.symmetric(horizontal: 10,vertical: 8),
              prefixIcon: icon,
            filled: true,
            fillColor: Colors.transparent,
            hintText: text,
            border: InputBorder.none,
            hintStyle: CustomTextStyle.largeBlack(context)
          ),
        ),
        // alignment: align ?? Alignment.center,
      ),
    );
  }
}
