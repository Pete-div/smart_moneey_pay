
import 'package:flutter/material.dart';
import 'package:smartpay/view/authentication_screen/login_with_pin.dart';
import 'package:smartpay/view/onboarding_view.dart';
import 'package:smartpay/view_models/share_preference_vm.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

   next() async {
        int firstTimer = await DatabaseProvider().getFirstimer();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Future.delayed(const Duration(seconds: 3)).then((value) async {
           if(firstTimer == 0){
             Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>                      
                                  const OnBoardingView())
                            );                        
      }
           else{
                    Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                          
                                    const LoginWithPinScreen())
                               
                            );
                              
                             
    
            
        
           
           }});});
  }
  
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    next();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset('assets/logo_smartpay.png',),
      ),
    );
  }
}