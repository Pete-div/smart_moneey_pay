import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smartpay/constants/app_theme/app_color.dart';
import 'package:smartpay/view/authentication_screen/forget_password_screen.dart';
import 'package:smartpay/view/authentication_screen/registration_screen.dart';
import 'package:smartpay/view/widget/appbar_header.dart';
import 'package:smartpay/view/widget/base_button.dart';
import 'package:smartpay/view/widget/base_textfield.dart';
import 'package:smartpay/view/widget/divider_with_text.dart';
import 'package:smartpay/view/widget/social_mdeia.dart';
import 'package:smartpay/view/widget/text_widget.dart';
import 'package:smartpay/view_models/auth_vm.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {

    final formKey = GlobalKey<FormState>();
     bool isActiveButton = false;
  late TextEditingController passwordController;
  late TextEditingController emailController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
      emailController = TextEditingController();
    passwordController = TextEditingController();
    passwordController.addListener(() {
      final isActiveButton = passwordController.text.isNotEmpty;
      this.isActiveButton = isActiveButton;
      setState(() {});
    });
  }

    @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
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
                headerSubTopic: 'Welcome back,Sign into your account',
                 headerTopic: "Hi There!👋"),
                         CustomTextField(
                          borderRadius: BorderRadius.circular(18),   
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
                                              hintText: 'Email',
                         ),
                         const SizedBox(height: 15,),
                           CustomTextField(
                          borderRadius: BorderRadius.circular(18), 
            controller: passwordController,         
             obscureText: authVm.isLoginPasswordShown,
                                  togglePassword: true,
                                  maxLines: 1,
                                  toggleIcon: authVm.isLoginPasswordShown == true
                                      ? Icons.visibility_off_outlined
                                      : Icons.remove_red_eye_outlined,
                                  toggleFunction: authVm.updateStatusPassword
                                  
                                  ,
                                
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Enter Password";
                                    }
                                    return null;
                                  }, 
                                    hintText: 'Password',
                         ),
                           const SizedBox(height: 20,),
              GestureDetector(
                onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const ForgetPasswordScreen()));
                },
                child: TextWidget(text: 'Forget Password',
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
            authVm.login(emailController.text, passwordController.text, context) ;            
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



