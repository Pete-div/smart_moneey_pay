
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smartpay/model/dashboard_model.dart';
import 'package:smartpay/model/get_email_token.dart';
import 'package:smartpay/model/login_model.dart';
import 'package:smartpay/model/network_response.dart';
import 'package:smartpay/model/registration_model.dart';
import 'package:smartpay/model/verify_email_model.dart';
import 'package:smartpay/service/remote/auth_remote_repo.dart';
import 'package:smartpay/service/remote/dashboard_remote_repo.dart';
import 'package:smartpay/utils/app_device_id.dart';
import 'package:smartpay/view/Home_screen/dashboard.dart';
import 'package:smartpay/view/authentication_screen/confirmation_screen.dart';
import 'package:smartpay/view/authentication_screen/creat_pin_screen.dart';
import 'package:smartpay/view/authentication_screen/kyc_screen.dart';
import 'package:smartpay/view/authentication_screen/login_screen.dart';
import 'package:smartpay/view/authentication_screen/verify_pin.dart';
import 'package:smartpay/view_models/share_preference_vm.dart';

import '../service/remote/http_requests.dart';

final authViewModel = ChangeNotifierProvider<AuthModelView>(
  (ref) => AuthModelView(
    ref: ref
  ),
);

class AuthModelView extends ChangeNotifier {
    final ChangeNotifierProviderRef ref;  
  AuthModelView( {required this.ref});
   final GlobalKey<FormState> formKey = GlobalKey<FormState>();
     bool _isLoginPasswordShown = true;
     bool _isLoading = false;
     bool _showVerifyPin = false;
     bool _showNewPin = false;
     bool _showConfirmNewPin = false;
     String? _token;
     String? _dashboardText;
     String? _fName;
     String? _lName;
     String? _userId;


     //getter

     bool  get isLoading =>_isLoading;
     bool get isLoginPasswordShown => _isLoginPasswordShown;
     bool get showVerifyPin => _showVerifyPin;
     bool get showNewPassword => _showNewPin;
     bool get showConfirmPassword => _showConfirmNewPin;
     String? get token => _token;
     String? get secretText => _dashboardText;
     String? get fName => _fName;
     String? get lName => _lName;
     String? get id=>_userId;

   
   //
void updateStatusPassword(){
   _isLoginPasswordShown = !_isLoginPasswordShown;
      notifyListeners();
}
//
void updateVerifyPinPassword(){
   _showVerifyPin = !_showVerifyPin;
      notifyListeners();
}
//
void updateNewPassword(){
   _showNewPin = !_showNewPin;
      notifyListeners();
}

//
void updateConfirmNewPassword(){
   _showConfirmNewPin = !_showConfirmNewPin;
      notifyListeners();
}
//

  void updateLoader(bool state) {
    _isLoading = state;
    notifyListeners();
  }

// REGISTER USER

Future register(String fullName,
String username,String email,String password,
BuildContext context,
String country)async{
  
  updateLoader(true);
  List<String> name =fullName.split('');
  final result =  await authRemoteRepo.createAccount(
    fullName: name[0],
     deviceName:await AppDeviceIdUtil.getId(), 
     username: username, 
     lastName:name[1],
     email: email, 
     password: password, 
     country: country.substring(0,2).toUpperCase());
   updateLoader(false);
    if (result is ErrorResponse) {
    Fluttertoast.showToast(
        msg: result.message ?? '',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
      );
   }
      else if(result is RegistrationRespModel){
        if(result.status == true){
          Fluttertoast.showToast(
        msg:result.message ?? '',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor:Colors.green,
        textColor: Colors.white,
        fontSize: 16.0
      );
             http.setToken(result.data?.token);
      
Navigator.pushAndRemoveUntil<dynamic>(
        context,
        MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => CreatePinScreen()),
        
        (route) => false,
);

        }else{
              Fluttertoast.showToast(
        msg: "Check network connection,try again later.",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Color.fromARGB(255, 40, 33, 47),
        textColor: Colors.white,
        fontSize: 16.0
      );
        }
 updateLoader(false);
}
updateLoader(false);
    
}


// LOGIN USER
Future login(
String email,String password,BuildContext context
)async{
  updateLoader(true);
  final result =  await authRemoteRepo.login(
    deviceName: await AppDeviceIdUtil.getId(), 
    email: email, 
    password: password);
       updateLoader(false);

    if (result is ErrorResponse) { 
    return
    Fluttertoast.showToast(
        msg: result.message ?? '',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
      );
   }
       else if(result is LoginRespModel ){

        if(result.status == true)
        {  Fluttertoast.showToast(
        msg:result.message ?? '',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor:Colors.green,
        textColor: Colors.white,
        fontSize: 16.0
      );
      _fName = result.data?.user?.username;
          _userId = result.data?.user?.id;
         DatabaseProvider().saveFirstTimer(firstimer: 1);
           DatabaseProvider().saveToken(token: result.data!.token!);
            DatabaseProvider().saveEmail(email: email);
             DatabaseProvider().savePassword(password: password);
             http.setToken(result.data?.token);
notifyListeners();
 await dashboard(context);}else{
  
           Fluttertoast.showToast(
        msg: "Check network connection,try again later.",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Color.fromARGB(255, 40, 33, 47),
        textColor: Colors.white,
        fontSize: 16.0
      ); 
 }
   updateLoader(false);

                                        }
                                   updateLoader(false);
    
  
    
}


// GET TOKEN
Future getToken(
String email,
BuildContext context
)async{
  updateLoader(true);
  final result =  await authRemoteRepo.getToken(email: email);
    updateLoader(false);
   if (result is ErrorResponse) {
    Fluttertoast.showToast(
        msg: result.message?? "",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
      );
   }
        else if(result is GetEmailTokenResModel ){
          if(result.status == true){
              _token =  result.data?.token;
         notifyListeners();
          Fluttertoast.showToast(
        msg:result.message ?? '',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor:Colors.green,
        textColor: Colors.white,
        fontSize: 16.0
      );
       Navigator.of(context).push(MaterialPageRoute(
          builder: (context) =>  VerifyPinScreen(email: email,)));
} 
          }else{
             Fluttertoast.showToast(
        msg: "Check network connection,try again later.",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Color.fromARGB(255, 40, 33, 47),
        textColor: Colors.white,
        fontSize: 16.0
      );
          }
          updateLoader(false);
       
}


// VERIFY EMAIL

Future verifyEmail(
String email,
String token,
BuildContext context
)async{
  updateLoader(true);
  final result =  await authRemoteRepo.verifyToken(email: email, token: token);
    updateLoader(false);

   if (result is ErrorResponse) {
    Fluttertoast.showToast(
        msg: result.message ?? '',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
      );
   }
      else if(result is VerifyEmailRespModel){
        if(result.status == true){
                    Fluttertoast.showToast(
        msg:result.message ?? '',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor:Colors.green,
        textColor: Colors.white,
        fontSize: 16.0
      );
         Navigator.of(context).push(MaterialPageRoute(
       builder: (context) =>  KYCScreen(email:email)));
         notifyListeners();
}
        }else{
          Fluttertoast.showToast(
        msg: "Check network connection,try again later.",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Color.fromARGB(255, 40, 33, 47),
        textColor: Colors.white,
        fontSize: 16.0
      );
        }
        updateLoader(false);

    
}

// CREATE PIN

Future createPin(
String token,
BuildContext context
)async{
  updateLoader(true);
  Future.delayed(const Duration(milliseconds: 300)).then((value) => 
        Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const ConfirmationScreen()))

  );
  // SAVE THE PIN IN A SHARREDPREFFERENCE

  DatabaseProvider().savePin(pin: token);
   updateLoader(false);
            Fluttertoast.showToast(
        msg: 'Pin Created!',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor:Colors.green,
        textColor: Colors.white,
        fontSize: 16.0
      );}


loginWithPin(String pin,BuildContext context)async{
  updateLoader(true);
final savedPin = await DatabaseProvider().getPin();
final email = await DatabaseProvider().getEmail();
final password = await DatabaseProvider().getPassword();
print("thie is:: $savedPin");
  if(savedPin == pin){
await login(email, password, context) ;

 }else{
    Fluttertoast.showToast(
        msg: 'Incorrect Pin',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
      );
  }
    updateLoader(false);


}


//  LOGOUT USER
Future logout(
  BuildContext context
)async{
  updateLoader(true);
  final result =  await authRemoteRepo.logout();
    updateLoader(false);

   if (result is ErrorResponse) {
  
    Fluttertoast.showToast(
        msg: result.message ?? '',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
      );
   }
      else if( result is SuccessResponse){
        if(result.message == "success"){
                 Fluttertoast.showToast(
        msg:result.message ?? '',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor:Colors.green,
        textColor: Colors.white,
        fontSize: 16.0
      );
      Navigator.pushAndRemoveUntil<dynamic>(
        context,
        MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => const LoginScreen()),
        
        (route) => false,
); 
DatabaseProvider().clearDB(context);
        }else{
               Fluttertoast.showToast(
        msg: "Check network connection,try again later.",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Color.fromARGB(255, 40, 33, 47),
        textColor: Colors.white,
        fontSize: 16.0
      );
        }
   updateLoader(false);
      }
      updateLoader(false);
      
}


// DASHBOARD
Future dashboard(
  BuildContext context
)async{
  updateLoader(true);
  final result =  await dashboardRepo.dashboard();
      updateLoader(false);

   if (result is ErrorResponse) {
    Fluttertoast.showToast(
        msg: result.message ?? '',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
      );
   }
      else if(result is DashboardResModel){
        if(result.status == true){
                    Fluttertoast.showToast(
        msg:result.message ?? '',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor:Colors.green,
        textColor: Colors.white,
        fontSize: 16.0
      );
_dashboardText = result.data?.secret;        
         notifyListeners();
         Navigator.pushAndRemoveUntil<dynamic>(
        context,
        MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => const DashboardScreen()),
        
        (route) => false,
);
        }else{
             Fluttertoast.showToast(
        msg: "Check network connection,try again later.",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Color.fromARGB(255, 40, 33, 47),
        textColor: Colors.white,
        fontSize: 16.0
      );
        }
        updateLoader(false);

}
updateLoader(false);
    
}
  }