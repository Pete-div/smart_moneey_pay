import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  final String text;
  final double fontSize;
  final String? fontFamily;
  final FontWeight fontweight;
  Color? color;
  TextAlign? textAlign;
   TextWidget({
    super.key, required this.text, this.fontFamily, required this.fontSize,this.textAlign, required this.fontweight,this.color
  });

  @override
  Widget build(BuildContext context) {
    return Text(text,style:
    TextStyle(
                  fontSize: fontSize,
    fontFamily:fontFamily ?? 'SFRegular',
    fontWeight: fontweight,
    color: color,
                ),
                textAlign:textAlign ?? TextAlign.start,
                );
  }
}
    