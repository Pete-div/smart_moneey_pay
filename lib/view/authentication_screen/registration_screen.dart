import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smartpay/constants/app_theme/app_color.dart';
import 'package:smartpay/view/authentication_screen/login_screen.dart';
import 'package:smartpay/view/widget/base_button.dart';
import 'package:smartpay/view/widget/base_textfield.dart';
import 'package:smartpay/view/widget/divider_with_text.dart';
import 'package:smartpay/view/widget/social_mdeia.dart';
import 'package:smartpay/view/widget/text_widget.dart';
import 'package:smartpay/view_models/auth_vm.dart';

class RegistrationScreen extends ConsumerStatefulWidget {
  const RegistrationScreen({super.key});

  @override
  ConsumerState<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends ConsumerState<RegistrationScreen> {
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

    void dispose() {
    emailController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    // The ViewModel is is initialized here.
    final authVm = ref.watch(authViewModel);
    return  Scaffold(
      body:Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              const SizedBox(height: 30,),
              GestureDetector(
                onTap: ()
                {
                  Navigator.of(context).pop();
                },
                child: Image.asset('assets/back_button.png')),
              const SizedBox(height: 20,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      TextWidget(text: 'Create a ',
                       fontSize: 24, 
                       fontweight: FontWeight.bold,
                       fontFamily: 'SFPro',
                       ),
                       TextWidget(text: 'Smartplay',
                       fontSize: 24, 
                       fontweight: FontWeight.bold,
                       color: AppColors.secondaryColor,
                       fontFamily: 'SFPro',
                       ),
                    ],
                  ),
                  TextWidget(text: 'account',
                       fontSize: 24, 
                       fontweight: FontWeight.bold,
                       fontFamily: 'SFPro',
                       ),
                ],
              ),
              
                         const SizedBox(height: 40,),
                         CustomTextField(
                          borderRadius: BorderRadius.circular(18),
                          controller:emailController ,
                          hintText: 'Email',               
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
                        
                                    const SizedBox(height: 30,),
                                  
            
               BaseButton(
                            onPress: () {
                                 if (!formKey.currentState!.validate()) {
                  return;
                                 }
                               authVm.getToken(emailController.text,context,);
                               
                          
                            },
                            borderRadius: 16,
                            bgColor:isActiveButton ? AppColors.primaryColor : AppColors.textColor,
                            text:authVm.isLoading? 'Signing up....': "Sign Up",
                            fontFamily: 'SFPro',
                          ),
                               const SizedBox(height: 15,),
                                    const DividerWithText(),
                                   const SizedBox(height: 20,),
                                   
                    SocialMediaButtons(googleTap: (){}, appleTap: (){}),
                                   
                                    const SizedBox(height: 90,),
                                     Padding(
                                       padding: const EdgeInsets.symmetric(vertical:10.0),
                                       child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                        TextWidget(text: 'Do you have an account?',
                                         fontSize: 14, 
                                         fontweight: FontWeight.w400,
                                         fontFamily: '',
                                         ),
                                           GestureDetector(
                                            onTap: (){
                                                         Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const LoginScreen()));
                                            },
                                             child: TextWidget(text: 'Sign In',
                                                                                     fontSize: 14, 
                                                                                  fontweight: FontWeight.w600,
                                                                                  color: AppColors.secondaryColor,
                                                                                  fontFamily: 'SFRegular',
                                                                                  ),
                                           ),
                                       
                                                                       ],),
                                     )
            
            ]),
          ),
        ),
      ) ,
    );
  }
}

