import 'package:flutter/material.dart';
import 'package:smartpay/constants/app_theme/app_color.dart';
import 'package:smartpay/view/authentication_screen/reset_password.dart';
import 'package:smartpay/view/widget/appbar_header.dart';
import 'package:smartpay/view/widget/base_button.dart';
import 'package:smartpay/view/widget/base_container.dart';
import 'package:smartpay/view/widget/text_widget.dart';


class VeryEmail extends StatefulWidget {
  const VeryEmail({super.key});

  @override
  State<VeryEmail> createState() => _VeryEmailState();
}

class _VeryEmailState extends State<VeryEmail> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body:Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            const SizedBox(height: 20,),        
            const AppBarHeaderForgotPassword(
              img: 'assets/verify_password.png',
              headerSubTopic: 'Where would you like ',
              headerSubTopic2: "Smartpay",
              headerSubTopic3: " to send your ",
                          headerSubTopic4: "security code?",
          
               headerTopic: "Verify your Identity"),
            
           
                       CustomContainerWidget(
                        borderRadius: BorderRadius.circular(16),
                        height: 88,
                        padding: EdgeInsets.all(15),
                        backgroundColor: Color(0xffF9FAFB),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                          Row(children: [
                                Image.asset('assets/check.png'),
                               const  SizedBox(width: 20,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                            TextWidget(text: "Email",
                             fontSize: 14,
                              fontweight: FontWeight.bold,
                              fontFamily: '',
                              ),
                             const  SizedBox(height: 7,),
                                TextWidget(text: "A*******@mail.com",
                             fontSize: 14,
                              fontweight: FontWeight.w300,
                              fontFamily: '',
                              ),
                          ],)
                          ],),
          
                                                    Image.asset('assets/mail.png'),
          
          
                        ],),
                       ),
          const SizedBox(height: 100,),
             BaseButton(
                          onPress: () {
                           Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const ResetPinScreen()));
                          },
                          borderRadius: 16,
                          bgColor: AppColors.primaryColor,
                          text: "Continue",
                          fontFamily: 'SFPro',
                        ),
                             
          ]),
        ),
      ) ,
    );
  }
}

