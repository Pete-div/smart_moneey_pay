// ignore_for_file: non_constant_identifier_names, no_leading_underscores_for_local_identifiers

import 'dart:async';
import 'package:smartpay/model/get_email_token.dart';
import 'package:smartpay/model/login_model.dart';
import 'package:smartpay/model/network_response.dart';
import 'package:smartpay/model/registration_model.dart';
import 'package:smartpay/model/verify_email_model.dart';
import 'package:smartpay/service/remote/api_endpoints.dart';

import 'http_requests.dart';

AuthRemoteRepo authRemoteRepo = AuthRemoteRepoImp();

abstract class AuthRemoteRepo {
  Future<EmptyResponse> createAccount({
    required String fullName,
    required String deviceName,
    required String username,
    required String email,
    required String lastName,
    required String password,
    required String country,
  });

    Future<EmptyResponse> login({
    required String deviceName,
    required String email,
    required String password,
   
  });

  Future<EmptyResponse> getToken({
    required String email,
  });

  Future<EmptyResponse> verifyToken({
    required String email,
    required String token,
  });
    Future<EmptyResponse> logout(
   
  );

}
class AuthRemoteRepoImp extends AuthRemoteRepo {

  @override
  Future<EmptyResponse> createAccount({
    required String fullName,
    required String deviceName,
    required String username,
    required String email,
    required String password,
    required String lastName,
    required String country,
  }) async {
    final data = {
      "email": email.trim(),
      "username": username,
      "password": password.trim(),
      "full_name": fullName,
      "last_name": lastName,
      "country":country,
      "device_name":deviceName,
    };

    final result = await http.post(
      path: ApiEndPoints.createAccount,
      data: data,
      addAuth: false,
    );

    if (result['status'] ==false) {
      return ErrorResponse.fromJson(result);
    }
    return RegistrationRespModel.fromJson(result);
  }
  
  @override
  Future<EmptyResponse> login({required String deviceName, 
  required String email, required String password}) async{
     final data = {
      "email": email.trim(),
      
      "password": password.trim(),
      
      "last_name": deviceName,
  
      "device_name":deviceName,
    };

    final result = await http.post(
      path: ApiEndPoints.login,
      data: data,
      addAuth: false,
    );

    if (result['status'] ==false) {
      return ErrorResponse.fromJson(result);
    }
    return LoginRespModel.fromJson(result);
  }
  
  @override
  Future<EmptyResponse> getToken({required String email}) async{
       final data = {
          "email":email.trim()

    };

    final result = await http.post(
      path: ApiEndPoints.getEmailToken,
      data: data,
      addAuth: false,
    );

    if (result['status'] ==false) {
      return ErrorResponse.fromJson(result);
    }
    return GetEmailTokenResModel.fromJson(result);
  }
  
  @override
  Future<EmptyResponse> verifyToken({required String email, required String token}) async{
        final data = {
      "email": email.trim(),
      'token':token.toString(),
    };

    final result = await http.post(
      path: ApiEndPoints.verifyEmail,
      data: data,
      addAuth: false,
    );

    if (result['status'] ==false) {
      return ErrorResponse.fromJson(result);
    }
    return VerifyEmailRespModel.fromJson(result);
  }
  
  
  @override
  Future<EmptyResponse> logout() async{
       final data = {

    };

    final result = await http.post(
      path: ApiEndPoints.logout,
      data: data,
      addAuth: false,
    );

    if (result['status'] ==false) {
      return ErrorResponse.fromJson(result);
    }
    return SuccessResponse.fromJson(result);
  }
  





  

}
