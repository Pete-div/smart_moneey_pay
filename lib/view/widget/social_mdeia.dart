import 'package:flutter/material.dart';
import 'package:smartpay/view/widget/base_container.dart';

class SocialMediaButtons extends StatelessWidget {
  final VoidCallback googleTap;
  final VoidCallback appleTap;
  const SocialMediaButtons({
    super.key, required this.googleTap, required this.appleTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(children: [
    Expanded(child: CustomContainerWidget(
      onTap: googleTap,
      borderRadius: BorderRadius.circular(16),
        backgroundColor: Colors.white,
        padding: const EdgeInsets.all(15),
      elevation: 0.1,
      child: Center(child: Image.asset('assets/google_icon.png')),
    ),),
    const SizedBox(width: 30,),
    Expanded(child: CustomContainerWidget(
      onTap: appleTap,
      borderRadius: BorderRadius.circular(16),
      backgroundColor: Colors.white,
      elevation: 0.1,
          padding: const EdgeInsets.all(15),
      child: Center(child: Image.asset('assets/apple_icon.png')),
    ),),
    
    ],);
  }
}