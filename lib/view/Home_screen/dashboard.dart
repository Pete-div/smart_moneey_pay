import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smartpay/constants/app_theme/app_color.dart';
import 'package:smartpay/view/widget/base_button.dart';
import 'package:smartpay/view/widget/base_container.dart';
import 'package:smartpay/view/widget/text_widget.dart';
import 'package:smartpay/view_models/auth_vm.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardState();
}

class _DashboardState extends ConsumerState<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    final authVm = ref.watch(authViewModel);
    return  Scaffold(
backgroundColor: Colors.white,

      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: TextWidget(text: "Your Secret Message...",
                color:AppColors.textColor ,
                fontFamily: 'SFLightText',
                 fontSize: 15, fontweight: FontWeight.w400),
              ),
                const  SizedBox(height: 20,),
              CustomContainerWidget(
margin: const EdgeInsets.only(left: 25),
                height: 100,
                backgroundColor: Colors.black,
                borderRadius: BorderRadius.only(topLeft: Radius.elliptical(20, 20),topRight: Radius.circular(20),bottomLeft: Radius.elliptical(1,100),bottomRight: Radius.circular(20)),
                elevation: 5,
                padding: const EdgeInsets.symmetric(horizontal:10,vertical: 20),
                child: TextWidget(
                  text: authVm.secretText ?? '',
                   fontSize: 20, 
                   color: Colors.white,
                   fontweight: FontWeight.w700,
                   fontFamily: 'SFPro',
                   textAlign: TextAlign.center,
                   ),
              ),
       const  SizedBox(height: 10,),
                Row(
                  children: [
                    Container(
                               height: 45,
                               width:45,
                               
                                                margin: EdgeInsets.only(left: 5),
                                                     padding: const EdgeInsets.all(1.0),
                                                     decoration: BoxDecoration(
                               shape: BoxShape.circle,
                               border: Border.all(
                                   color: AppColors.secondaryColor,width: 2)),
                                                     child: ClipOval(
                             child: Image.asset("assets/placeholder.jpeg"))),
                             const SizedBox(width: 10,),
                             Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 TextWidget(
                                  text: 'Name: ${authVm.fName}',
                                   fontSize: 12, 
                                   fontweight: FontWeight.w400,
                                   color: AppColors.textColor,
                                   
                                   ),
                                   const SizedBox(height: 2,),
                                   TextWidget(
                                  text: 'ID: ****${authVm.id?.substring(5,10)}',
                                   fontSize: 10, 
                                   fontweight: FontWeight.w400,
                                   color: AppColors.textColor,
                                   
                                   ),
                               ],
                             )
                  ],
                ),
       const  SizedBox(height: 70,),
                 Padding(

                   padding: const EdgeInsets.only(bottom:20.0,left: 60,right: 60),
                   child: BaseButton(
                    
                    onPress:()=>authVm.logout(context),borderRadius: 13,child: TextWidget(
                    text:authVm.isLoading? "Logging Out..":"Logout", 
                    fontSize: 18,
                     fontweight: FontWeight.w700,
                     color: Colors.white,
                     fontFamily: 'SFMedium',
                     ),),
                 )
            ],
          ),
        ),
      ),
    );
  }
}