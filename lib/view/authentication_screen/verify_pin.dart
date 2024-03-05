import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smartpay/constants/app_theme/app_color.dart';
import 'package:smartpay/view/widget/appbar_header.dart';
import 'package:smartpay/view/widget/base_button.dart';
import 'package:smartpay/view/widget/pin_code.dart';
import 'package:smartpay/view/widget/text_widget.dart';
import 'package:smartpay/view_models/auth_vm.dart';


class VerifyPinScreen extends ConsumerStatefulWidget {
  final String email;
  const VerifyPinScreen({super.key,required this.email});

  @override
  ConsumerState<VerifyPinScreen> createState() => _VerifyPinScreenState();
}

class _VerifyPinScreenState extends ConsumerState<VerifyPinScreen> {
    final formKey = GlobalKey<FormState>();
  late TextEditingController codeController;
  bool isActiveButton = false;

   @override
  void initState() {
    final token =ref.read(authViewModel);
    // TODO: implement initState
    super.initState();
    codeController = TextEditingController(text:token.verifyEmailToken );
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
      backgroundColor: Colors.white,
      body:Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              
               AppBarHeader(
                backButton: true,
                headerSubTopic: 'We send a code to (${widget.email}). Enter it \nhere to verify your identity',
                 headerTopic: "Verify it's you"),
                Align(
                    alignment: Alignment.topLeft,
                    child: PinCodeField(
                      controller: codeController,
                      onDone: (code) {
                      
                      },
                    ),
                  ),
                             const SizedBox(height: 30,),
                     Align(
            alignment: Alignment.topCenter,
             child: TextWidget(text: 'Resend Code 30 secs',
                         fontSize: 16, 
                         fontweight: FontWeight.bold,
                         color: AppColors.textColor,
                         fontFamily: 'SFPro',
                         ),
                     ),
              const SizedBox(height: 20,),
               BaseButton(
                            onPress: () {
                                 if (!formKey.currentState!.validate()) {
                  return;
                                 }
                           authVm.verifyEmail(widget.email,codeController.text,context);
                            },
                            borderRadius: 16,
                            bgColor:isActiveButton ? AppColors.primaryColor : AppColors.textColor,
                            text: authVm.isLoading? 'Confirming....':"Confirm",
                            fontFamily: '',
                          ),
                               
            ]),
          ),
        ),
      ) ,
    );
  }
}

