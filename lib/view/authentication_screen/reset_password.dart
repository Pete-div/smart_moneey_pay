import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smartpay/constants/app_theme/app_color.dart';
import 'package:smartpay/view/authentication_screen/kyc_screen.dart';
import 'package:smartpay/view/authentication_screen/login_screen.dart';
import 'package:smartpay/view/widget/appbar_header.dart';
import 'package:smartpay/view/widget/base_button.dart';
import 'package:smartpay/view/widget/base_textfield.dart';
import 'package:smartpay/view_models/auth_vm.dart';


class ResetPinScreen extends ConsumerStatefulWidget {
  const ResetPinScreen({super.key});

  @override
  ConsumerState<ResetPinScreen> createState() => _ResetPinScreenState();
}

class _ResetPinScreenState extends ConsumerState<ResetPinScreen> {
    final formKey = GlobalKey<FormState>();
     bool isActiveButton = false;
  late TextEditingController passwordController;
  late TextEditingController cPassword;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
      cPassword = TextEditingController();
    passwordController = TextEditingController();
    cPassword.addListener(() {
      final isActiveButton = cPassword.text.isNotEmpty;
      this.isActiveButton = isActiveButton;
      setState(() {});
    });
  }

    @override
  void dispose() {
    cPassword.dispose();
    passwordController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final authVm = ref.watch(authViewModel);
    return  Scaffold(
      body:Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            
            const AppBarHeader(
              backButton: true,
              headerSubTopic: 'Please, enter a new password below different \nfrom the previous password',
               headerTopic: "Create New Password"),
            
                        CustomTextField(
                        borderRadius: BorderRadius.circular(18),
                        hintText: 'New Password',
                        controller: passwordController,
                           obscureText: authVm.showNewPassword,
                                togglePassword: true,
                                maxLines: 1,
                                toggleIcon: authVm.showNewPassword == true
                                    ? Icons.visibility_off_outlined
                                    : Icons.remove_red_eye_outlined,
                                toggleFunction: authVm.updateNewPassword
                                ,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Enter Password";
                                  }
                                  return null;
                                }
                       ),
                         const  SizedBox(height: 10,),
                        CustomTextField(
                        borderRadius: BorderRadius.circular(18),
                        hintText: 'Confirm Password',
                        controller: cPassword,
                           obscureText: authVm.showConfirmPassword,
                                togglePassword: true,
                                maxLines: 1,
                                toggleIcon: authVm.showConfirmPassword == true
                                    ? Icons.visibility_off_outlined
                                    : Icons.remove_red_eye_outlined,
                                toggleFunction: authVm.updateConfirmNewPassword
                                
                                ,
                              
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Enter Password";
                                  }
                                   if (value != passwordController.text) {
      return 'Passwords do not match';
    }
                                  return null;
                                }
                       ),
                      
       const SizedBox(height: 90,),
             BaseButton(
                          onPress: () {
                            if (!formKey.currentState!.validate()) {
                return;
                }
                 else{          Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const LoginScreen()));
                           } },
                          borderRadius: 16,
                          bgColor:isActiveButton ? AppColors.primaryColor : AppColors.textColor,
                          text: "Create new Password",
                          fontFamily: 'SFPro',
                        ),
                             
          ]),
        ),
      ) ,
    );
  }
}

