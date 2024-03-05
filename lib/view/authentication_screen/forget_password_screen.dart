import 'package:flutter/material.dart';
import 'package:smartpay/constants/app_theme/app_color.dart';
import 'package:smartpay/view/authentication_screen/verify_email.dart';
import 'package:smartpay/view/widget/appbar_header.dart';
import 'package:smartpay/view/widget/base_button.dart';
import 'package:smartpay/view/widget/base_textfield.dart';


class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
      final formKey = GlobalKey<FormState>();
    bool isActiveButton = false;
  late TextEditingController emailController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
      emailController = TextEditingController();
    emailController.addListener(() {
      final isActiveButton = emailController.text.isNotEmpty;
      this.isActiveButton = isActiveButton;
      setState(() {});
    });
  }

    @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body:Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key:formKey ,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              
              const AppBarHeaderForgotPassword(
                img: 'assets/paword_recovery.png',
                headerSubTopic: 'Enter your registered email below to receive \npassword instructions',
                 headerTopic: "Password Recovery"),
              
                          CustomTextField(
                          borderRadius: BorderRadius.circular(18),
                          hintText: 'Email',
                          controller: emailController,
                           validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Enter email";
                                    }
                                    Pattern pattern =
                                        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                    var regex = RegExp(pattern as String);
                                    return (!regex.hasMatch(value))
                                        ? 'Please enter valid email'
                                        : null;
                                  },
                                   keyboardType: TextInputType.emailAddress, 
                         ),
             const  SizedBox(height: 40,),
               BaseButton(
                            onPress: () {
                             Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const VeryEmail()));
                            },
                            borderRadius: 16,
                            bgColor:isActiveButton ? AppColors.primaryColor : AppColors.textColor,                          
                            text: "Send me Email",
                            fontFamily: 'SFPro',
                          ),
                               
            ]),
          ),
        ),
      ) ,
    );
  }
}

