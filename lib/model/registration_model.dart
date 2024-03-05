import 'package:smartpay/model/network_response.dart';

class RegistrationRespModel extends EmptyResponse{
  bool? status;
  String? message;
  UserModel? data;

  RegistrationRespModel({this.status, this.message, this.data});

  RegistrationRespModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new UserModel.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class UserModel extends EmptyResponse{
  User? user;
  String? token;

  UserModel({this.user, this.token});

  UserModel.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['token'] = token;
    return data;
  }
}

class User extends EmptyResponse{
  String? fullName;
  String? username;
  String? email;
  String? country;
  String? id;

  User({this.fullName, this.username, this.email, this.country, this.id});

  User.fromJson(Map<String, dynamic> json) {
    fullName = json['full_name'];
    username = json['username'];
    email = json['email'];
    country = json['country'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['full_name'] = fullName;
    data['username'] = username;
    data['email'] = email;
    data['country'] = country;
    data['id'] = id;
    return data;
  }
}
