import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smartpay/constants/app_theme/app_color.dart';
import 'package:smartpay/view/widget/base_button.dart';
import 'package:smartpay/view/widget/base_textfield.dart';
import 'package:smartpay/view/widget/text_widget.dart';
import 'package:smartpay/view_models/auth_vm.dart';


class KYCScreen extends ConsumerStatefulWidget {
  final String email;
  const KYCScreen({super.key,required this.email});

  @override
  ConsumerState<KYCScreen> createState() => _KYCScreenState();
}

class _KYCScreenState extends ConsumerState<KYCScreen> {
      final formKey = GlobalKey<FormState>();
  TextEditingController countryController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  
  String? countryFlag;
  String? countryName;
  void setCountry(String name, String flagEmoji) {
    countryFlag = flagEmoji;
    countryName = name;
    setState(() {
          countryController.text = "$flagEmoji $name";

    });
   
  }
  @override
  Widget build(BuildContext context) {
    final authVm = ref.watch(authViewModel);
    return  Scaffold(
      body:Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key:formKey ,
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
                  TextWidget(text: 'Tell us a bit',
                   fontSize: 24, 
                   fontweight: FontWeight.bold,
                   fontFamily: 'SFPro',
                   ),
                  TextWidget(text: 'about yourself',
                       fontSize: 24, 
                       fontweight: FontWeight.bold,
                       color: AppColors.secondaryColor,
                       fontFamily: 'SFPro',
                       ),
                ],
              ),
               const SizedBox(height: 30,),
                        CustomTextField(
                          borderRadius: BorderRadius.circular(18),
                          hintText: 'Full name',
            controller: fullNameController,                  
              validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Enter Full name";}
                                         if (!value.contains(' ')) {
                  return 'Please enter your full name with a space';
                }
                      if (value.length<7) {
                  return ' 7 Characters at least';
                      }
                return null;
                                        }
              
                         ),
                         const SizedBox(height: 15,),
                           CustomTextField(
                          borderRadius: BorderRadius.circular(18),
                          hintText: 'Username',
                             controller: userNameController, 
              validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Enter username";}}
              
                         ),
                           const SizedBox(height: 20,),
                                CustomTextField(
                          controller: countryController,
                                                  borderRadius: BorderRadius.circular(18),
            
                          togglePassword: true,
                         toggleIcon:Icons.keyboard_arrow_down_rounded,
                          hintText: "Enter Country",
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter Country";
                            }
                            return null;
                          },
                   
                           onTap: () {
                                  showCountryPicker(
                                    context: context,
            
                                    countryListTheme:  CountryListThemeData(
                                      inputDecoration: InputDecoration(
                                        hintText: 'Search',
                                        prefixIcon:const Icon(Icons.search),
                                        fillColor:const Color(0xffF9FAFB),
                                        border: InputBorder.none,
                                        suffixIcon:Padding(
                                          padding:  EdgeInsets.only(right:20.0,top:8),
                                          child:  GestureDetector(
                                            onTap: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: TextWidget(text: "Cancel",
                                             fontSize: 14,
                                              fontweight: FontWeight.w700
                                              ),
                                          ),
                                        )
                                      ),
                                        borderRadius: const BorderRadius.vertical(
                                            top: Radius.circular(40)),
                                        bottomSheetHeight: 600),
                                    onSelect: (Country country) {
                              
                                    setCountry(country.name,
                                     country.flagEmoji);
                                    },
                                  );
                                },
                        ),
              const SizedBox(height: 15,),
                            CustomTextField(
                            borderRadius: BorderRadius.circular(18), 
              controller: passwordController,         
               obscureText: !authVm.showVerifyPin,
                                    togglePassword: true,
                                    maxLines: 1,
                                    toggleIcon: !authVm.showVerifyPin == true
                                        ? Icons.visibility_off_outlined
                                        : Icons.remove_red_eye_outlined,
                                    toggleFunction: authVm.updateVerifyPinPassword
                                    
                                    ,
                                  
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Enter Password";
                                      }
                                      return null;
                                    },   hintText: 'Password',
                           ),
              const SizedBox(height: 20,),
               BaseButton(
                            onPress: () {
                                 if (!formKey.currentState!.validate()) {
                  return;
                                 }
                          authVm.register(
                            fullNameController.text,
                             userNameController.text,
                              widget.email,
                               passwordController.text, 
                               context,
                                countryName!);
                            },
                            borderRadius: 16,
                            bgColor: AppColors.primaryColor,
                            text: authVm.isLoading? 'Continuing....':"Continue",
                            fontFamily: 'SFPro',
                          ),
                               
            ]),
          ),
        ),
      ) ,
    );
  }
}

