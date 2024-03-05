import 'package:flutter/material.dart';
import 'package:smartpay/constants/app_theme/app_color.dart';
import 'package:smartpay/view/widget/text_widget.dart';

class DividerWithText extends StatelessWidget {
  const DividerWithText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
      Expanded(child: Container(
        width: double.infinity,
         height: 0.1,
        color: AppColors.textColor,
      )),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal:5.0),
        child: TextWidget(text: 'OR',
         fontSize: 14,
          fontweight: FontWeight.w400,
          fontFamily: 'SFRegular',
          color: AppColors.textColor,
          ),
      ),
         Expanded(child: Container(
           width: double.infinity,
       height: 0.1,
        color: AppColors.textColor,
         )),
    ],);
  }
}