import 'package:smartpay/constants/keys.dart';


class ApiEndPoints {
    static String get baseUrl => 
    
      AppKeys.baseUrl;

  static const String createAccount = 'auth/register';
  static const String login ="auth/login";
  static const String getEmailToken ='auth/email';
  static const String verifyEmail = "auth/email/verify";
  static const String logout ='auth/logout';
  
  
  //DASHBOARD
  static const String dashboard = "dashboard"; 
}