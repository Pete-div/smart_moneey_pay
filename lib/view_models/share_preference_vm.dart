import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

class DatabaseProvider with ChangeNotifier {
  final Future<SharedPreferences> _pref = SharedPreferences.getInstance();

  String _pin = '';
  String _token = '';
  String _password ='';
  String _email = '';



  String get pin => _pin;
  String get token => _token;
  String get password => _password;
  String get email => _email;

  void savePin({required String pin}) async {
    SharedPreferences value = await _pref;
    value.setString('UserPin', pin);
 
  }

  void savePassword({required String password}) async {
    SharedPreferences value = await _pref;

    value.setString('password', password);
 
  }

  void saveEmail({required String email}) async {
    SharedPreferences value = await _pref;

    value.setString('email', email);
 
  }


   void saveToken({required String token}) async {
    SharedPreferences value = await _pref;

    value.setString('token', token);

  }

  void saveFirstTimer({required int firstimer}) async {
    SharedPreferences value = await _pref;

    value.setInt('Firstimer', firstimer);
  }


  Future<int> getFirstimer() async {
    SharedPreferences prefs = await _pref;
    return prefs.getInt('Firstimer') ?? 0;
  }


  Future<String> getPin() async {
    SharedPreferences value = await _pref;

    if (value.containsKey('UserPin')) {
      String data = value.getString('UserPin')!;
      _pin = data;
      notifyListeners();
      return data;
    } else {
      _pin = '';
      notifyListeners();
      return '';
    }
  }

    Future<String> getPassword() async {
    SharedPreferences value = await _pref;
    if (value.containsKey('password')) {
      String data = value.getString('password')!;
      _password = data;
      notifyListeners();
      return data;
    } else {
      _password = '';
      notifyListeners();
      return '';
    }}


  Future<String> getEmail() async {
    SharedPreferences value = await _pref;
    if (value.containsKey('email')) {
      String data = value.getString('email')!;
      _email = data;
      notifyListeners();
      return data;
    } else {
      _email = '';
      notifyListeners();
      return '';
    }}


   Future<String> getToken() async {
    SharedPreferences value = await _pref;

    if (value.containsKey('token')) {
      String data = value.getString('token')!;
      _token = data;
      notifyListeners();
      return data;
    } else {
      _token = '';
      notifyListeners();
      return '';
    }
  }
void clearDB(BuildContext context) async {
    final value = await _pref;

    value.clear();}


}
