import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:smartpay/constants/app_theme/app_color.dart';
import 'package:smartpay/view/authentication_screen/creat_pin_screen.dart';
import 'package:smartpay/view/authentication_screen/forget_password_screen.dart';
import 'package:smartpay/view/authentication_screen/registration_screen.dart';
import 'package:smartpay/view/widget/appbar_header.dart';
import 'package:smartpay/view/widget/base_button.dart';
import 'package:smartpay/view/widget/divider_with_text.dart';
import 'package:smartpay/view/widget/pin_code.dart';
import 'package:smartpay/view/widget/social_mdeia.dart';
import 'package:smartpay/view/widget/text_widget.dart';
import 'package:smartpay/view_models/auth_vm.dart';

class LoginWithPinScreen extends ConsumerStatefulWidget {
  const LoginWithPinScreen({super.key});

  @override
  ConsumerState<LoginWithPinScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginWithPinScreen> {

    final formKey = GlobalKey<FormState>();
     bool isActiveButton = false;
  late TextEditingController codeController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    codeController = TextEditingController();
    codeController.addListener(() {
      final isActiveButton = codeController.text.isNotEmpty;
      this.isActiveButton = isActiveButton;
      setState(() {});
    });
  }

    @override
  void dispose() {
    codeController.dispose();
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
                    key:formKey,

          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              
              const AppBarHeader(
                headerSubTopic: 'Welcome back,Login with your pin',
                 headerTopic: "Hi There!👋"),
            
            
                    Align(
                      alignment: Alignment.topLeft,
                      child: PinCodeField(
                        hideCharacter: true,
                        controller: codeController,
                        hasTextColor: AppColors.secondaryColor,
                        highLightColor: AppColors.secondaryColor,
                        pinBoxDecoration:  ProvidedPinBoxDecoration.underlinedPinBoxDecoration,
                        onDone: (code) {
                        
                        },
                      ),
                    ),
                                       const SizedBox(height: 20,),
              GestureDetector(
                onTap: (){
                   Navigator.pushAndRemoveUntil<dynamic>(
                    context,
                    MaterialPageRoute<dynamic>(
            builder: (BuildContext context) => CreatePinScreen()),
                    
                    (route) => false,
            );
                },
                child: TextWidget(text: 'Create newPin',
                 fontSize: 16, 
                 fontweight: FontWeight.w600,
                 color: AppColors.secondaryColor,
                            fontFamily: 'SFPro',
                  
                 ),
              ),
                                    const SizedBox(height: 30,),
                                  
            
               BaseButton(
                            onPress: () {
                     
             if (!formKey.currentState!.validate()) {
                  return;
             }        
            authVm.loginWithPin(codeController.text, context) ;            
                            },
                            borderRadius: 16,
                            bgColor:isActiveButton ? AppColors.primaryColor : AppColors.textColor,
                            text: authVm.isLoading? 'Signing in....':"Sign In",
                            fontFamily: 'SFPro',
                          ),
                               const SizedBox(height: 15,),
                                                             const DividerWithText(),
            
                                   const SizedBox(height: 20,),
                                    SocialMediaButtons(
                                      googleTap: (){}, appleTap: 
                                      (){}),
                                   const SizedBox(height: 100,),
                                     Padding(
                                       padding: const EdgeInsets.symmetric(vertical:10.0),
                                       child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                        TextWidget(text: "Don't you have an account?",
                                         fontSize: 14, 
                                         fontweight: FontWeight.w400,
                                         fontFamily: 'SFRegular',
                                         ),
                                           GestureDetector(
                                            onTap: (){
                                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const RegistrationScreen()));
                                              
                                            },
                                             child: TextWidget(text: ' Sign up',
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



