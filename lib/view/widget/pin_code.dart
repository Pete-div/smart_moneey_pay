
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:smartpay/constants/app_theme/app_color.dart';

class PinCodeField extends ConsumerWidget {
  final TextEditingController? controller;
  final int maxLength;
  final Function(String)? onTextChanged;
  final Function(String)? onDone;
  final bool hideCharacter;
  final Color? highLightColor;
  final Color? hasTextColor;
  final BoxDecoration Function(Color, Color, {double borderWidth, double radius})? pinBoxDecoration;

  const PinCodeField(
      {Key? key,
      this.controller,
      this.hideCharacter = false,
      this.maxLength = 5,
      this.onTextChanged,
      this.pinBoxDecoration,
      this.hasTextColor,
      this.highLightColor,
      this.onDone})
      : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
  
    return PinCodeTextField(
      errorBorderColor: Colors.red,
      autofocus: true,
      controller: controller,
      hideCharacter: hideCharacter,
      highlightColor: AppColors.secondaryColor,
      defaultBorderColor:highLightColor?? Colors.white,
      hasTextBorderColor:hasTextColor?? Colors.white,
      highlightPinBoxColor: Color(0xF9FAFB),
      maxLength: maxLength,
      onTextChanged: onTextChanged,
      onDone: onDone,
      pinBoxWidth: 57,
      pinBoxHeight: 57,
      pinBoxRadius: 12,
      pinBoxBorderWidth: .5,
      pinBoxOuterPadding: const EdgeInsets.only(right: 8),
      pinBoxColor:Color(0xffF9FAFB) ,
      wrapAlignment: WrapAlignment.spaceAround,
   
      pinBoxDecoration:pinBoxDecoration ??  ProvidedPinBoxDecoration.defaultPinBoxDecoration,
      pinTextStyle:   const  TextStyle(
                  fontSize: 16,
    fontFamily:'SFRegular',
    fontWeight: FontWeight.w600,
    color: AppColors.primaryColor,
                ),
      pinTextAnimatedSwitcherTransition:
          ProvidedPinBoxTextAnimation.scalingTransition,
      pinTextAnimatedSwitcherDuration: const Duration(milliseconds: 300),
      highlightAnimationBeginColor: Colors.black,
      highlightAnimationEndColor: Colors.white12,
      keyboardType: TextInputType.text,
    );
  }
}
