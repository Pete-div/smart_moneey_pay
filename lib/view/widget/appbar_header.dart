import 'package:flutter/material.dart';
import 'package:smartpay/constants/app_theme/app_color.dart';
import 'package:smartpay/view/widget/text_widget.dart';

class AppBarHeader extends StatelessWidget {
  final bool backButton;
  final String headerTopic;
  final String headerSubTopic;
  const AppBarHeader({
    super.key,
    required this.headerSubTopic,
    required this.headerTopic,
    this.backButton = false
  });

  @override
  Widget build(BuildContext context) {
    return Column(
     crossAxisAlignment: CrossAxisAlignment.start,
     children: [
      const SizedBox(height: 30,),
      if(backButton)
             GestureDetector(
              onTap: (){
                Navigator.of(context).pop();
              },
              child: Image.asset('assets/back_button.png')),
              if(backButton)
              const SizedBox(height: 20,),
        TextWidget(text: headerTopic,
    fontSize: 24, 
    fontweight: FontWeight.bold,
    fontFamily: '',
    ),
    
     const SizedBox(height: 10,),
              TextWidget(text: headerSubTopic,
    fontSize: 14, 
    fontweight: FontWeight.w400,
    fontFamily: '',
    ),
              const SizedBox(height: 40,),
              ],);
  }
}


class AppBarHeaderForgotPassword extends StatelessWidget {
  final String img;
  final String headerTopic;
  final String headerSubTopic;
  final String? headerSubTopic2;
  final String? headerSubTopic3;
  final String? headerSubTopic4;
  const AppBarHeaderForgotPassword({
    super.key,
    required this.headerSubTopic,
this.headerSubTopic2,
this.headerSubTopic3,
    required this.headerTopic,
    this.headerSubTopic4,
    required this.img
  });

  @override
  Widget build(BuildContext context) {
    return Column(
     crossAxisAlignment: CrossAxisAlignment.start,
     children: [
      const SizedBox(height: 50,),
     
             Image.asset(img),
             
              const SizedBox(height: 20,),
        TextWidget(text: headerTopic,
    fontSize: 24, 
    fontweight: FontWeight.w600,
    fontFamily: 'SFPro',
    ),
    
     const SizedBox(height: 10,),
              Row(
                children: [
                  TextWidget(text: headerSubTopic,
                      fontSize: 14, 
                      fontweight: FontWeight.w400,
                      fontFamily: 'SFRegular',
                      ),

                       TextWidget(text: headerSubTopic2 ?? '',
                      fontSize: 14, 
                      fontweight: FontWeight.w600,
                      color: AppColors.secondaryColor,
                      fontFamily: 'SFRegular',
                      ),
                       TextWidget(text: headerSubTopic3 ?? '',
                      fontSize: 14, 
                      fontweight: FontWeight.w400,
                      fontFamily: 'SFRegular',
                      ),
                ],
              ),
                  TextWidget(text: headerSubTopic4 ?? '',
                      fontSize: 14, 
                      fontweight: FontWeight.w400,
                      fontFamily: 'SFRegular',
                      ),
              const SizedBox(height: 30,),
              ],);
  }
}