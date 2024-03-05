import 'package:flutter/material.dart';
import 'package:smartpay/constants/app_theme/app_color.dart';
import 'package:smartpay/view/authentication_screen/login_screen.dart';
import 'package:smartpay/view/widget/base_button.dart';
import 'package:smartpay/view/widget/text_widget.dart';


class ConfirmationScreen extends StatelessWidget {
  const ConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body:Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Image.asset('assets/successful_hand.png'),
          const SizedBox(height: 15,),
        
          TextWidget(text: 'Congratulations, James',
               fontSize: 24, 
               fontweight: FontWeight.bold,
               color: AppColors.secondaryColor,
               fontFamily: 'SFPro',
               ),
                         const SizedBox(height: 8,),
        
                 TextWidget(text: 'You’ve completed the onboarding, \nyou can start using',
               fontSize: 16, 
               fontweight: FontWeight.w500,
               color: AppColors.secondaryColor,
               textAlign: TextAlign.center,
               fontFamily: 'SFRegular',
               ),
               
        const SizedBox(height: 30,),
           BaseButton(
                        onPress: () {
                         Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const LoginScreen()));
                        },
                        borderRadius: 16,
                        bgColor: AppColors.primaryColor,
                        text: "Get Started",
                        fontFamily: 'SFPro',
                      ),
                           
        ]),
      ) ,
    );
  }
}

