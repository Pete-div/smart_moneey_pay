import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:smartpay/constants/app_theme/app_color.dart';
import 'package:smartpay/view/widget/appbar_header.dart';
import 'package:smartpay/view/widget/base_button.dart';
import 'package:smartpay/view/widget/pin_code.dart';
import 'package:smartpay/view_models/auth_vm.dart';


class CreatePinScreen extends ConsumerStatefulWidget {
  
  const CreatePinScreen({super.key});

  @override
  ConsumerState<CreatePinScreen> createState() => _CreatePinScreenState();
}

class _CreatePinScreenState extends ConsumerState<CreatePinScreen> {
      final formKey = GlobalKey<FormState>();
    late TextEditingController codeController;
  bool isActiveButton = false;
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
              
              const AppBarHeader(
                backButton: true,
                headerSubTopic: 'We use state-of-the-art security measures to \nprotect your information at all times',
                 headerTopic: "Send your pin code"),
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
               
                     const  SizedBox(height: 30,),  
            
               BaseButton(
                            onPress: () {
                               if (!formKey.currentState!.validate()) {
                  return;
                                 }
                             authVm.createPin(codeController.text,context);
                            
                            },
                            borderRadius: 16,
                            bgColor:isActiveButton ? AppColors.primaryColor : AppColors.textColor,
                            text: authVm.isLoading? 'Creating Pin....':"Create Pin",
                            fontFamily: '',
                          ),
                               
            ]),
          ),
        ),
      ) ,
    );
  }
}

